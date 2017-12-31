#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Team Machine'
SITENAME = u'Blog'
SITEURL = 'https://blog.nonsense.ws'
PATH = 'content'
TIMEZONE = 'Etc/UTC'
DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_RSS = 'feeds/all.rss.xml'
CATEGORY_FEED_RSS = 'feeds/%s.rss.xml'

# Community
LINKS = (('Nonsense Worlds', 'https://nonsense.ws/'),)

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True
# Social widget
SOCIAL = (('cube', 'https://nonsense.ws'),
	('book', 'https://github.com/nonsensews/docs/wiki'),
	('github', 'https://github.com/nonsensews/guide/'),
	('twitter', 'https://twitter.com/nonsensews'))

DEFAULT_PAGINATION = 2

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

STATIC_PATHS = ['images', 'extra/CNAME']
EXTRA_PATH_METADATA = {'extra/CNAME': {'path': 'CNAME'},}

# Configure pelican theme
THEME = "pelican-nonsense"

BIO = "Spontaneously evolve towards thermodynamic equilibrium"
PROFILE_IMAGE = "https://blog.nonsense.ws/theme/img/shaos.png"
