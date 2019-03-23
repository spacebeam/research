# -*- coding: utf-8 -*-
'''
    This module contains functions and classes to implment AMI scripts in python.
'''

# This file is part of starfruit.

# Distributed under the terms of the last AGPL License. 
# The full license is in the file LICENCE, distributed as part of this software.


import socket
import threading
import Queue
import logging

from cStringIO import StringIO
from types import * # WTF?

# end of line
EOL = '\r\n'


class ManagerException(Exception):
    '''
        Exception/Error!
    '''
    pass


class ManagerSocketException(ManagerException):
    '''
        Socket Exception/Error!
    '''
    pass


class ManagerAuthException(ManagerException):
    '''
        Authorization Exception/Error!
    '''
    pass


class ManagerMessage(object): 
    '''
        Asterisk Manager Protocol Message
    '''
    def __init__(self, response):
        self.response = response  # the raw response, straight from the horse's mouth
        self.data = ''
        self.headers = {}
        # parse the response
        self.parse(response)
        if not self.headers:
            # Bad app not returning any headers.  Let's fake it
            # this could also be the inital greeting
            self.headers['Response'] = 'Generated Header'

    def parse(self, response):
        '''
            Parse a manager message
        '''
        response.seek(0)
        data = []
        # read the response line by line
        for line in response.readlines():
            # strip trailing whitespace
            line = line.rstrip()
            if not line:
                # don't process if this is not a message
                continue
            # locate the ':' in our message, if there is one
            if line.find(':') > -1:
                item = [x.strip() for x in line.split(':',1)]
                # if this is a header
                if len(item) == 2:
                    # store the header
                    self.headers[item[0]] = item[1]
                # otherwise it is just plain data
                else:
                    data.append(line)
            # if there was no ':', then we have data
            else:
                data.append(line)
        # store the data
        self.data = '%s\n' % '\n'.join(data)

    def has_header(self, hname):
        '''
            Check for a header
        '''
        return self.headers.has_key(hname)

    def get_header(self, hname):
        '''
            Return the specfied header
        '''
        return self.headers[hname]

    def __getitem__(self, hname):
        '''
            Return the specfied header
        '''
        return self.headers[hname]

    def __repr__(self):
        return self.headers['Response']


class Event(object):
    '''
        Manager interface Events, __init__ expects and 'Event' message
    '''
    def __init__(self, message):
        # store all of the event data
        self.message = message
        self.data = message.data
        self.headers = message.headers
        # if this is not an event message we have a problem
        if not message.has_header('Event'):
            raise ManagerException('Trying to create event from non event message')
        # get the event name
        self.name = message.get_header('Event')
    
    def has_header(self, hname):
        '''
            Check for a header
        '''
        return self.headers.has_key(hname)

    def get_header(self, hname):
        '''
            Return the specfied header
        '''
        return self.headers[hname]
    
    def __getitem__(self, hname):
        '''
            Return the specfied header
        '''
        return self.headers[hname]
    
    def __repr__(self):
        return self.headers['Event']

    def get_action_id(self):
        return self.headers.get('ActionID',0000)


class Manager(object):
    '''
        Python Interface for Asterisk Manager
    '''

    def __init__(self):
        self._sock = None     # our socket
        self._connected = threading.Event()
        self._running = threading.Event()
        # our hostname
        self.hostname = socket.gethostname()
        # our queues
        self._message_queue = Queue.Queue()
        self._response_queue = Queue.Queue()
        self._event_queue = Queue.Queue()
        # callbacks for events
        self._event_callbacks = {}
        self._reswaiting = []  # who is waiting for a response
        # sequence stuff
        self._seqlock = threading.Lock()
        self._seq = 0
        # some threads
        self.message_thread = threading.Thread(target = self.message_loop)
        self.event_dispatch_thread = threading.Thread(target = self.event_dispatch)
        self.message_thread.setDaemon(True)
        self.event_dispatch_thread.setDaemon(True)

    def __del__(self):
        self.close()

    def connected(self):
        '''
            Check if we are connected or not.
        '''
        return self._connected.isSet()

    def next_seq(self):
        '''
            Return the next number in the sequence, this is used for ActionID
        '''
        self._seqlock.acquire()
        try:
            return self._seq
        finally:
            self._seq += 1
            self._seqlock.release()
        
    def send_action(self, cdict={}, **kwargs):
        '''
            Send a command to the manager
        
            If a list is passed to the cdict argument, each item in the list will
            be sent to asterisk under the same header in the following manner:

            cdict = {"Action": "Originate",
                     "Variable": ["var1=value", "var2=value"]}
            send_action(cdict)
            ...
            Action: Originate
            Variable: var1=value
            Variable: var2=value
        '''
        if not self._connected.isSet():
            raise ManagerException("Not connected")
        # fill in our args
        cdict.update(kwargs)
        # set the action id
        if not cdict.has_key('ActionID'):
            cdict['ActionID'] = '%s-%08x' % (self.hostname, self.next_seq())
        clist = []
        # generate the command
        for key, value in cdict.items():
            if isinstance(value, list):
               for item in value:
                  item = tuple([key, item])
                  clist.append('%s: %s' % item)
            else:
               item = tuple([key, value])
               clist.append('%s: %s' % item)
        clist.append(EOL)
        command = EOL.join(clist)
        # lock the soket and send our command
        try:
            self._sock.sendall(command)
        except socket.error, (errno, reason):
            raise ManagerSocketException(errno, reason)
        self._reswaiting.insert(0,1)
        response = self._response_queue.get()
        self._reswaiting.pop(0)
        if not response:
            raise ManagerSocketException(0, 'Connection Terminated')
        return response

    def _receive_data(self):
        '''
            Read the response from a command.
        '''
        # loop while we are sill running and connected
        while self._running.isSet() and self._connected.isSet():
            lines = []
            try:
                try:
                    # if there is data to be read
                    # read a message
                    while self._connected.isSet():
                        line = []
                        # read a line, one char at a time 
                        while self._connected.isSet():
                            c = self._sock.recv(1)
                            if not c:  # the other end closed the connection
                                self._sock.close()
                                self._connected.clear()
                                break
                            line.append(c)  # append the character to our line
                            # is this the end of a line?
                            if c == '\n':
                                line = ''.join(line)
                                break
                        # if we are no longer connected we probably did not
                        # recieve a full message, don't try to handle it
                        if not self._connected.isSet():
                            break
                        # make sure our line is a string
                        assert type(line) in StringTypes
                        lines.append(line) # add the line to our message
                        # if the line is our EOL marker we have a complete message
                        if line == EOL:
                            break
                        # check to see if this is the greeting line    
                        if line.find('/') >= 0 and line.find(':') < 0:
                            # store the title of the manager we are connecting to
                            self.title = line.split('/')[0].strip()
                            # store the version of the manager we are connecting to
                            self.version = line.split('/')[1].strip()
                            break
                        #sleep(.001)  # waste some time before reading another line
                except socket.error:
                    self._sock.close()
                    self._connected.clear()
                    break
            finally:
                # if we have a message append it to our queue
                if lines and self._connected.isSet():
                    self._message_queue.put(StringIO(''.join(lines)))
                else:
                    self._message_queue.put(None)
    
    def register_event(self, event, function):
        '''
            Register a callback for the specfied event.
            If a callback function returns True, no more callbacks for that
            event will be executed.
        '''
        # get the current value, or an empty list
        # then add our new callback
        current_callbacks = self._event_callbacks.get(event, [])
        current_callbacks.append(function)
        self._event_callbacks[event] = current_callbacks

    def unregister_event(self, event, function):
        '''
            Unregister a callback for the specified event.
        '''
        current_callbacks = self._event_callbacks.get(event, [])
        current_callbacks.remove(function)
        self._event_callbacks[event] = current_callbacks

    def message_loop(self):
        '''
            The method for the event thread.
            This actually recieves all types of messages and places them
            in the proper queues.
        '''
        # start a thread to recieve data
        t = threading.Thread(target=self._receive_data)
        t.setDaemon(True)
        t.start()
        try:
            # loop getting messages from the queue
            while self._running.isSet():
                # get/wait for messages
                data = self._message_queue.get()
                # if we got None as our message we are done
                if not data:
                    # notify the other queues
                    self._event_queue.put(None)
                    for waiter in self._reswaiting:
                        self._response_queue.put(None)
                    break
                # parse the data
                message = ManagerMessage(data)
                # check if this is an event message
                if message.has_header('Event'):
                    self._event_queue.put(Event(message))
                # check if this is a response
                elif message.has_header('Response'):
                    self._response_queue.put(message)
                # this is an unknown message
                else:
                    print 'No clue what we got\n%s' % message.data
        finally:
            # wait for our data receiving thread to exit
            t.join()

    def event_dispatch(self):
        '''
            This thread is responsible fore dispatching events
        '''
        # loop dispatching events
        while self._running.isSet():
            # get/wait for an event
            ev = self._event_queue.get()
            # if we got None as an event, we are finished
            if not ev:
                break
            # dispatch our events
            # first build a list of the functions to execute
            callbacks = self._event_callbacks.get(ev.name, [])
            callbacks.extend(self._event_callbacks.get('*', []))
            # now execute the functions  
            for callback in callbacks:
               if callback(ev, self):
                  break

    def connect(self, host, port=7542):
        '''
            Connect to the manager interface
        '''
        if self._connected.isSet():
            raise ManagerException('Already connected to manager')
        # make sure host is a string
        assert type(host) in StringTypes
        port = int(port)  # make sure port is an int
        logging.info(host, port)
        # create our socket and connect
        try:
            self._sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self._sock.connect((host,port))
        except socket.error, (errno, reason):
            raise ManagerSocketException(errno, reason)
        # we are connected and running
        self._connected.set()
        self._running.set()
        # start the event thread
        self.message_thread.start()
        # start the event dispatching thread
        self.event_dispatch_thread.start()
        # get our initial connection response
        return self._response_queue.get()

    def close(self):
        '''
            Shutdown the connection to the manager
        '''
        # if we are still running, logout
        if self._running.isSet() and self._connected.isSet():
            self.logoff()
        if self._running.isSet():
            # put None in the message_queue to kill our threads
            self._message_queue.put(None)
            # wait for the event thread to exit
            self.message_thread.join()
            # make sure we do not join our self (when close is called from event handlers)
            if threading.currentThread() != self.event_dispatch_thread:
                # wait for the dispatch thread to exit
                self.event_dispatch_thread.join()
        self._running.clear()


    def login(self, username, secret):
        '''
            Login to the manager, throws ManagerAuthException when login falis
        '''
        cdict = {'Action':'Login'}
        cdict['Username'] = username
        cdict['Secret'] = secret
        response = self.send_action(cdict)
        if response.get_header('Response') == 'Error':
           raise ManagerAuthException(response.get_header('Message'))
        return response

    def ping(self):
        '''
            Send a ping action to the manager
        '''
        cdict = {'Action':'Ping'}
        response = self.send_action(cdict)
        return response

    def logoff(self):
        '''
            Logoff from the manager
        '''
        cdict = {'Action':'Logoff'}
        response = self.send_action(cdict)
        return response

    def hangup(self, channel):
        '''
            Hangup the specfied channel
        '''
        cdict = {'Action':'Hangup'}
        cdict['Channel'] = channel
        response = self.send_action(cdict)
        return response

    def status(self, channel = ''):
        '''
            Get a status message from asterisk
        '''
        cdict = {'Action':'Status'}
        cdict['Channel'] = channel
        response = self.send_action(cdict)
        return response

    def redirect(self, channel, exten, priority='1', extra_channel='', context=''):
        '''
            Redirect a channel
        '''
        cdict = {'Action':'Redirect'}
        cdict['Channel'] = channel
        cdict['Exten'] = exten
        cdict['Priority'] = priority
        if context:   cdict['Context']  = context
        if extra_channel: cdict['ExtraChannel'] = extra_channel
        response = self.send_action(cdict)
        return response

    def originate(
            self,
            channel,
            exten,
            context='',
            priority='',
            timeout='',
            caller_id='',
            async=False,
            account='',
            variables={}):
        '''
            Originate a call
        '''
        cdict = {'Action':'Originate'}
        cdict['Channel'] = channel
        cdict['Exten'] = exten
        if context:   cdict['Context']  = context
        if priority:  cdict['Priority'] = priority
        if timeout:   cdict['Timeout']  = timeout
        if caller_id: cdict['CallerID'] = caller_id
        if async:     cdict['Async']    = 'yes'
        if account:   cdict['Account']  = account
        if variables: cvars = ['='.join((str(key), str(value))) for key, value in variables.items()]
        if variables: cdict['Variable'] = cvars
        response = self.send_action(cdict)
        return response

    def mailbox_status(self, mailbox):
        '''
            Get the status of the specfied mailbox
        '''
        cdict = {'Action':'MailboxStatus'}
        cdict['Mailbox'] = mailbox
        response = self.send_action(cdict)
        return response

    def command(self, command):
        '''
            Execute a command
        '''
        cdict = {'Action':'Command'}
        cdict['Command'] = command
        response = self.send_action(cdict)
        return response

    def extension_state(self, exten, context):
        '''
            Get the state of an extension
        '''
        cdict = {'Action':'ExtensionState'}
        cdict['Exten'] = exten
        cdict['Context'] = context
        response = self.send_action(cdict)
        return response

    def absolute_timeout(self, channel, timeout):
        '''
            Set an absolute timeout on a channel
        '''
        cdict = {'Action':'AbsoluteTimeout'}
        cdict['Channel'] = channel
        cdict['Timeout'] = timeout
        response = self.send_action(cdict)
        return response

    def mailbox_count(self, mailbox):
        cdict = {'Action':'MailboxCount'}
        cdict['Mailbox'] = mailbox
        response = self.send_action(cdict)
        return response

    def wait_event(self,  timeout = '-1'):
        '''
            Get a AgentCalled message from asterisk
        '''
        cdict = {'Action':'WaitEvent'}
        cdict['Timeout'] = timeout
        response = self.send_action(cdict)
        return response

    def queue_add(self, queue, interface, membername='', penalty='', paused='', actionid = ''):
        '''
            queue_add

            Adds a queue member to a call queue.
        '''
        cdict = {'Action':'QueueAdd'}
        cdict['Queue'] = queue
        cdict['Interface'] = ''.join(('SIP/', interface))
        if membername:   cdict['MemberName']  = membername
        if penalty: cdict['Penalty'] = penalty
        if paused: cdict['Paused'] = paused
        if actionid: cdict['ActionID'] = actionid
        response = self.send_action(cdict)
        return response

    def queue_pause(self, interface, paused, queue = '', actionid = ''):
        '''
            queue_pause

            Pause member from call queue.
        '''
        cdict = {'Action':'QueuePause'}
        cdict['Interface'] = ''.join(('SIP/', interface))
        cdict['Paused'] = paused
        if queue:   cdict['Queue']  = queue
        if actionid: cdict['ActionID'] = actionid
        response = self.send_action(cdict)
        return response

    def queue_remove(self, queue, interface, actionid = ''):
        '''
            queue_remove

            Adds a queue member to a call queue.
        '''
        cdict = {'Action':'QueueRemove'}
        cdict['Queue'] = queue
        cdict['Interface'] = ''.join(('SIP/', interface))
        if actionid: cdict['ActionID'] = actionid
        response = self.send_action(cdict)
        return response

    def queue_summary(self, queue, actionid = ''):
        '''
            queue_summary
        
            Show queue summary
        '''
        cdict = {'Action':'QueueSummary'}
        cdict['Queue'] = queue
        if actionid: cdict['ActionID'] = actionid
        response = self.send_action(cdict)
        return response