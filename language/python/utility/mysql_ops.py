#!/usr/bin/env python
import MySQLdb


class MySQLOP:
  def __init__(self, host, user, password, db, charset='utf8'):
    self.host = host
    self.user = user
    self.password = password
    self.db = db
    self.charset = charset

  def connect(self):
    self.conn = MySQLdb.connect(host=self.host, user=self.user, passwd=self.password, db=self.db, charset=self.charset)
    self.cursor = self.conn.cursor()

  def close(self):
    self.cursor.close()
    self.conn.close()
