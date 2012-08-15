#!/usr/bin/python

# This works on a wikipedia xml dump 
# example usage:
# python wiki_interest_image.py enwiki-20120502-pages-articles-multistream.xml
#

import codecs
import hashlib
import urllib
import re
import sys
import MySQLdb
from collections import defaultdict
from xml.etree import ElementTree as et 

def xmlforeach(filename, cb):
    """apply cb on each xml node
    """
    # Namespace in front of all tags
    ns = "{http://www.mediawiki.org/xml/export-0.6/}"
    # Because the file is 30GB we must be aggressive in unloading things
    # from the XML document as we parse it, specifically all the
    # <page> elements directly below the root. So I follow the top
    # suggestion on:
    #
    # http://stackoverflow.com/questions/324214/
    #   what-is-the-fastest-way-to-parse-large-xml-docs-in-python
    # Following suggestion on page above
    context = et.iterparse(filename, events=("start", "end"))
    context = iter(context)
    event, root = context.next()
    total_ac = 0  # article-counter
    iac = 0 # interest article-counter
    for event, elem in context:
        if event == "end" and elem.tag == ns + "page":
            title = elem.find(ns + "title").text
            text = elem.find(ns + "revision").find(ns + "text").text

            if title != None:
                cb(title, len(text.strip()))
                if len(text.strip()) < 100:
                    print "[%s]" % text.strip()
                total_ac += 1
            if total_ac == 5000:
                exit()
            # Now get rid of everything from memory, in order to process
            # the next record
            root.clear()

def cb(title, leng):
    print "%s %d" %(title, leng)

# reduce failures due to pipings and redirects to non-unicode receptors
def set_io_utf8():
    sys.stdout = codecs.getwriter('UTF-8')(sys.stdout)
    sys.stdin = codecs.getreader('UTF-8')(sys.stdin)

def main(filename):
    set_io_utf8()
    xmlforeach(filename, cb)

if __name__ == '__main__':
    filename = sys.argv[1]
    main(filename)


