 ###Primera parte: el programa debe elegir al azar la palabra a adivinar
 #En python sería algo asi:
 lista = []   
 archivo= open("muchasPalabras.txt","r",encoding="utf8")   ## DUDA    lemario "muchasPalabras" queda guardado en la variable archivo
 for palab in archivo.readlines():   #lee linea por linea, cada palabra esta en un salto de linea
     lista.append(palab[0:-1])  #se agregan todas las palabras a la lista
 archivo.close()  #se cierra el archivo
 
import random   #¿Cómo se elije un n° al azar en assembler? DUDA
 posicionPalAdiv = random.randrange(0,len(lista))  # Elijo una palabra al azar por su posición en "lista"# desde 0 hasta= len(lista)
 palabraAdiv = lista[posicionPalAdiv]   #elijo la palabra que se tiene que adivinar en el juego
  
 rayasAdiv="@"*len(palabraAdiv)  ##dibujo x cantidad de rayitas segun la cantidad de letras de la palabra a adivinar
 
 ###debe controlar los intentos, los aciertos y los errores. También debe actualizar el dibujo del ahorcado ante cada error del jugador.
  letraJgdor=input("Ingrese una letra en minuscula, por favor")  #¿cómo hago input en assembler? tiene q estar adentro de un for para que se repita  DUDA
 contErr=0
 contAci=0
 errores=0
 while contAci!=len(palabraAdiv):
    for i in range(0,len(palabraAdiv)):
         if letraJgdor==palabraAdiv[i]:
	 	    mapa[]     ##agregar letra en el mapa   ## ¡?como se hace¡¡?? modos de direccionamiento??ej: ldr r2, [r3,r4]
	        contErr=0
		    contAci++      ##controlo la cantidad de aciertos
			rayasAdiv[i]=letraJgdor  #VER! NO ME ACUERDO DI ES ASÍ #para reemplazar el @ por la letra que adivino el jugador
	     else:
	        contErr++
    if contErr>=len(palabraAdiv):
        agregar palito en el mapa   ## ¡?como se hace¡¡?? modos de direccionamiento??ej: ldr r2, [r3,r4]
	    errores++   #controlo la cantidad de errores
		
	letraJgdor=input("Ingrese otra letra en minuscula, por favor") 
	
 