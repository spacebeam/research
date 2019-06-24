#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Luerl'
SITENAME = u'Lua in Erlang'
SITEURL = 'https://luerl.org'
PATH = 'content'
TIMEZONE = 'Etc/UTC'
DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_RSS = 'feeds/all.rss.xml'
CATEGORY_FEED_RSS = 'feeds/%s.rss.xml'

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True
# Social widget

SOCIAL = (('cube', 'https://luerl.org/community.html'),
	('book', 'https://github.com/rvirding/luerl/wiki'),
	('bug', 'https://github.com/rvirding/luerl/issues'),
	('github', 'https://github.com/rvirding/luerl'))

DEFAULT_PAGINATION = 2

STATIC_PATHS = ['images', 'extra/CNAME']
EXTRA_PATH_METADATA = {'extra/CNAME': {'path': 'CNAME'},}

# Theme stuff
THEME = "pelican-rhea"
BIO = "Luerl is an implementation of Lua 5.2 written in pure Erlang"
PROFILE_IMAGE = "https://luerl.org/theme/lua.png"
