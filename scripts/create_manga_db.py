# -*- coding:utf-8 -*-
import os
import sys
import glob
import MySQLdb

from init.Init import INIT
from access_db import AccessDB



def main():
    setPlace = 'setting.json'
    setting = INIT(setPlace)

    print setting['root_place']

    path = os.path.join(root, 'Manga', '*')
    print(glob.glob(path))


if __name__ == "__main__":
    main()
