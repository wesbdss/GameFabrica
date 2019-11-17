from websocket import create_connection
ws = create_connection("ws://localhost:8080")
ws.send(b'quit')
result =  ws.recv()
print("Received '%s'" % result)
ws.close()