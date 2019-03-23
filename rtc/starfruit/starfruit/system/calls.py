# -*- coding: utf-8 -*-
'''
    Starfruit calls system logic.
'''

# This file is part of starfruit.

# Distributed under the terms of the last AGPL License.
# The full license is in the file LICENCE, distributed as part of this software.

__author__ = 'Team Machine'



import pwd
import grp
import os
import arrow
import uuid
import logging
from tornado import gen
from shutil import move
from starfruit.system import CallFile
from starfruit.messages import calls
from starfruit.structures.calls import CallMap
from starfruit.tools import clean_structure, clean_results
import ujson as json



class Calls(object):
    '''
        Outbound calls using asterisk callfiles.
    '''


    @gen.coroutine
    def spawn_call_file(self, struct):
        '''
            spawn asterisk .call file
        '''

        call_path = None
        logging.error(struct)

        call = CallFile()
        call_path = call.generate_call(
            self.tmp_dir,
            struct.get('account'),
            struct.get('channel'),
            struct.get('caller_id'),
            struct.get('max_retries'),
            struct.get('retry_time'),
            struct.get('wait_time'),
            struct.get('context'),
            struct.get('extension'),
            struct.get('priority'),
            # -- completed call stuff
            'phone_number=%s' % (struct.get('phone_number')),
            'caller_id=%s' % (struct.get('caller_id')),
            # 'keyword=%s' % (struct.get('keyword')),
            # 'account_uuid=%s' % (struct.get('account_uuid')),
            # 'first_name=%s' % (struct.get('first_name')),
            # 'last_name=%s' % (struct.get('last_name'))
        )
        logging.warning(call_path)
        raise gen.Return(call_path)

    @gen.coroutine
    def chown_file(self, tmp_file, user, group):
        '''
            Chown callfile before move it to spawn directory
        '''
        try:
            uid = pwd.getpwnam(user).pw_uid
            gid = grp.getgrnam(group).gr_gid
            os.chown(tmp_file, uid, gid)
        except Exception, e:
            logging.error(e)

    @gen.coroutine
    def move_tmp_file(self, tmp_file):
        '''
            move tmp .call file to outgoing directory
        '''
        try:
            move(tmp_file, self.spool_dir)
        except Exception, e:
            # return error if any.

            # Python 2.7.X only.
            # Special exception to return a value from a coroutine.

            # In Python >= 3.3, this exception is no longer necessary: 
            # the return statement can be used directly to return a value

            raise gen.Return(e)

    @gen.coroutine
    def get_call_list(self, account, start, end, lapse, page_num):
        '''
            Get call list
        '''
        # Hi there! please add account and status filters, you know the stuff that's right up

        search_index = 'mars'

        # page_num = int(page_num)
        # page_size = self.settings.get('page_size')
        
        call_list = []

        # find_query = {'account':account}

        # if status != 'all':
        #     find_query['status'] = status

        new_start = '{0}Z'.format(arrow.get(start).format('YYYY-MM-DDTHH:mm:ss'))
        new_end = '{0}Z'.format(arrow.get(end).format('YYYY-MM-DDTHH:mm:ss'))

        try:
            
            result = self.kvalue.fulltext_search(search_index, 'start_register:[{0} TO {1}]'.format(new_start, new_end))
            
            call_list = [
                {
                    'uuid': data.get('uuid_register'),
                    'account': data.get('account_register'),
                    'nodetype': data.get('nodetype_register'),
                    'subtype': data.get('subtype_register'),
                    'title': data.get('title_register'),
                    'description': data.get('description_register'),
                    'content': data.get('content_register'),
                    'keywords': data.get('keywords_set'),
                    'start': arrow.get(data.get('start_register')).timestamp,
                    'end': arrow.get(data.get('end_register')).timestamp,
                    'url': data.get('url_register'),
                    'checked': data.get('checked_flag'),
                    'created': data.get('created_register'),
                } for data in result.get('docs')
            ]
        except Exception, e:
            logging.exception(e)
            raise gen.Return(e)

        finally:
            raise gen.Return(call_list)

    @gen.coroutine
    def get_call(self, account, call_uuid):
        '''
            Get call
        '''
        message = None
        search_index = 'mars'
        try:
            result = self.kvalue.fulltext_search(search_index, 'uuid_register:{0}'.format(call_uuid))
            if result:

                data = result.get('docs')[0]

                struct = {
                    'uuid': data.get('uuid_register'),
                    'account': data.get('account_register'),
                    'title': data.get('title_register'),
                    'description': data.get('description_register'),
                    'content': data.get('content_register'),
                    'start': data.get('start_register'),
                    'end': data.get('start_register'),
                    'nodetype': data.get('nodetype_register'),
                    'subtype': data.get('subtype_register'),
                    'url': data.get('url_register'),
                    'keywords': data.get('keywords_set'),
                    'checked': data.get('checked_flag'),
                    'created': data.get('created_register'),
                }

                stochastic = stochastics.Stochastic(struct)
                stochastic.validate()
                message = clean_structure(stochastic)
        except Exception, e:
            logging.exception(e)
            raise e
        finally:
            raise gen.Return(message)

    @gen.coroutine
    def new_call(self, struct):
        '''
            New call
        '''

        bucket_name = 'venus'

        try:
            event = stochastics.Stochastic(struct)
            event.validate()
            event = clean_structure(event)
        except Exception, e:
            raise e

        try:
            message = event.get('uuid')

            result = StochasticMap(
                self.kvalue,
                bucket_name,
                str(event.get('uuid')),
                str(event.get('account')),
                str(event.get('nodetype')),
                str(event.get('subtype')),
                str(event.get('title')),
                str(event.get('descripcion')),
                str(event.get('content')),
                [str(x) for x in event.get('keywords')],
                str(event.get('start')),
                str(event.get('end')),
                str(event.get('url')),
                str(event.get('created')),
                event.get('checked')
            )
        except Exception, e:
            logging.error(e)
            message = str(e)

        raise gen.Return(message)

    @gen.coroutine
    def modify_call(self, account, call_uuid, struct):
        '''
            Modify call
        '''
        message = None
        try:
            result = self.kvalue.fulltext_search('stochastic', 'uuid_register:{0}'.format(call_uuid))
            if result:
                riak_key = str(result['docs'][0].get('_yz_rk'))
                bucket = self.kvalue.bucket_type('capuchins').bucket('{0}'.format('stochastics'))
                bucket.set_properties({'search_index': 'stochastic'})
                stochastic = Map(bucket, riak_key)
                for key in struct:
                    if key is not 'checked' and key is not 'keywords':
                        stochastic.registers['{0}'.format(key)].assign(str(struct.get(key)))
                stochastic.update()
                message = True
        except Exception, e:
            logging.error(e)
            message = str(e)

        raise gen.Return(message)

    @gen.coroutine
    def remove_call(self, account, call_uuid):
        '''
            Remove call
        '''
        message = None
        try:
            result = self.kvalue.fulltext_search('stochastic', 'uuid_register:{0}'.format(call_uuid))
            if result:

                riak_key = str(result['docs'][0].get('_yz_rk'))

                bucket = self.kvalue.bucket_type('capuchins').bucket('{0}'.format('stochastics'))

                obj = bucket.get(riak_key)

                obj.delete()

                message = True
                
        except Exception, e:
            logging.error(e)
            message = str(e)

        raise gen.Return(message)