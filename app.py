# -*- coding:utf-8 -*-

import os
import urllib2
from bottle import route, run, view, template, static_file, url

from libraries.init.Init import INIT
from libraries.access_db import AccessDB


# init
setPlace = 'setting.json'
setting = INIT(setPlace)
db = AccessDB()
books_per_page = int(setting.pref['books_per_page'])


# 静的ファイルの読み込みに対する定義関数
@route('/bower_components/:path#.+#', name='views_static')
def views_static(path):
    return static_file(path, root='/home/ubuntu/workspace/views')

@route('/')
@route('/tops/index/term\:no/page\:<page:int>')
@view('manga_list')
def top(page=1):
    cmd = 'SELECT author, title FROM h_manga ORDER BY RAND() LIMIT {}'.format(books_per_page)
    result = db(cmd)
    mangas = []
    for row in result:
        path = os.path.join(setting.pref['root_place'], row[0], row[1])
        mangas.append({'author': row[0], 'title': row[1], 'path': path})
    return dict(mangas=mangas, get_url=url, page=page, max_page=1, count_manga=books_per_page)

@route('/search/index/word\:<author:path>')
@route('/search/index/word\:<author:path>/page\:<page:int>')
@view('manga_list')
def search(author, page=1):
    author = author.decode('utf-8')
    # search manga
    cmd = u'SELECT author, title FROM h_manga WHERE author="{}" LIMIT {}, {}'.format(
        author, (page-1)*books_per_page, books_per_page)
    result = db(cmd)
    mangas = []
    for row in result:
        path = os.path.join(setting.pref['root_place'], row[0], row[1])
        mangas.append({'author': row[0], 'title': row[1], 'path': path})
    # search max_page
    cmd = u'SELECT COUNT(title) FROM h_manga WHERE author="{}"'.format(author)
    result = db(cmd)
    for i in result:
        count_manga = i[0]
    max_page = count_manga / books_per_page + 1
    return dict(mangas=mangas, get_url=url, page=page, max_page=max_page, count_manga=count_manga)



run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
