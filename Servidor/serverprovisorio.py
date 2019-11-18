import json
import sys
import tornado.httpserver
import tornado.websocket
import tornado.ioloop
import tornado.web
import socket

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
users = []
with open('dados/users.json','r') as f:
    users = json.load(f)

for x in users:
    print(x['username'])
class SocketHandle(tornado.websocket.WebSocketHandler):

    connections = set()
    connection = []

    def open(self):
        print ('new connection')
        print(self.get)
        self.connections.add(self)
        self.lobby = []
      
    def on_message(self, message):
        print ('Printando:  %s' % message)
        try:
            msg = str(message)
            obj = json.loads(msg)
            print(obj['function'])
            
            if obj['function'] == 'login' and (obj['username'] != '' or obj['pass'] != ''):
                auth = 0
                for x in users:
                    if x['username'] == obj['username'] and x['pass'] == obj['pass']:
                        self.write_message(json.dumps({'response':'true'}))
                        auth =1
                        print(x['username']+" Entrou no lobby")
                        self.lobby.append((x['username'],self.get))
                        break
                        #return
                if auth == 0:
                    write_message(json.dumps({'response':'false'}))
                    print(x['username']+" Não Encontrado com Sucesso")
                    return
            print(self.lobby)
            for client in self.connections:
            	print('client: ',client)

            

            if (message == 'quit'):
                self.write_message(b'fodase')
                quit()
            #self.write_message(json.dumps({'response':'Te comi mesmo'}))
        except Exception as er:
            print("Erro: ",er)

            quit()
 
    def on_close(self):
        print ('connection closed')
        self.connections.remove(self)
 
    def check_origin(self, origin):
        return True
 
    
def start():
    pass


application = tornado.web.Application([
    (r'/', SocketHandle),
    ])


def main():
    if __name__ == "__main__":
        import time, threading
        threading.Thread(target=startTornado).start()
        input("Aperta Enter")
        stopTornado()

def startTornado():
    http_server = tornado.httpserver.HTTPServer(application)
    http_server.listen(8080)
    myIP = socket.gethostbyname(socket.gethostname())
    print ('*** Websocket Server Started at %s ***' % myIP)
    tornado.ioloop.IOLoop.instance().start()

def stopTornado():
    tornado.ioloop.IOLoop.instance().stop()

    
main()