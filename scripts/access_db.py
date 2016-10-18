# -*- coding: utf-8 -*-
import MySQLdb

class AccessDB(object):
    """docstring for AccessDB"""
    def __init__(self):
        super(AccessDB, self).__init__()
        self.connect = MySQLdb.connect(
            host='localhost',
            user="root",
            db='h_manga',
            charset='utf8')
        self.cursor = self.connect.cursor()

    def __call__(self, cmd):
        self.cursor.execute(cmd)
        return self.cursor

    def commit(self):
        self.connect.commit()

    def close(self):
        self.cursor.close()
        self.connect.close()
