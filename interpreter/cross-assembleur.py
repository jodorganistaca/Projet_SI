file1 = open('../output/assembleur.asm', 'r')
file2=open('../output/crossassembleur.txt', 'w')
lines = file1.readlines()
Data_Memory={}
#While not end of line
i = 0
#print(len(lines))
while (i<len(lines)) :
    
    arr = lines[i].split(" ")
    aro = arr[0]
    

    print("ok")
   # print(arr)
   # "int /16" + "int%16" ...  
   #00050489
   #
    if (aro=="AFC"):
        pt=str(int(int(arr[1])/16))+str(int(arr[1])%16)
        pt2=str(int(int(arr[2])/16))+str(int(arr[2])%16)
        Data_Memory[str(arr[1])]=int(arr[2])
        file2.write(pt+"05"+pt2+"00\n") 
        print(pt+"05"+pt2+"00\n")
            
    elif(aro=="COP") :
        Data_Memory[str(arr[1])]=Data_Memory[str(arr[2])]
        pt=str(int(int(arr[1])/16))+str(int(arr[1])%16)
        pt2=str(int(int(arr[2])/16))+str(int(arr[2])%16)
        file2.write(pt+"04"+pt2+"00\n")  
            
    elif(aro=="ADD") :
        Data_Memory[str(arr[1])]=int(Data_Memory[str(arr[2])])+int(Data_Memory[str(arr[3])])
        pt=str(int(int(arr[1])/16))+str(int(arr[1])%16)
        pt2=str(int(int(arr[2])/16))+str(int(arr[2])%16)
        file2.write(pt+"0"+pt2+"00\n")     
    elif(aro=="MUL"):
        Data_Memory[str(arr[1])]=int(Data_Memory[str(arr[2])])*int(Data_Memory[str(arr[3])])
        pt=str(int(int(arr[1])/16))+str(int(arr[1])%16)
        pt2=str(int(int(arr[2])/16))+str(int(arr[2])%16)
        file2.write(pt+"0"+pt2+"00\n")              
            
    elif(aro=="SOU"):
        Data_Memory[str(arr[1])]=int(Data_Memory[str(arr[2])])-int(Data_Memory[str(arr[3])])
        pt=str(int(int(arr[1])/16))+str(int(arr[1])%16)
        pt2=str(int(int(arr[2])/16))+str(int(arr[2])%16)
        file2.write(pt+"0"+pt2+"00\n")      
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
            if (Data_Memory[str(arr[3])]==0):
                print("Forbidden Division")
                break
            else :
                Data_Memory[str(arr[1])]=int(int(Data_Memory[str(arr[2])])/int(Data_Memory[str(arr[3])]))
    elif(aro=="PRI"):
            print(Data_Memory[str(arr[1])])    
       
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
    i+=1                         
    
            
    
    #print(Data_Memory)
   

    

file1.close()
file2.close()