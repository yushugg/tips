#!/usr/bin/env python
import urllib2
import re


class Page:
  def __init__(self, url):
    self.url = url

  def getContent(self):
    self.content = urllib2.urlopen(self.url).read()

  def dumpContent(self, fileName):
    with open(fileName, 'wb') as f:
      f.write(self.content)

  def find(self, pattern, flags=0):
    return re.findall(pattern, self.content, flags)
