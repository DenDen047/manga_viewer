# -*- coding:utf-8 -*-

import os
import sys
import glob
import MySQLdb


root = '../Files'


def main():
    path = os.path.join(root, 'Manga', '*')
    print(glob.glob(path))


if __name__ == "__main__":
    main()
