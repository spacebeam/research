# -*- coding: utf-8 -*-
'''
    Starfruit HTTP call handlers.
'''

# This file is part of starfruit.

# Distributed under the terms of the last AGPL License.
# The full license is in the file LICENCE, distributed as part of this software.

__author__ = 'Team Machine'


import ujson as json
import time
import arrow
from tornado import gen
from tornado import web
import logging
from starfruit.system import calls
from starfruit.tools import content_type_validation
from starfruit.tools import check_json
from starfruit.tools import errors, str2bool
from starfruit.handlers import BaseHandler
from tornado import httpclient
from collections import OrderedDict

httpclient.AsyncHTTPClient.configure('tornado.curl_httpclient.CurlAsyncHTTPClient')
http_client = httpclient.AsyncHTTPClient()


class Handler(calls.Calls, BaseHandler):
    '''
        Call HTTP request handlers
    '''

    @gen.coroutine
    def post(self):
        '''
            Create event
        '''
        struct = yield check_json(self.request.body)
        format_pass = (True if struct and not struct.get('errors') else False)
        if not format_pass:
            self.set_status(400)
            self.finish({'JSON':format_pass})
            return

        # query arguments
        query_args = self.request.arguments

        # get account from struct
        account = struct.get('account', None)
        # get the current gui username
        username = self.get_username_cookie()
        # if the user don't provide an account we use the username as last resort
        account = (query_args.get('account', [username])[0] if not account else account)

        # asterisk dialplan context
        context = 'fun-accounts'

        #test context
        contextdos = '{0}'.format(
            self.context
        )

        # asterisk dialplan extension
        extension = struct['extension']
        # call file priority
        priority = 1        
        # maximum number of retries by generated file, disable default.
        max_retries = 0
        # number of seconds to wait until try again.
        retry_time = 300
        # number of seconds to ring and way for answer.
        wait_time = 30
        # sip trunk, sip carrier, sip channel, etc.
        #channel = 'SIP/authority_1/' # change to dial local
        #channel = 'SIP/codemachine_1/' # change to dial local
        channel = 'SIP/fiorella_1/' # change to dial local
        
        #test channel
        
        # callerid
        caller_id = struct['caller_id']
        #callerid = struct['caller_id']
        # phone_number
        phone_number = struct['phone_number']
        # dial number
        dial_number = ''.join((channel, phone_number))
        # dial extension
        dial_extension = ''.join(('Local/', struct['extension'], '@', context))

        # call file structure
        call_struct = {
            'account': account,
            'caller_id': caller_id,
            'max_retries': max_retries,
            'retry_time': retry_time,
            'wait_time': wait_time,
            'context': context,
            'priority': priority,
            # additional fields?, please check this out!
            'phone_number': phone_number,
            #'caller_id': caller_id
            # 'keyword': keyword,
            # 'first_name': first_name,
            # 'last_name': last_name
        }
        logging.warning('handlers structs')
        logging.warning(call_struct)

        press_flag = struct.get('press_one', False)

        if press_flag == "True":
            # press_one flag enabled
            call_struct['channel'] = dial_number
            call_struct['extension'] = extension
        else:
            # not a press one normal behavior
            call_struct['channel'] = dial_extension
            call_struct['extension'] = phone_number

        call_file = yield self.spawn_call_file(call_struct)


        yield self.chown_file(call_file, self.settings['asterisk_user'], self.settings['asterisk_group'])
        yield self.move_tmp_file(call_file)

        message = 'The request has been fulfilled a new outbound call has been scheduled'

        self.set_status(202)

        self.finish({
            'status': 202,
            'message': message
        })