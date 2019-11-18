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
users = json.loads('[{"username":"Allan","pass":"macaco"},{"username":"wey","pass":"wey"}]')

class SocketHandle(tornado.websocket.WebSocketHandler):
    lobby = []
    def open(self):
        print ('new connection')
        print(self.get)
      
    def on_message(self, message):
        print ('Printando:  %s' % message)
        try:
            msg = str(message)
            obj = json.loads(msg)
            print(obj['function'])
            
            if obj['function'] == 'login' and (obj['username'] != '' or obj['pass'] != ''):
                user = obj['username']
                auth = 0
                for x in users:
                    if x['username'] == obj['username'] and x['pass'] == obj['pass']:
                        self.write_message(json.dumps({'response':'true'}))
                        auth =1
                        print(x['username']+" Entrou no lobby")
                        lobby.append(x['username'],self.get)
                        break
                        #return
                if auth == 0:
                    write_message(json.dumps({'response':'false'}))
                    print(x['username']+" Não Encontrado com Sucesso")
                    return

            print(lobby)

            if (message == 'quit'):
                self.write_message(b'fodase')
                quit()
            #self.write_message(json.dumps({'response':'Te comi mesmo'}))
        except Exception:
            print("Erro: ",sys.exc_info()[0])
            quit()
 
    def on_close(self):
        print ('connection closed')
 
    def check_origin(self, origin):
        return True
 
    
def start():
    pass



def main():
    application = tornado.web.Application([
        (r'/', SocketHandle),
    ])
    
    
    if __name__ == "__main__":
        http_server = tornado.httpserver.HTTPServer(application)
        http_server.listen(8080)
        myIP = socket.gethostbyname(socket.gethostname())
        print ('*** Websocket Server Started at %s ***' % myIP)
        tornado.ioloop.IOLoop.instance().start()

main()