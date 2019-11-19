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
with open('dados/users.json','r') as f: #pega os players do arquivo ou servidor
    users = json.load(f)


def login(self,obj):
    if obj['username'] != '' or obj['pass'] != '':
        auth = 0
        for x in users:
            if x['username'] == obj['username'] and x['pass'] == obj['pass']:
                self.write_message(json.dumps({'response':'true'}))
                auth =1
                print(x['username']+" se conectou no lobby!")
                self.ready.append((x['username'],self.get))
                return
        if auth == 0: 
            write_message(json.dumps({'response':'false'}))
            #print(x['username']+" não conectou!")
            return

def getInfo(self):
    y = []
    for x in self.ready:
        if x[1] == self.get:
            y = x
            break
    for x in users:
        if x['username'] == y[0]:
            print("Mandando Infos do jogador: "+x['username'])
            self.write_message(json.dump({"response": x}))
            break


    
def start():
    pass

class SocketHandle(tornado.websocket.WebSocketHandler):

    connections = set()
    ready = []
    playing = []

    def open(self):
        self.connections.add(self)
        self.ready = []
        self.playing = []

      
    def on_message(self, message):
        #print ('Printando:  %s' % message)
        try:
            if message == "teste":
                self.write_message('ok')
            else:
                obj = json.loads(str(message)) 
             
            if obj['function'] == 'login':
                login(self,obj)
            if obj['function'] == 'getInfo':
                getInfo(self)

            for client in self.connections:
                print('client: ',client)
                print('client: ',client.get)

            if (message == 'quit'):
                self.write_message(b'fodase')
                quit()


        except Exception as er: # sair cado der erro
            print("Erro: ",er)
            quit()
 
    def on_close(self):
        for x in self.ready: #retira players desconectados do lobby
            if self.get == x[1]:
                print ('Player: '+x[0]+' desconectado do lobby!')
                self.ready.remove(x)
        for x in self.playing: #retira players desconectados do game
            if self.get == x[1]:
                print ('Player: '+x[0]+' desconectado do jogo!')
                self.playing.remove(x)
        self.connections.remove(self)

 
    def check_origin(self, origin):
        return True
 





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

