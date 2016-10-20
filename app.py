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


# 静的ファイルの読み込みに対する定義関数
@route('/bower_components/:path#.+#', name='views_static')
def views_static(path):
    return static_file(path, root='/home/ubuntu/workspace/views')

@route('/')
@view('temp')
def top():
    return dict(
        author='著者', title='タイトル', page_cnt='10', file_size='10', time='10/10/10:10', get_url=url)

@route('/search/index/word\:<author:path>')
@view('temp')
def search(author):
    author = author.decode('utf-8')
    cmd = u'SELECT author, title FROM h_manga WHERE author="{}"'.format(author)
    print(cmd)
    result = db(cmd)
    mangas = []
    for row in result:
        path = os.path.join(setting.pref['root_place'], row[0], row[1])
        mangas.append({'author': row[0], 'title': row[1], 'path': path})
    return dict(mangas=mangas, get_url=url)



run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
