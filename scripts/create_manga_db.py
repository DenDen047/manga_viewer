# -*- coding:utf-8 -*-
import os
import sys
import glob
import MySQLdb

from init.Init import INIT
from access_db import AccessDB


def get_authors(path):
    paths = glob.glob(path)
    authors = []
    for i in paths:
        authors.append(i.split('/')[-1])
    return authors


def main():
    setPlace = 'setting.json'
    setting = INIT(setPlace)

    path = os.path.join(setting.pref['root_place'], '*')
    authors = get_authors(path)

    for i in authors:
        print i


if __name__ == "__main__":
    main()
