#!/usr/bin/env python3

'''
@file: dumpOnePage.py
@content: dump one web page
@author: yushu
@time: 2013-11-14
'''

import httplib2

def getWebContent(url):
    '''
    Get a web page's content, using GET method
    
    @param url: web page url
    @return: web page content, type: bytes
    '''
    h = httplib2.Http()
    response, content = h.request(url, 'GET')
    
    return content

def dumpContent(content, fileName):
    '''
    Dump a web page content into a file
    
    @param content: web page content, type: bytes
    @param fileName: the dumped file name
    '''
    with open(fileName, 'wb') as f:
        f.write(content)

if __name__ == '__main__':
    url = input('Input a url: ')
    saveName = input('Input saving file name: ')

    content = getWebContent(url)
    dumpContent(content, saveName)
