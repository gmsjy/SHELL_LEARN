#!/usr/bin/env python
# coding=utf-8

from collections import OrderedDict

def meminfo():
    '''Return the information in /proc/meminfo as a dictionary'''
    meminfo=OrderedDict()

    with open('/proc/meminfo') as f:
        for line in f:
            meminfo[line.split(':')[0]] = line.split(':')[1].strip()
    return meminfo

if __name__=='__main__':
    #打印内存信息

    meminfo = meminfo()
    print '内存总量: {0}'.format(meminfo['MemTotal'])
    print '未使用内存: {0}'.format(meminfo['MemFree'])
