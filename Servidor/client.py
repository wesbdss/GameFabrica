from websocket import create_connection
import json
ws = create_connection("ws://localhost:8080")
ws.send(json.dumps({"function":"login","username":"wey","pass":"wey"}))
ws.send(json.dumps({"function":"login","username":"allan","pass":"macaco"}))
result =  ws.recv()
print("Received '%s'" % result)
ws.close()