file1 = open('../output/assembleur.asm', 'r')

lines = file1.readlines()
Data_Memory={}
#While not end of line
i = 0
while (i<len(lines)) :
    
    arr = lines[i].split(" ")
    aro = arr[0]
    #print(arr)
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
            i = arr[1]-1
            # -1 car il ya un ++ à la fin
            
    elif(aro=="JMF"):
            if(Data_Memory[str(arr[1])]):
                i = arr[2]-1
            
    elif(aro=="DIV"):
            if (arr[3]==0):
                print("Forbidden Division")
                
            else :
                Data_Memory[str(arr[1])]=int(int(Data_Memory[str(arr[2])])/int(Data_Memory[str(arr[3])]))
            
    elif(aro=="EQU"):
            Data_Memory[str(arr[1])] = (int(Data_Memory[str(arr[2])])==int(Data_Memory[str(arr[3])]))
            
    elif(aro=="INF"):
            Data_Memory[str(arr[1])] = (int(Data_Memory[str(arr[2])])<int(Data_Memory[str(arr[3])]))
            
    elif(aro=="SUP"):
            Data_Memory[str(arr[1])] = (int(Data_Memory[str(arr[2])])>int(Data_Memory[str(arr[3])]))
            
    elif(aro=="PRI"):
            print(Data_Memory[str(arr[1])])
            
    i+=1
    #print(Data_Memory)
   

    

file1.close()