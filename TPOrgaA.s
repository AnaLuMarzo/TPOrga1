 ###Primera parte: el programa debe elegir al azar la palabra a adivinar

.data 
palabra: .asciz "programa", "computadora", "pantalla", "codigo", "bucle"
#mensajes de la segunda parte del juego:
address_of_message1 : .word message1
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_return : .word return

#2da parte, rta: 138:   https://thinkingeek.com/2013/02/02/arm-assembler-raspberry-pi-chapter-9/
    /* First message */
   .balign 4
   message1: .asciz "Para ganar otra vida, responda: entre 100 y 200 ¿Cuantos metros tiene la pirámide de Guiza?: "
   /* Format pattern for scanf */
   .balign 4
   scan_pattern : .asciz "%d"

   /* Where scanf will store the number read */
   .balign 4
   number_read: .word 0

   .balign 4
   return: .word 0

   .text

    ParteDos:
      .fnstart
      ldr r1, address_of_return        /* r1 ← &address_of_return */
      str lr, [r1]                     /* *r1 ← lr */

      ldr r0, address_of_message1      /* r0 ← &message1 */
      bl printf                        /* call to printf */

      ldr r0, address_of_scan_pattern  /* r0 ← &scan_pattern */
      ldr r1, address_of_number_read   /* r1 ← &number_read */
      bl scanf                         /* call to scanf */

      ldr r1, [r1]                     /* r1 ← *r1 */
      bl printf                        /* call to printf */

      ldr r0, address_of_number_read   /* r0 ← &number_read */
      ldr r0, [r0]                     /* r0 ← *r0 */

      ldr lr, address_of_return        /* lr ← &address_of_return */
      ldr lr, [lr]                     /* lr ← *lr */
      bx lr                            /* return from main using lr */
  
      .fnend
    /* External */
   .global printf
   .global scanf
   
##elegir numero al azar, hacer funcion no sè como
##preguntar:
elijoPalabra:
   .fnstart
   
   .fnend

dibujoCantLetPalab:
   .fnstart
   arrobasxLetras="@"*len(palabraAdiv)  ##dibujo x cantidad de rayitas segun la cantidad de letras de la palabra a adivinar
 
   .fnend

 
 ###debe controlar los intentos, los aciertos y los errores. También debe actualizar el dibujo del ahorcado ante cada error del jugador.
  letraJgdor=input("Ingrese una letra en minuscula, por favor: ")  #¿cómo hago input en assembler? tiene q estar adentro de un for para que se repita  DUDA
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
		rayasAdiv[i]=letraJgdor  #VER! NO ME ACUERDO DI ES ASÍ #para reemplazar el @ por la letra que adivino el jugador
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
   -->salto a la funcion ParteDos
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
	 
