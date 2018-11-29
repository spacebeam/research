# -*- coding: utf-8 -*-
'''
    Starfruit HTTP base handlers.
'''

# This file is part of starfruit.

# Distributed under the terms of the last AGPL License.
# The full license is in the file LICENCE, distributed as part of this software.

__author__ = 'Team Machine'


import logging
from tornado import gen
from tornado import web
from starfruit import errors


class BaseHandler(web.RequestHandler):
    '''
        System application request handler

        gente d'armi e ganti
    '''

    #@property
    #def sql(self):
        
            #SQL database
        
        #return self.settings['sql']

    #@property
    #def document(self):
        
            #Document database
        
        #return self.application.document

    @property
    def kvalue(self):
        '''
            Key-value database
        '''
        return self.settings['kvalue']

    #@property
    #def cache(self):
        
            #Cache backend
        
        #return self.settings['cache']

    def initialize(self, **kwargs):
        '''
            Initialize the Base Handler
        '''
        super(BaseHandler, self).initialize(**kwargs)
        # System database
        #self.db = self.settings['db']
        self.db = self.settings.get('db')
        self.cache = self.settings.get('cache')
        self.solr = self.settings.get('solr')        
        # Page settings
        self.page_size = self.settings.get('page_size')
        # Call file settings
        self.max_retries = self.settings.get('max_retries')
        self.retry_time = self.settings.get('retry_time')
        self.wait_time = self.settings.get('wait_time')
        # Outbound settings
        self.max_calls = self.settings.get('max_calls')
        self.spool_dir = self.settings.get('spool_dir')
        self.tmp_dir = self.settings.get('tmp_dir')
        self.channel = self.settings.get('channel')
        self.context = self.settings.get('context')
        #

    def set_default_headers(self):
        '''
            Starfruit default headers
        '''
        # if debug set allow all if not set settings domain
        self.set_header("Access-Control-Allow-Origin", self.settings.get('domain', '*'))

    def get_username_cookie(self):
        '''
            Return the username from a secure cookie (require cookie_secret)
        '''
        #return self.get_secure_cookie('username')
        return False

    def get_current_account(self):
        '''
            Return the account from a secure cookie
        '''
        #return self.get_secure_cookie('account')
        return False

    @gen.coroutine
    def let_it_crash(self, struct, scheme, error, reason):
        '''
            Let it crash
        '''
        str_error = str(error)
        error_handler = errors.Error(error)
        messages = []
        # check for error messages
        if error and 'Model' in str_error:
            message = error_handler.model(scheme)
        elif error and 'duplicate' in str_error:
            for name, value in reason.get('duplicates'):
                if value in str_error:
                    message = error_handler.duplicate(
                        name.title(),
                        value,
                        struct.get(value)
                    )
                    messages.append(message)
            message = ({'messages':messages} if messages else False)
        elif error and 'value' in str_error:
            message = error_handler.value()
        elif error is not None:
            logging.warning(str_error)
            logging.error(struct, scheme, error, reason)
            message = {
                'error': u'nonsense',
                'message': u'there is no error'
            }
        else:
            message = {
                'status': 200,
                'message': 'sup bro'
            }
        raise gen.Return(message)
