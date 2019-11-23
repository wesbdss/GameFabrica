from websocket import create_connection
import json
ws = create_connection("ws://localhost:8080/ws")
ws.send("quit")
result =  ws.recv()
print("Received '%s'" % result)
ws.close()