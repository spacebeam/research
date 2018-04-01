#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Lisp 3'
SITENAME = u'Lisp 3'
SITEURL = 'https://lisp3.org'
PATH = 'content'
TIMEZONE = 'Etc/UTC'
DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_RSS = 'feeds/all.rss.xml'
CATEGORY_FEED_RSS = 'feeds/%s.rss.xml'

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True
# Social widget

SOCIAL = (('cube', 'https://lisp3.org/community.html'),
	('book', 'https://lfe.io'),
	('bug', 'https://github.com/rvirding/lfe/issues'),
	('github', 'https://github.com/rvirding/lfe'))

DEFAULT_PAGINATION = 2

STATIC_PATHS = ['images', 'extra/CNAME']
EXTRA_PATH_METADATA = {'extra/CNAME': {'path': 'CNAME'},}

# Theme stuff
THEME = "pelican-lfe"
BIO = "Lisp Flavoured Erlang (LFE)"
PROFILE_IMAGE = "https://lisp3.org/theme/lfe.png"
