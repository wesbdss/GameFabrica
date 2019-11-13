import json

import tornado.httpserver
import tornado.websocket
import tornado.ioloop
import tornado.web
import socket
 
class SocketHandle(tornado.websocket.WebSocketHandler):

    def open(self):
        print ('new connection')
        print(self.get)
      
    def on_message(self, message):
        print ('message received:  %s' % message)
        print ('sending back message: %s' % message[::-1])
        self.write_message(message[::-1])
 
    def on_close(self):
        print ('connection closed')
 
    def check_origin(self, origin):
        return True
 


application = tornado.web.Application([
    (r'/', SocketHandle),
])
 
 
if __name__ == "__main__":
    http_server = tornado.httpserver.HTTPServer(application)
    http_server.listen(8080)
    myIP = socket.gethostbyname(socket.gethostname())
    print ('*** Websocket Server Started at %s***' % myIP)
    tornado.ioloop.IOLoop.instance().start()