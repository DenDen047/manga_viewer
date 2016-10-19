# -*- coding:utf-8 -*-
import os
import sys
import glob
import MySQLdb

from init.Init import INIT
from access_db import AccessDB


def get_dir_contents(path):
    paths = glob.glob(path)
    contents = []
    for i in paths:
        contents.append(i.split('/')[-1])
    return contents


def main():
    # init
    setPlace = 'setting.json'
    setting = INIT(setPlace)
    db = AccessDB()

    db('DROP TABLE h_manga')
    db('CREATE TABLE h_manga(author VARCHAR(255), title VARCHAR(255))')

    path = os.path.join(setting.pref['root_place'], '*')
    authors = get_dir_contents(path)

    for a in authors:
        path = os.path.join(setting.pref['root_place'], a, '*')
        titles = get_dir_contents(path)
        for t in titles:
            cmd = u'INSERT INTO h_manga VALUES("{}", "{}")'.format(
                a, t)
            db(cmd)
        db.commit()

    # end
    db.commit()
    db.close()


if __name__ == "__main__":
    main()
