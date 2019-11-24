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


"""
--------------------------------
        INICIO   Funções Socket
--------------------------------

"""
def SocketlistOn(self):
    self.playing
def start():
    pass


"""
--------------------------------
        FIM     Funções Socket
--------------------------------

"""

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
             
                if obj['function'] == 'listOn':
                    listOn(self)

            for client in self.connections:
                print('client: ',client)
                print('client: ',client.get)

            if (message == 'quit' or message == 'exit'):
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


"""
--------------------------------
        INICIO   Funções WEB
--------------------------------

"""
def weblogin(self,body):
    print("Login Solicitado")
    with open('dados/users.json','r') as f: #pega os players do arquivo ou servidor
        users = json.load(f)
    if body['username'] != '' and body['pass'] != '':
        auth = 0
        for x in users:
            if x['username'] == body['username'] and body['pass'] == x['pass']:
                auth = 1
                print(x['username'], " Logou!!")
                self.write(json.dumps({"response":"True"}))
                return
        if auth == 0:
            print("Usuario: ",body['username'], " não encontrado")
            self.write(json.dumps({"response":"False"}))
    print("Login Terminado")

def webgetInfo(self,body):
    print("Informações Solicitado")
    for user in users:
        if user['username'] == body['username']:
            print("Enviando Informações")
            self.write(json.dumps({"vitoria":user['vitoria'],"derrota":user['derrota'],"pontos":user['pontos'],"response":"ok"}))
            return


"""
--------------------------------
        FIM      Funções WEB
--------------------------------

"""

class WebHandle(tornado.web.RequestHandler):
    def get(self):
        self.write(b"Comi teu pai, get")
# channel.stream.listen((data) => setState(() => variable(data)))
    def post(self):
        try:
            body = self.request.body
            print("Body >> ",body)
            bodyjson = json.loads(body.decode('UTF-8'))
            print(bodyjson)
            if bodyjson['function'] == 'login':
                weblogin(self,bodyjson)
            elif bodyjson['function'] == 'getInfo':
                webgetInfo(self,bodyjson)
        except Exception as er:
            print("ERRO >> ",er," --- ",sys.exc_info()[0])
            exit()



def main():
    application = tornado.web.Application([
        (r'/ws', SocketHandle),(r'/', WebHandle),(r'/play',SocketPlay)
    ])
    
    
    if __name__ == "__main__":
        http_server = tornado.httpserver.HTTPServer(application)
        http_server.listen(8080)
        myIP = socket.gethostbyname(socket.gethostname())
        print ('*** Websocket Server Started at %s ***' % myIP)
        tornado.ioloop.IOLoop.instance().start()

main()

