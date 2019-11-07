#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'BEAM Community'
SITENAME = 'Luerl: Lua in Erlang'
#SITEURL = 'https://luerl.org'
SITEURL = ''

# Categories
USE_FOLDER_AS_CATEGORY = True
DISPLAY_CATEGORIES_ON_MENU = True

# Pages
DISPLAY_PAGES_ON_MENU = True

PATH = 'content'
STATIC_PATHS = ['images', 'files']
TIMEZONE = 'Europe/Brussels'
DEFAULT_LANG = 'en'

# Will change this to 10 when publishing; 3 is easier to do theme dev with
DEFAULT_PAGINATION = 3 

# Period Archive formats
YEAR_ARCHIVE_SAVE_AS = '{date:%Y}/index.html'
MONTH_ARCHIVE_SAVE_AS = '{date:%Y}/{date:%m}/index.html'
DAY_ARCHIVE_SAVE_AS = '{date:%Y}/{date:%m}/{date:%d}/index.html'

# URL settings -- leads to clean slug urls instead of having .html after everything
ARTICLE_URL = '{date:%Y}/{date:%m}/{date:%d}/{slug}/'
ARTICLE_SAVE_AS = '{date:%Y}/{date:%m}/{date:%d}/{slug}/index.html'
TAG_URL = 'tag/{slug}/'
TAG_SAVE_AS = 'tag/{slug}/index.html'
DRAFT_URL = 'drafts/{slug}'
DRAFT_SAVE_AS = 'drafts/{slug}/index.html'
CATEGORY_URL = 'category/{slug}'
CATEGORY_SAVE_AS = 'category/{slug}/index.html'
AUTHOR_URL = ''
AUTHOR_SAVE_AS = ''
AUTHORS_SAVE_AS = ''
PAGE_URL = 'pages/{slug}/'
PAGE_SAVE_AS = 'pages/{slug}/index.html'
PAGINATION_PATTERNS = (
    (1, '{base_name}/', '{base_name}/index.html'),
    (2, '{base_name}/{number}/', '{base_name}/{number}/index.html'),
)

# Theme Settings
THEME = 'themes/brutalist'
## used for OG tags and Twitter Card data on index page
SITEIMAGE = 'site-cover.jpg'
## used for OG tags and Twitter Card data of index page
SITEDESCRIPTION = ''
## path to favicon
FAVICON = 'luerl.png'
## path to logo for nav menu (optional)
LOGO = 'luerl.png'
## first name for nav menu if logo isn't provided
FIRST_NAME = 'Luerl'
## google analytics (fake code commented out)
# GOOGLE_ANALYTICS = 'UA-0011001-1'
## Twitter username for Twitter Card data
TWITTER_USERNAME = '@rvirding'
## Toggle display of theme attribution in the footer (scroll down and see)
## Attribution is appreciated but totally fine to turn off!
ATTRIBUTION = True
## Add a link to the tags page to the menu
## Other links can be added following the same tuple pattern 
#MENUITEMS = [('tags', '/tags')]
## Social icons for footer

TWITTER = 'https://twitter.com/rvirding'
GITHUB = 'https://github.com/rvirding/luerl'

## Disqus Sitename for comments on posts
## Commenting mine out for this theme site
DISQUS_SITENAME = 'luerl'

# PLUGINS
PLUGIN_PATHS = ['plugins']
PLUGINS = ['sitemap', 'w3c_validate', 'optimize_images', 'gzip_cache', 'liquid_tags.youtube', 'liquid_tags.img']

## SITEMAP PLUGIN
SITEMAP = {
    'format': 'xml',
    'priorities': {
        'articles': .99,
        'pages': .75,
        'indexes': .5
    },
    'changefreqs': {
        'articles': 'daily',
        'pages': 'daily',
        'indexes': 'daily'
    },
}

## Github URL for fork ribbon
## Only used on theme site, not personal blog
#GITHUB_URL = 'https://github.com/spacebeam'
#GITHUB_POSITION = 'left'
