from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import cgi
import json
import os
import random
import re
import string
import sys
import time

class MyHandler(BaseHTTPRequestHandler):
    def send_200(self, type='text/html'):
        self.send_response(200)
        self.send_header('Content-type', type)
        self.end_headers()

    def send_data(self, idx,o):
        d = {"id": idx, "data":o}
        self.wfile.write(json.dumps(d))
        
    def send_404(self):
        self.send_error(404, 'ERROR 404.1234')

    def fill_json(self, n):
        a = []
        for i in range(0,n):
            a.append(int(random.random()*65536))
        return a

    def do_GET(self):
        try:
            self.send_200()
            if self.path == '/favicon.ico':    # drop it
                return

            params = self.path.strip("/").split(",") # expect idx,cmd,size
            idx = int(params[0])
            cmd = params[1]
            o = []
            if cmd == "rand":
                o = self.fill_json(int(params[2]))
            self.send_data(idx,o)
#            print "responded to path [%s]" % self.path
            return

        except IOError:
            print "(IOError) Can't parse url [%s])" % self.path
            self.send_404()
            return

    def do_POST(self):
        try:
            self.send_200()
            return

        except:
            print 'POST() ERROR!!'
            self.send_200()
            return

    def do_HEAD(self):
        try:
            self.send_200()
            return

        except:
            print 'HEAD() ERROR!!'
            self.send_200()
            return


def main():
    try:
        port = 9999
        server = HTTPServer(('', port), MyHandler)
        print 'started httpserver on port %d' % port
        server.serve_forever()

    except KeyboardInterrupt:
        print 'killing.. '
        server.socket.close()
        

if __name__ == '__main__':
    main()
