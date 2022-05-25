file1 = open('../output/assembleur.asm', 'r')

lines = file1.readlines()
Data_Memory={}
#While not end of line
i = 0
print(len(lines))
while (i<len(lines)) :
    
    arr = lines[i].split(" ")
    aro = arr[0]
   # print(arr)
    if (aro=="AFC"):
        Data_Memory[str(arr[1])]=int(arr[2])
            
    elif(aro=="COP") :
        Data_Memory[str(arr[1])]=Data_Memory[str(arr[2])]
            
    elif(aro=="ADD") :
        Data_Memory[str(arr[1])]=int(Data_Memory[str(arr[2])])+int(Data_Memory[str(arr[3])])
            
    elif(aro=="MUL"):
        Data_Memory[str(arr[1])]=int(Data_Memory[str(arr[2])])*int(Data_Memory[str(arr[3])])
            
            
    elif(aro=="SOU"):
        Data_Memory[str(arr[1])]=int(Data_Memory[str(arr[2])])-int(Data_Memory[str(arr[3])])
            
    elif(aro=="JMP"):
            i = int(arr[1])-2
            # -1 ++ à la fin
            #  -1 car les lignes d'instructions sont lue à partir de l'instruction numéro une
            
    elif(aro=="JMF"):
            if(not(Data_Memory[str(arr[1])])):
                i = int(arr[2])-2
              #  print(i)
                #-1 ++
                #-1 Première instruction on part de 0
            
    elif(aro=="DIV"):
            if (Data_Memory[string(arr[3])]==0):
                print("Forbidden Division")
                break
            else :
                Data_Memory[str(arr[1])]=int(int(Data_Memory[str(arr[2])])/int(Data_Memory[str(arr[3])]))
            
    elif(aro=="EQU"):
            Data_Memory[str(arr[1])] = (int(Data_Memory[str(arr[2])])==int(Data_Memory[str(arr[3])]))
            
    elif(aro=="INF"):
            Data_Memory[str(arr[1])] = (int(Data_Memory[str(arr[2])])<int(Data_Memory[str(arr[3])]))
            
    elif(aro=="SUP"):
            Data_Memory[str(arr[1])] = (int(Data_Memory[str(arr[2])])>int(Data_Memory[str(arr[3])]))
   
    elif(aro=="SUPE"):
        Data_Memory[str(arr[1])] = (int(Data_Memory[str(arr[2])])>=int(Data_Memory[str(arr[3])]))
   
    elif(aro=="INFE"):
            Data_Memory[str(arr[1])] = (int(Data_Memory[str(arr[2])])<=int(Data_Memory[str(arr[3])]))
                            
    elif(aro=="PRI"):
            print(Data_Memory[str(arr[1])])
            
    i+=1
    #print(Data_Memory)
   

    

file1.close()