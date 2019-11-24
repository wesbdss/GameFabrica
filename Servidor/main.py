import json
import sys
import tornado.httpserver
import tornado.websocket
import tornado.ioloop
import tornado.web
import socket
sys.path.insert(1, './Servidores/')
from webSocketEvent import SocketHandle
from webSocketPlay import SocketPlay
from webService import WebHandle

"""
estrutura json:

[
    {
        "function":"login",
        "username":"$username",
        "pass":"$password"
    },
    {
        "function":"login",
        "username":"$username",
        "pass":"$password"
    }
]

"""

def main():
    application = tornado.web.Application([
        (r'/event', SocketHandle),(r'/', WebHandle),(r'/play',SocketPlay)
    ])
    
    
    if __name__ == "__main__":
        http_server = tornado.httpserver.HTTPServer(application)
        http_server.listen(8080)
        myIP = socket.gethostbyname(socket.gethostname())
        print ('*** Websocket Server Started at %s ***' % myIP)
        tornado.ioloop.IOLoop.instance().start()

main()

