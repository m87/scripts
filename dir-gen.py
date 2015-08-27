#!/usr/bin/env python
# encoding: utf-8

import yaml
import sys
import os

f = open(sys.argv[1])
config = yaml.load(f)


def create(path, key):
    if type(key) is list:
        for l in key:
            os.mkdir(os.path.join(path,l))
    else:
        for k in key.keys():
            os.mkdir(os.path.join(path,k))
            create(os.path.join(path,k),key[k])


create(sys.argv[2],config["root"])

