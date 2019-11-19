ready = [("Allan","<1>"),("Wey","<2>")]

print(ready)
for x in ready:
    if x[1] == "<1>":
        ready.remove(x)
    
print(ready)