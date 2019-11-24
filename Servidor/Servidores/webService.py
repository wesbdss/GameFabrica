import json
import sys
import tornado.httpserver
import tornado.websocket
import tornado.ioloop
import tornado.web


users = []
with open('./dados/users.json','r') as f: #pega os players do arquivo ou servidor
    users = json.load(f)

"""
--------------------------------
        INICIO   Funções WEB
--------------------------------

"""
def weblogin(self,body):
    print("(webService) >> Login Solicitado")
    if body['username'] != '' and body['pass'] != '':
        auth = 0
        for x in users:
            if x['username'] == body['username'] and body['pass'] == x['pass']:
                auth = 1
                print("(webService) >>", x['username'], " Logou!!")
                self.write(json.dumps({"response":"True"}))
                return
        if auth == 0:
            print("(webService) >> Usuario: ",body['username'], " não encontrado")
            self.write(json.dumps({"response":"False"}))
    print("(webService) >>  Login Terminado")

def webgetInfo(self,body):
    print("(webService) >> Informações Solicitado")
    for user in users:
        if user['username'] == body['username']:
            self.write(json.dumps({"vitoria":user['vitoria'],"derrota":user['derrota'],"pontos":user['pontos'],"response":"ok"}))
            print("Enviando Informações")
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
        print("---> Entrando no webService <---")
        try:
            with open('./dados/users.json','r') as f: #pega os players do arquivo ou servidor
                users = json.load(f)
            body = self.request.body #pegar corpo da mensagem
            #print("Body >> ",body)
            bodyjson = json.loads(body.decode('UTF-8'))# importa o bytes para string
            #print(bodyjson)
            if bodyjson['function'] == 'login': #acessa função 
                weblogin(self,bodyjson)
            elif bodyjson['function'] == 'getInfo': #acessa função 
                webgetInfo(self,bodyjson)
            print("---> Saindo no webService <---")
        except Exception as er:
            print("ERRO (webService) >> ",er," --- ",sys.exc_info()[0])
            exit()