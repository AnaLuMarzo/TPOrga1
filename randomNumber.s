#del video: https://www.youtube.com/watch?v=5W5RNIH_I4Y

.model small
.stack 100h

.data 
  randomNum db 0   # salvo nuestro num random 
  
main:
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    mov dx, offset
    int 21h    #
    
  
generateRandomNumber:
     mov ah, 0   #interrupo para tener el tiempo del sistema
     int 1ah     #ahora el numero del reloj se salva en DX
     
     mov ax,dx   #muevo el numero de las agujas en ax
     mov dx,o         #limpio dx a cero
     mov bx,10    #bx=10 nuestro divisor genera numero entre 0 y9 
     div bx   #divide ax por bx ax=152, bx=10, entonces dx=0
     
     mov randomNum, dl    # obtengo el divisor de dl y lo guardo en la variable randomNum 
     ret                  #devuele a nuestro codigo donde lo llamamos
