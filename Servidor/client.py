from websocket import create_connection
import json
ws = create_connection("ws://localhost:8080/event")
msg = ""
while msg != "sair":
    print("Teste de funções (wey): 1 - jogar  2 - ingame 3 - end")
    msg = input("Digita o função >> ")
    username = input("Digita o username >> ")
    if msg == "sair":
        quit()
    if msg == "1":
        ws.send(json.dumps({"function":"jogar","username":username}))
    if msg == "2":
        ws.send(json.dumps({"function":"ingame","username":username}))
    if msg == "3":
        ws.send(json.dumps({"function":"end","username":username}))
    else quit()
    result = ws.recv()
    print("Reposta do server >>  '%s'" % result)

    
ws.close()