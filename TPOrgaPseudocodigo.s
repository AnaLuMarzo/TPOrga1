 ###Primera parte: el programa debe elegir al azar la palabra a adivinar
 ##https://www.youtube.com/watch?v=TWitXMmX06E   random
 ##https://thinkingeek.com/2013/02/02/arm-assembler-raspberry-pi-chapter-9/
 
 #En python sería algo asi:
 lista = []   
 archivo= open("muchasPalabras.txt","r",encoding="utf8")   ## DUDA    lemario "muchasPalabras" queda guardado en la variable archivo
 for palab in archivo.readlines():   #lee linea por linea, cada palabra esta en un salto de linea
     lista.append(palab[0:-1])  #se agregan todas las palabras a la lista
 archivo.close()  #se cierra el archivo
 
import random   #¿Cómo se elije un n° al azar en assembler? DUDA
 posicionPalAdiv = random.randrange(0,len(lista))  # Elijo una palabra al azar por su posición en "lista"# desde 0 hasta= len(lista)
 palabraAdiv = lista[posicionPalAdiv]   #elijo la palabra que se tiene que adivinar en el juego
  
 rayasAdiv="_"*len(palabraAdiv)  ##dibujo x cantidad de rayitas segun la cantidad de letras de la palabra a adivinar
 
 ###debe controlar los intentos, los aciertos y los errores. También debe actualizar el dibujo del ahorcado ante cada error del jugador.
  letraJgdor=input("Ingrese una letra en minuscula, por favor")  #¿cómo hago input en assembler? tiene q estar adentro de un for para que se repita  DUDA
 vidas=8
 contErr=0
 contAci=0
 errores=0
 
 while contAci<len(palabraAdiv) and vidas>0:
    for i in range(0,len(palabraAdiv)):
         if letraJgdor==palabraAdiv[i]:
	 	mapa[i+n°]=letraJgdor     ##agregar letra en el mapa sería i + todas las posiciones hasta llegar al dibujo donde está la palabra a adivinar ## ¡?como se hace¡¡?? modos de direccionamiento??ej: ldr r2, [r3,r4]
	        contErr=0
		contAci++      ##controlo la cantidad de aciertos
		rayasAdiv[i]=letraJgdor  #Reemplazar el _ por la letra que adivino el jugador
	 else:
	        contErr++
	
    if contErr>=len(palabraAdiv):
        agregar palito en el mapa   ## ¡?como se hace¡¡?? modos de direccionamiento??ej: ldr r2, [r3,r4]
	errores++   #controlo la cantidad de errores
	vidas--
    
    letraJgdor=input("Ingrese otra letra en minuscula, por favor") 

if contAci==len(palabraAdiv) and vidas>0:
    print("Lo salvaste!")
elif contAci<len(palabraAdiv) and vidas==1:
    #2da parte, rta: 138:
    print("Responda la siguiente pregunta:")
    ##https://www.youtube.com/watch?v=ZGphVbez5iw pasar de cadena a numero
    respuesta=int(input("Entre 100 y 200 ¿Cuantos metros tiene la pirámide de Guiza?: "))
    if respuesta<=140 and respuesta>=130:
         print(Ganaste una vida!)
	 vida++
    else:
         print("Fallaste! seguis con una sola vida")
    bx lr que hago un salto y vuelva al while 
else:
    print("Lo mataste!")

#tercera parte del juego: disparar a la cuerda para ver si acierta
a=coordenada cuerda en x
b=coordenada cuerda en y
if errores >=8: #8 es la cantidad de palitos formando el ahorcado
     print("Todavía podés salvarlo elige las cordenadas en x e y")
	 x=int(input("Ingrese la primera coordenada en numero entero"))
	 y=int(input("Ingrese la segunda coordenada en numero entero"))
	 if x==a and y==b:
	     print("Lo salvaste!")
	 else:
	     print("Lo mataste!")
	 
