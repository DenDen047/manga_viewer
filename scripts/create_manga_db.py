# -*- coding:utf-8 -*-
import os
import sys
import glob
import MySQLdb

from access_db import AccessDB

root = '../Files'


def main():
    path = os.path.join(root, 'Manga', '*')
    print(glob.glob(path))


if __name__ == "__main__":
    main()
