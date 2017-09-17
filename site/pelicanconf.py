#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Nonsense Web Services'
SITENAME = u'SHA/OS'
SITEURL = 'https://shaos.ws'
PATH = 'content'
TIMEZONE = 'Etc/UTC'
DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_RSS = 'feeds/all.rss.xml'
CATEGORY_FEED_RSS = 'feeds/%s.rss.xml'

# Community
LINKS = (('Nonsense Web Services', 'https://nonsense.ws/'),)

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True
# Social widget
SOCIAL = (('cube', 'https://github.com/nonsensews/shaos/tree/master/index'),
	('book', 'https://github.com/nonsensews/guide/wiki'),
	('download', 'https://shaos.ws/download.html'),
	('twitter', 'https://twitter.com/shaosws'))

DEFAULT_PAGINATION = 2

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

STATIC_PATHS = ['images', 'extra/CNAME']
EXTRA_PATH_METADATA = {'extra/CNAME': {'path': 'CNAME'},}

# Configure pelican theme
THEME = "pelican-shaos"

BIO = "Spontaneously evolve towards thermodynamic equilibrium"
PROFILE_IMAGE = "https://shaos.ws/theme/img/shaos.png"
