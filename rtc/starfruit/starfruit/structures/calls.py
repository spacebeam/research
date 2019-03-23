# -*- coding: utf-8 -*-
'''
    Starfruit call CRDT's.
'''

# This file is part of starfruit.

# Distributed under the terms of the last AGPL License.
# The full license is in the file LICENCE, distributed as part of this software.

__author__ = 'Team Machine'


import riak
import logging
import ujson as json
from riak.datatypes import Map


class CallMap(object):

    def __init__(
        self,
        client,
        bucket_name,
        uuid,
        account,
        nodetype,
        subtype,
        title,
        description,
        content,
        keywords,
        start,
        end,
        url,
        created,
        checked
    ):
        '''
            Stochastic event from your white-headed capuchins.
        '''
        logging.info('pero peque~o mae')
        bucket_type = 'planets'
        bucket = client.bucket_type(bucket_type).bucket('{0}'.format(bucket_name))

        if subtype is not bucket_name:
            logging.warning('Warning the following stuff do not match subtype:{0} bucket_name: {1}'.format(subtype, bucket_name))

        if bucket_type is not nodetype:
            logging.warning('Warning the following stuff do not match nodetype:{0} bucket_type: {1}'.format(nodetype, bucket_type))

        bucket.set_properties({'search_index': 'mars'}) # mars is of course our search index

        # now we define or map data structure
        self.map = Map(bucket, None)
        self.map.registers['uuid'].assign(uuid)
        self.map.registers['account'].assign(account)
        self.map.registers['title'].assign(title)
        self.map.registers['description'].assign(description)
        self.map.registers['content'].assign(content)
        self.map.registers['start'].assign(start)
        self.map.registers['end'].assign(end)
        self.map.registers['nodetype'].assign(bucket_type)
        self.map.registers['subtype'].assign(bucket_name)
        self.map.registers['url'].assign(url)
        for k in keywords:
            self.map.sets['keywords'].add(k)
        if checked:
            self.map.flags['checked'].enable()
        self.map.registers['created'].assign(created)
        # and finally we store or CRDT datatype inside our database
        self.map.store()

    @property
    def uuid(self):
        return self.map.reload().registers['uuid'].value

    @property
    def account(self):
        return self.map.reload().registers['account'].value

    @property
    def nodetype(self):
        return self.map.reload().registers['nodetype'].value

    @property
    def subtype(self):
        return self.map.reload().registers['subtype'].value

    @property
    def title(self):
        return self.map.reload().registers['title'].value

    @property
    def description(self):
        return self.map.reload().registers['description'].value

    @property
    def content(self):
        return self.map.reload().registers['content'].value

    @property
    def keywords(self):
        return self.map.reload().sets['keywords'].value

    @property
    def start(self):
        return self.map.reload().registers['start'].value

    @property
    def end(self):
        return self.map.reload().registers['end'].value

    @property
    def url(self):
        return self.map.reload().registers['url'].value

    @property
    def created(self):
        return self.map.reload().registers['created'].value

    @property
    def checked(self):
        return self.map.reload().flags['checked'].value
    
    def add_keyword(self, keyword):
        self.map.sets['keywords'].add(keyword)
        self.map.store()

    def remove_keyword(self, keyword):
        self.map.sets['keywords'].discard(keyword)
        self.map.store()

    def to_json(self):
        event = self.map.reload()
        struct = {
            "uuid":event.registers['uuid'].value,
            "account":event.registers['account'].value,
            "nodetype":event.registers['nodetype'].value,
            "subtype":event.registers['subtype'].value,
            "title":event.registers['title'].value,
            "description":event.registers['description'].value,
            "content":event.registers['content'].value,
            "keywords":event.sets['keywords'].value,
            "start":event.registers['start'].value,
            "end":event.registers['end'].value,
            "url":event.registers['url'].value,
            "created":event.registers['created'].value,
            "checked":event.flags['checked'].value,
        }
        return json.dumps(struct)

    def to_dict(self):
        event = self.map.reload()
        struct = {
            "uuid":event.registers['uuid'].value,
            "account":event.registers['account'].value,
            "nodetype":event.registers['nodetype'].value,
            "subtype":event.registers['subtype'].value,
            "title":event.registers['title'].value,
            "description":event.registers['description'].value,
            "content":event.registers['content'].value,
            "keywords":event.sets['keywords'].value,
            "start":event.registers['start'].value,
            "end":event.registers['end'].value,
            "url":event.registers['url'].value,
            "created":event.registers['created'].value,
            "checked":event.flags['checked'].value,
        }
        return struct