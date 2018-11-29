# -*- coding: utf-8 -*-
'''
    Starfruit daemon configuration options.
'''

# This file is part of starfruit.

# Distributed under the terms of the last AGPL License. 
# The full license is in the file LICENCE, distributed as part of this software.

__author__ = 'Team Machine'


import os
import tornado.options
from tornado.options import parse_config_file


config_path = 'starfruit.conf'


def options():
    '''
        Starfruit configuration options
    '''
    # Set config and stuff
    tornado.options.define('config',
        type=str, help='path to config file',
        callback=lambda path: parse_config_file(path, final=False))
    # debugging
    tornado.options.define('debug',
        default=False, type=bool,
        help=('Turn on autoreload and log to stderr only'))
    # logging dir
    tornado.options.define('logdir',
        type=str, default='log',
        help=('Location of logging (if debug mode is off)'))
    # Application domain
    tornado.options.define('domain',
        default='*', type=str,
        help='Application domain, e.g: "your_domain.com"')
    # solr
    tornado.options.define('solr',
        default='api.cloudforest.ws', type=str,
        help='Yokozuna solr, e.g: "your_custom_solr_search"')
    # Server settings
    tornado.options.define('host', 
        default='127.0.0.1', type=str,
        help=('Server hostname'))
    tornado.options.define('port', 
        default=8538, type=int,
        help=('Server port'))
    # Riak kvalue datastorage settings
    tornado.options.define('riak_host', 
        default='127.0.0.1', type=str,
        help=('Riak cluster node'))
    # riak port
    tornado.options.define('riak_port',
        default=8087, type=int,
        help=('Riak cluster port'))
    # PostgreSQL database settings
    tornado.options.define('sql_host',
        type=str, help=('PostgreSQL hostname or ip address'))
    # sql port
    tornado.options.define('sql_port',
        default=5432, type=int,
        help=('PostgreSQL port'))
    # sql database
    tornado.options.define('sql_database',
        type=str, help=('PostgreSQL database'))
    # sql user
    tornado.options.define('sql_user',
        type=str, help=('PostgreSQL username'))
    # sql password
    tornado.options.define('sql_password',
        type=str, help=('PostgreSQL username password'))
    # memcache host
    tornado.options.define('memcached_host',
        default='127.0.0.1', type=str,
        help=('Memcached host'))
    # memcache port
    tornado.options.define('memcached_port',
        default=11211, type=int,
        help=('Memcached port'))
    tornado.options.define('memcached_binary',
        default=True, type=bool,
        help=('Memcached binary'))
    tornado.options.define('memcached_tcp_nodelay',
        default=True, type=bool,
        help=('Memcached tcp_nodelay'))
    tornado.options.define('memcached_ketama',
        default=True, type=bool,
        help=('Memcached ketama'))
    tornado.options.define('cache_enabled',
        default=False, type=bool,
        help=('Enable cache'))
    tornado.options.define('page_size',
        default=50, type=int,
        help=('Set a custom page size up to 100'))
    tornado.options.define('max_retries',
        default=2, type=int,
        help=('Max retries'))
    tornado.options.define('retry_time',
        default=300, type=int,
        help=('Outbound calling retry time'))
    tornado.options.define('wait_time',
        default=45, type=int,
        help=('Wait time'))
    tornado.options.define('max_calls',
        default=10, type=int,
        help=('Maximum number of concurrent calls'))
    tornado.options.define('asterisk_user',
        default='asterisk', type=str,
        help=('non-root Asterisk user'))
    tornado.options.define('asterisk_group',
        default='asterisk', type=str,
        help=('non-root Asterisk group'))
    tornado.options.define('spool_dir',
        default='/var/spool/asterisk/outgoing/', type=str,
        help=('Asterisk spool dir'))
    tornado.options.define('tmp_dir',
        default='/tmp/', type=str,
        help=('tmp outbound call files'))
    tornado.options.define('channel',
        default='SIP/fiorella_1/', type=str,
        help='Channel trunk Asterisk, e.g: "SIP/TRUNK/"')
    tornado.options.define('context',
        default='fun-accounts', type=str,
        help='Context Asterisk, e.g: "my-context"')

    # Parse config file, then command line...
    # so command line switches take precedence
    if os.path.exists(config_path):
        print('Loading %s' % (config_path))
        tornado.options.parse_config_file(config_path)
    else:
        print('No config file at %s' % (config_path))
    tornado.options.parse_command_line()
    result = tornado.options.options
    for required in (
        'domain', 'host', 'port',
    ):
        if not result[required]:
            raise Exception('%s required' % required)
    return result