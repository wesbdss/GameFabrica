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



"""
--------------------------------
        FIM     Funções Socket
--------------------------------

"""


class SocketPlay(tornado.websocket.WebSocketHandler):

    connections = set()
    ready = []
    playing = []

    def open(self):
        self.connections.add(self)
        self.playing = []

      
    def on_message(self, message):
        #print ('Printando:  %s' % message)
        print("---> Entrando no webSocketPlay <---")
        try:
            if message == "teste":
                self.write_message('ok')
            else:
                obj = json.loads(str(message)) 

            print("---> Saindo no webSocketPlay <---")
            if (message == 'quit' or message == 'exit'):
                self.write_message(b'fodase')
                quit()


        except Exception as er: # sair cado der erro
            print("Erro (webSocketPlay) >> ",er)
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