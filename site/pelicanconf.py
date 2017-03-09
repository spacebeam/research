#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Team Machine'
SITENAME = u'shaos.ws'
SITEURL = ''
PATH = 'content'
TIMEZONE = 'Etc/UTC'
DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Community
LINKS = (('Nonsense Worlds', 'https://nonsense.ws/'),)

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True
# Social widget
SOCIAL = (('cube', 'https://nonsense.ws'),
	('book', 'https://github.com/nonsensews/guide/wiki'),
	('twitter', 'https://twitter.com/shaosws'),
	('github', 'https://github.com/nonsensews'),
	('email', 'info@nonsense.ws'))

DEFAULT_PAGINATION = 2

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

STATIC_PATHS = ['images', 'extra/CNAME']
EXTRA_PATH_METADATA = {'extra/CNAME': {'path': 'CNAME'},}

# Theme stuff
THEME = "pelican-hyde"

BIO = "Grow by Nonsense Worlds Supercomputer and open-source Community of HPC monkeys."
PROFILE_IMAGE = "avatar.jpg"