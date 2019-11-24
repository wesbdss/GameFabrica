import json
import sys
import tornado.httpserver
import tornado.websocket
import tornado.ioloop
import tornado.web
import socket

"""
--------------------------------
        INICIO   Funções Socket
--------------------------------

"""
def listOn(self):
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