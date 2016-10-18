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

    path = os.path.join(setting.pref['root_place'], '*')
    authors = get_dir_contents(path)

    for i in authors:
        print i

    # end
    db.commit()
    db.close()


if __name__ == "__main__":
    main()
