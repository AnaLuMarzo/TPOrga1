//El programa tiene las palabras a elegir en un archivo de texto: words.txt se elige la palabra con un random.
//1. el procedimiento: print es usado para imprimir los caracteres individuales hasta.
//2. El registro R4 es usado para guardar el numero de errores que el jugador hizo durante la corrida del programa. 
//3. El archivo words.txt se abre en las primeras líneas de la fincción principal. El nombre de archivo se mantiene dentro de la etiqueta filename_word en la parte superior de la sección .data.
//4. print_ASCII_art funciona al tener dos funciones separadas: muerto - imprime el ahorcado completamente colgado, normalprint - imprime sin ahorcado. Dependiendo de la cantidad de errores que el jugador haya cometido, la función cambiará de imprimir de apoco las partes del ahorcado.
//5. Esto permite reutilizar muchas etiquetas .asciz y hacer que el código sea más compacto.
// Si el carácter introducido coincide con un carácter dentro de la palabra, el registro R6 se establece en 0 (originalmente establecido en 1). Una vez que se alcanza el final de la palabra, R6 se compara con 1 (lo que indica que no hay coincidencia) y, si es verdadero, el carácter introducido se coloca en la etiqueta incorrecta.
//R6 se agrega a R4, lo que significa que si no hay coincidencia, R6 = 1, R4 se incrementa en 1 (el número de errores aumentó), de lo contrario R4 sigue siendo el mismo.

//-----------DATOS-----------
.data
.balign 2

filename_word:  .asciz "words.txt"
filename_word_len       = .-filename_word
title_text:     .asciz "Realizado para la materia Organizacion del Computador"
title:          .asciz "Bienvenidos al juego del ahorcado"
prompt:         .asciz "Ingrese el siguiente caracter de la A-Z o 0 (cero) para salir: "

top_part2:      .asciz "\n  +-----------+"
line_1:         .asciz "\n  |        |         |   Palabra: "
line_2:         .asciz "\n  |        |         |"
line_3:         .asciz "\n  |                  |   Errores: "
line_3changed:  .asciz "\n  |        O         |   Errores: "
line_4to5:      .asciz "\n  |                  |"
line_4to5_dead: .asciz "\n  |        |         |"
line_4_1arm:    .asciz "\n  |       \\|         |"
line_4_2arms:   .asciz "\n  |       \\|/        |"
line_6_1leg:    .asciz "\n  |    __ /   __     |"
line_6_2legs:   .asciz "\n  |    __ / \\ __    |"
line_6_nolegs:  .asciz "\n  |    __     __     |"
line_7:         .asciz "\n  +------------------|"

invalid_char:   .asciz "\n  --- Caracter Invalido ---\n\n"
too_many_chars: .asciz "\n  --- Se introdujeron muchos caracteres ---\n\n"
repeat_char:    .asciz "\n  --- Ya elegiste este caracter ---\n\n"
file_missing:
lose_msg:       .asciz "\n  #### PERDISTE! - Se acabaron tus vidas ####\n\n La palabra era: "
win_msg:        .asciz "--------------\n  << GANASTE! FELICITACIONES! >>\n ---------------\n\n  The word was: "
try_again_msg:  .asciz " Quiere intentar otra vez? (Y/N): "
exit_msg:       .asciz " Gracias por jugar!\n"
quit_msg:       .asciz " salida...\n"
question:       .asciz " Para ganar una vida responda la siguiente pregunta: Entre 1 y 9 ¿Cuantos años luz de distancoa nos separa de la galaxia Andromeda?: "
newline:        .asciz "\n"

.bss
.balign 2
char:           .space 22               //Retiene la entrada del usuario
word:           .space 20               //Contiene palabras elegidas al azar
hidden_word:    .space 20               //contiene guiones bajos y caracteres adivinados de la palabra
wrong:          .space 8                //Retiene los caracteres adivinados incorrectamente
used:           .space 28               //Contiene todos los caracteres usados
buff:           .space 300              //Guarda el contenido del archivo words.txt
answer          .space 22               //Retiene la respuesta del usuario

//-----------FUNCIONES-----------

reset_round:           // Se usa para imprimir el mensaje y reanudar la ronda.
        BL print
        B next_round

win:   //para imprimir el mensaje de ganador y proponer al jugador que lo intente otra vez (pega el salto en try_again)
        LDR R1, =win_msg
        BL print
        LDR R1, =word
        BL print
        LDR R1, =newline
        BL print
        B try_again

promptchar:     //Se utiliza para obtener información del usuario. Luego, la entrada se pasa a input_valid, que verifica su validez.
        MOV R0, #0      //Configurar parámetros syscall para obtener la entrada de caracteres
        LDR R1, =char
        MOV R2, #20
        MOV R7, #3
        SVC 0
        B input_valid

print_ASCII_art:   //R1: puntero al string para imprimirlo por pantalla, R4: numero de fallas aciertos, R5: puntero a la palabra.
        PUSH {LR}                                 // Se salva el registro link
 
        LDR R1, =top_part2
        BL print
        LDR R1, =line_1
        BL print
        LDR R1, =hidden_word
        BL print
        LDR R1, =line_2
        BL print
        TEQ R4, #0
        BEQ normalprint
dead:           //Se va a imprimir los dibujos del ahorcado
        LDR R1, =line_3changed     //Se selecciona R1 para imprimir la cabeza
        BL print
        LDR R1, =wrong
        BL print
        CMP R4, #1   //Chequea si solo hay un error, si es verdad se imprime las lineas restantes sin el ahorcado
        BEQ ntorso
        CMP R4, #3
        LDRGT R1, =line_4_2arms     //Si los erroes son > 3, agarra R1 para imprimir 2 brazos
        LDREQ R1, =line_4_1arm      //Si es igual = a 3 los errores, agarrra R1 para imprimir 1 brazo
        LDRLT R1, =line_4to5_dead    //Si los errores son < 3, (2 errores) agarra R1 para imprimir el torso
        BL print
        LDR R1, =line_4to5_dead   // cambia R4 para imprimir la parte baja del torso
        BL print
        CMP R4, #5
        BLT nolegs               // SI < 5 errores, (4 errores) cambia R1 a una lineapara imprimir línea regular y pasar a impresión normal (sin piernas)
        LDREQ R1, =line_6_1leg    // SI = 5 errores, cambia R1 para imprimir una pierna    
        BGT another_oport   //Sería la 2DA PARTE DEL JUEGO, darle la oportunidad SI TIENE MAS DE 5 ERRORES salta a another_opor
        LDRGT R1, =line_6_2legs    // SI > 5 errores, (6 errores) cambia R1 para imprimir 2 piernas
        BL print
        B endpr
        
//-->comienzo 2 da parte
another_oport:        //para imprimir la pregunta y proponer al jugador que lo intente otra vez (pega el salto en try_again)
        LDR R1, =question
        BL print
        MOV R2,#0        //config los parametros de llamada al sistema para obtener los caracteres
        LDR R1, =answer      //respuesta dada por el jugador
        LDRB R2, [R1]   //Se carga el primer caracter
        LDRB R3, [R1, #1]!     //se carga el segundo
        TEQ R3, #0xA   //salto de línea (si aprieta enter), de nuevo si la entrada tiene el tamaño correcto
        BEQ char_int   //salto a camnio de Caracter a numero int 
        
char_int:
        CMP R2,#0x30   //compara si es una letra 
        SUBGE R2,#48    //Le resta para llegar al numero decimal
        CMP R2, #2   //compara el valor ingresao con la respuesta
        BEQ print
        LDRGT R1, =line_6_2legs    // SI > 5 errores, (6 errores) cambia R1 para imprimir 2 piernas
        BL print
        B endpr
    //-->fin 2da parte
    
normalprint:                   //salto para Imprimir sin el ahorcado
        LDR R1, =line_3
        BL print
        LDR R1, =wrong
        BL print

ntorso: LDR R1, =line_4to5     //Salto aca para NO imprimir el torso
        BL print
        LDR R1, =line_4to5
        BL print

nolegs: LDR R1, =line_6_nolegs      //Salto aca para NO imprimir el las piernas
        BL print
endpr:  LDR R1, =line_7    //Salto para acà para imprimir las ultimas 2 lineas (son iguales independientemente de cuántas vidas tenga el jugador)
        BL print
        POP {LR}     //restauro el registro link y vuelvo a main
        BX LR

print:        // Imprime el caracter individual hasta llegar a #0
        PUSH {R0, R3}    //se salvan los valores de los registros 
        MOV R7, #4      //las siguientes 3 líneas configuran registros para realizar escritura syscall con 1 carácter
        MOV R2, #1
        MOV R0, #0
print_loop:
        SVC 0
        LDRB R3, [R1], #1    //Carga el siguiente caracter
        TEQ R3, #0           //compara con 0 y hace un bucle si es falso (no igual)
        BNE print_loop
        POP {R0, R3}
        BX LR

try_again:       //Solicita al usuario que vuelva a intentarlo
        LDR R1, =newline
        BL print
        LDR R1, =try_again_msg   //Configura r1 para imprimir el aviso
        BL print

        MOV R2, #0        //Configura los parámetros de llamada al sistema para obtener la entrada de caracteres
        LDR R1, =char
        BL restore_data  //Se Pone a cero la etiqueta de caracteres antes de realizar la llamada al sistema de lectura

        LDR R1, =char
        MOV R0, #0
        MOV R2, #20
        MOV R7, #3
        SVC 0

        LDR R1, =newline
        BL print
        LDR R1, =char
        LDRB R2, [R1]      //Carga el primer carácter ingresado en R2
        LDRB R3, [R1, #1]!   //Carga el segundo carácter ingresado en R3
        TEQ R3, #0xA
        BEQ small_hop    //Si el segundo carácter ingresado es \n (Enter), la entrada tiene el tamaño correcto, por lo tanto, salta a la verificación S/N
        LDR R1, =too_many_chars
        BL print
        B try_again

small_hop:
        CMP R2, #0x61      // Si está en minúsculas, escriba en mayúscula el carácter
        SUBGE R2, #32
        TEQ R2, #89        //si el caracter es = Y, reinicia el juego
        BLEQ reset
        BEQ subseq_games
        CMP R2, #78      //si el caracter es = N, sale del juego
        LDREQ R1, =exit_msg
        BEQ end
        B try_again          //si no es ninguno de los dos, vuelve a preguntar

reset:        //resetea todo en la seccion .bss (excepto buffer,para evitar tener que leer el archivo de nuevo)
        PUSH {R0, LR}
        MOV R0, #0
        LDR R1, =word
        BL restore_data
        LDR R1, =used
        BL restore_data
        LDR R1, =hidden_word
        BL restore_data
        LDR R1, =wrong
        BL restore_data
        POP {R0, LR}
        BX LR

restore_data:   //R0 - null, R1 -puntero (se va a resetear a null), R2 - caracter en puntero (chequea si es null)
        LDRB R2, [R1]
        CMP R2, #0
        BXEQ LR           //Finaliza el ciclo de reinicio si es verdadero
        STRB R0, [R1], #1
        B restore_data

input_valid:    // chequea si la entrada es valida, hace que character se pase a mayùscula si no lo esta
        LDR R1, =char       //El numero de caracteres aceptado es de 20. Si el usuario ingresa más de 20 caracteres, los ramaining se interpretarán como entrada para el siguiente mensaje, o se colocarán en el terminal si el programa se cierra.
        LDRB R2, [R1]
        LDRB R3, [R1, #1]!  //para que se actualice el registro, que haga el incremento y luego se actualice
        TEQ R3, #0
        LDREQ R1, =invalid_char
        BEQ reset_round
        TEQ R3, #0xA
        LDRNE R1, =too_many_chars
        BNE reset_round
        SUB R1, R1, #1
        TEQ R2, #48     //se fija si el caracter es 0, y sale del programa si es es =0
        LDREQ R1, =quit_msg
        BEQ end
        CMP R2, #65                 //Se fija si el caracter es menor a A

        LDRLT R1, =invalid_char        //Si < A, el caracter es invalido
        BLT reset_round

        CMP R2, #90                 // Se fija si el caracter està A - Z
        STRLEB R2, [R1]
        BXLE LR
        CMP R2, #97                 // Se fija el caracter es menor a  a

        LDRLT R1, =invalid_char
        BLLT reset_round

        CMP R2, #122              // Se fija si el caracter esta entre a-z
        SUBLE R2, R2, #32           //si està entre a-z lo convierte a mayuscula
        STRLEB R2, [R1]
        BXLE LR                   //vuelve al main

end:                     //sale del programa
        MOV R0, #0
        BL print           //imprime el mensaje de salida
        MOV R7, #1
        SVC 0

//-----PROGRAMA PRINCIPAL
.global main
main:               
        LDR R1, =title     //imprime los mensajes del programa
        BL print
        LDR R1, =title_text
        BL print

        LDR R0, =filename_word    //Abre el archivo "words.txt" como lectura solamente
        MOV R1, #0
        MOV R2, #0x444
        MOV R7, #5
        SVC 0

        LDR R1, =buff        //Salva los contenidos del archivo en  =buff
        MOV R2, #199
        MOV R7, #3
        SVC 0

        MOV R7, #6       //  Se cierra el archivo
        SVC 0

subseq_games:          //Si el jugador juega otra vez, el programa salta a esta parte (evita imprimir el titulo y abrir el archivo otra vez)
        MOV R0, #0      //se configura para generar un numero aleatorio que se guarda en r0
        BL time
        BL srand
        BL rand
        AND R0, R0, #0xFF      //Logica y operacion AND para obtener solo el ultimo byte del numero random en R0

mod_loop:       //Realiza mod 10 en el byte aleatorio en R0 a través de la sustracción repetida para elegir un índice de palabras aleatorias (0 - 1ª palabra, 1 - 2ª palabra, etc.)
        CMP R0, #9
        SUBGT R0, R0, #10
        BGT mod_loop              //R0 - numero random entre 0 and 9
        PUSH {R0}                 // Salva el valor haciendo push en el stack

        POP {R0}            //restaura el valor de R0 (el indice de la palabra random)
        LDR R1, =buff
        LDR R3, =word
        LDR R4, =hidden_word
        MOV R5, #0x5F       //R5 = '_'

selectword:   //Esto hace un bucle hasta que R1 apunte al primer carácter de la palabra seleccionada al azar, esto sucede disminuyendo el número aleatorio cada vez que hay un n hasta que se convierte en 0
        LDRB R2, [R1]
        TEQ R0, #0
        BEQ saveword
        TEQ R2, #0xA
        SUBEQ R0, R0, #1
        ADD R1, R1, #1
        B selectword

saveword:         //R1 =buff, R2 es el caracter buff, R3 =word, R4 =hidden_word, R5='_', Esto guardará la palabra seleccionada al azar en la memoria
        LDRB R2, [R1]
        TEQ R2, #10              //chequea si el caracter es un salto de linea: \n
        MOVEQ R4, #0             // setea R4 (numero de errores) a 0
        BEQ next_round          // comienza el juego
        TEQ R2, #0            //Se fija si el caracrer es 0
        MOVEQ R4, #0
        BEQ next_round        //comienza el juego

        STRB R2, [R3]     //Agregar un caracter a word
        STRB R5, [R4]       //Agrega un guion bajo '_' a line_1_word
        ADD R1, R1, #1
        ADD R3, R3, #1
        ADD R4, R4, #1    //mueve todos los punteros al siguiente caracter
        B saveword

next_round:      //empieza  la siguiente ronda
        MOV R0, #0
        LDR R1, =char
        BL restore_data
        BL print_ASCII_art        //Imprime ASCII ahorcado
        LDR R1, =prompt           //imprime prompt cartel para seguir ingresando una cadena
        BL print
        BL promptchar          //Solicita al usuario una entrada de caracteres

        PUSH {R5-R7}
        PUSH {R4}           //R4 aparecerá antes de los registros restantes
        LDR R0, =char
        LDRB R0, [R0]
        LDR R1, =used
        LDR R2, =hidden_word
        LDR R3, =wrong

mark_used:   //Almacena el carácter introducido en la etiqueta used,R3 apunta a dónde se debe almacenar el siguiente carácter incorrecto. Los guiones bajos para la palabra que se va a adivinar se establecen a medida que se guarda la palabra. Al introducir un carácter válido, se compara con los caracteres de la palabra y se reemplaza en los lugares apropiados de la etiqueta con guiones bajos (letras no molestadas).
        LDRB R6, [R1]
        TEQ R0, R6
        LDREQ R1, =repeat_char
        POPEQ {R4}
        BEQ reset_round
        LDRB R4, [R3]
        TEQ R4, #0
        ADDNE R3, #1
        TEQ R6, #0
        STREQB R0, [R1]
        ADDNE R1, R1, #1
        BNE mark_used

        LDR R1, =word
        MOV R6, #1   //Si el carácter coincide, R6 se establecerá en #0. El valor de R6 se agregará a R4 al final
        MOV R7, #0

checkword:   //Se le pone de valor 1 a R7 cada vez se encuentra un simbolo '_' en hidden_word
        LDRB R5, [R1], #1
        TEQ R0, R5
        LDREQB R4, [R2]
        MOVEQ R6, #0
        STREQB R0, [R2]
        LDRB R4, [R2], #1
        TEQ R4, #0x5F
        ADDEQ R7, R7, #1
        TEQ R5, #0
        BNE checkword
        TEQ R6, #1
        STREQB R0, [R3]
        POP {R4}
        ADD R4, R4, R6

        TEQ R7, #0    //chequear si todos los caracteres fueron adivinados, si es cierto salta a nivel win
        POP {R5-R7}
        BEQ win
        TEQ R4, #6                      //chequear si no tiene errores
        BNE next_round                 //para jugar al siguiente round si el juego no termino
        BL print_ASCII_art             //imprime el final del ahorcado
        LDR R1, =lose_msg
        BL print                     //Imprimie  el mensaje de perdido
        LDR R1, =word               //Imprimir 
        BL print
        B try_again                //Salta a try_again (realizado para empezar otra vez)


.end
