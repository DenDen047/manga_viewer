# -*- coding:utf-8 -*-

import os
from bottle import route, run, view, template, static_file, url


# 静的ファイルの読み込みに対する定義関数
@route('/bower_components/:path#.+#', name='views_static')
def views_static(path):
    return static_file(path, root='/home/ubuntu/workspace/views')

@route('/')
@view('temp')
def top():
    return dict(
        author='著者', title='タイトル', page_cnt='10', file_size='10', time='10/10/10:10', get_url=url)


run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
