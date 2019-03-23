# -*- coding: utf-8 -*-

# This file is part of starfruit.

# Distributed under the terms of the last AGPL License.
# The full license is in the file LICENCE, distributed as part of this software.


__authors__ = 'Space Beam'


import time
import zmq
import sys
import itertools
import logging
import riak
import uuid
import motor
import queries
import pylibmc as mc
from tornado.web import RequestHandler
from tornado import gen, web
from starfruit.tools import options, periodic
# new_resource waht?
from starfruit.tools import new_resource
from starfruit.handlers import calls
from zmq.eventloop import ioloop
from zmq.eventloop.future import Context, Poller


# ioloop
ioloop.install()

# e_tag
e_tag = False


def main():
    '''
        Starfruit communication carambolas.
    '''
    # daemon options
    opts = options.options()
    # Set memcached backend
    memcache = mc.Client(
        [opts.memcached_host],
        binary=opts.memcached_binary,
        behaviors={
            "tcp_nodelay": opts.memcached_tcp_nodelay,
            "ketama": opts.memcached_ketama
        }
    )
    # Set kvalue database
    kvalue = riak.RiakClient(host=opts.riak_host, pb_port=8087)
    # Set default cache
    cache = memcache
    # Set default database
    db = kvalue
    # logging system spawned
    logging.info('Starfruit system {0} spawned'.format(uuid.uuid4()))
    # logging riak server
    logging.info('Riak server: {0}:{1}'.format(opts.riak_host, opts.riak_port))
    # logging riak server
    logging.info('solr Riak: {0}'.format(opts.solr))
    # logging context-starfruit asterisk
    logging.info('Context-startfruit Asterisk: {0}'.format(opts.context))
    # logging channel asterisk
    logging.info('Channel Asterisk: {0}'.format(opts.channel))
    # system cache
    cache_enabled = opts.cache_enabled
    if cache_enabled:
        logging.info('Memcached server: {0}:{1}'.format(opts.memcached_host, opts.memcached_port))
    # starfruit web application daemon
    application = web.Application(
        [
            # starfruit system calls
            (r'/calls/(?P<call_uuid>.+)/?', calls.Handler),
            (r'/calls/?', calls.Handler),
        ],
        # system database
        db=db,
        # system cache
        cache = cache,
        # cache enabled flag
        cache_enabled = cache_enabled,
        # kvalue datastorage
        kvalue = kvalue,
        # debug mode
        debug = opts.debug,
        # application domain
        domain = opts.domain,
        # pagination page size
        page_size = opts.page_size,
        # asterisk engine settings
        max_retries = opts.max_retries,
        retry_time = opts.retry_time,
        wait_time = opts.wait_time,
        max_calls = opts.max_calls,
        asterisk_user = opts.asterisk_user,
        asterisk_group = opts.asterisk_group,
        spool_dir = opts.spool_dir,
        tmp_dir = opts.tmp_dir,
        # trunk 
        channel = opts.channel,
        #context default
        context = opts.context,
        #yokozuna
        solr = opts.solr,
    )
    # Setting up starfruit processor
    application.listen(opts.port)
    logging.info('Listening on http://%s:%s' % (opts.host, opts.port))
    loop = ioloop.IOLoop.instance()
    loop.start()

if __name__ == '__main__':
    main()
