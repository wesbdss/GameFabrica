import json
import sys
import tornado.httpserver
import tornado.websocket
import tornado.ioloop
import tornado.web
import socket

"""
--------------------------------
        INICIO  Funções Socket
--------------------------------

"""


def find(self,obj):
    if len(self.ready) > 1:
        for conn in self.ready:
            if conn != (obj['username'],self):
                print(conn[0]," VS ",obj['username'])
                self.versus.append((conn[0],obj['username']))
                self.ready.remove(conn)
                self.ready.remove((obj['username'],self))
                vitoria,derrota,pontos = buscarDados(conn[0])
                vitoria1,derrota1,pontos1 = buscarDados(obj['username'])
                self.write_message(json.dumps({'response':'encontrado','usernameOP':conn[0],'vitoria':vitoria,'derrota':derrota,'pontos':pontos}))
                conn[1].write_message(json.dumps({'response':'encontrado','usernameOP':obj['username'],'vitoria':vitoria1,'derrota':derrota1,'pontos':pontos1}))
                return 
    else:
        print("Não há oponentes")
        self.write_message(json.dumps({'response':'no'}))
        
def buscarDados(nome):
    users = []
    with open('./dados/users.json','r') as f: #pega os players do arquivo ou servidor
        users = json.load(f)
    for user in users:
        if user['username'] == nome:
            return user['vitoria'],user['derrota'],user['pontos']
    return 0

def codePoints(nome,code,self):
    #enviar os pontos tag response : end
    #trabalhar em como setar os pontos
    qtd = len(code)
    self.write_message(json.dumps({"response":"fim","pontos":qtd}))
    pass



"""
--------------------------------
        FIM     Funções Socket
--------------------------------

"""


class SocketPlay(tornado.websocket.WebSocketHandler):

    connections = set()
    ready = []
    versus = []
    playing = []
    waiting = []

    def open(self):
        self.connections.add(self)

      
    def on_message(self, message):
        #print ('Printando:  %s' % message)
        print("---> Entrando no webSocketPlay <---")
        try:
            if message == "teste":
                self.write_message('ok')
            else:
                obj = json.loads(str(message)) 

                if ((obj['username'],self) not in self.ready) and ((obj['username'],self) not in self.playing): #adiciona novos players
                    self.ready.append((message['username'],self))

                """
                    Funções de Ação do Game
                """
                if obj['function'] == 'jogar':
                    find(self,obj) #encontrar jogadores
                elif obj['function'] == 'ingame':
                    if ((obj['username'],self) in self.ready) and ((obj['username'],self) not in self.playing):
                        self.ready.remove((obj['username'],self))
                        self.playing.append((obj['username'],self))
                elif obj['function'] == 'end':
                    if (obj['username'],self) in self.playing:
                        self.playing.remove((obj['username'],self))
                        codePoints(obj['username'],obj['code'],self)
                        return 0 #fim do jogo




            print("---> Saindo no webSocketPlay <---")
            if (message == 'quit' or message == 'exit'):
                self.write_message(b'fodase')
                quit()


        except Exception as er: # sair cado der erro
            print("Erro (webSocketPlay) >> ",er)
            quit()
 
    def on_close(self):
        for x in self.ready: #retira players desconectados do lobby
            if self == x[1]:
                print ('Player: '+x[0]+' desconectado do lobby!')
                self.ready.remove(x)
        for x in self.playing: #retira players desconectados do game
            if self == x[1]:
                print ('Player: '+x[0]+' desconectado do jogo!')
                self.playing.remove(x)
        self.connections.remove(self)

 
    def check_origin(self, origin):
        return True