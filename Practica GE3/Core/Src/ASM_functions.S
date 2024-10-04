/* ################## Guía de Ejercicios 3 ################## */
/* ## Repositorio:                                         ## */
/* ##  https://github.com/RobAxt/AdM_workspace/tree/main   ## */
/* ########################################################## */
/* ## Grupo:                                               ## */
/* ##  e2301 Agustín Jesús Vazquez                         ## */
/* ##  e2312 Franco Chiesa Docampo                         ## */
/* ##  i0616 Roberto Oscar Axt                             ## */
/* ########################################################## */

.text
.syntax unified
.thumb

/* Exportar funciones*/
.global asm_potencia
.global asm_potencia_DSP

/* Ejercicio 1 */
//Ciclos_C   = 148
//Ciclos_ASM =
//Ciclos_DSP =
// Prototipo en archivo .h:
//uint32_t asm_potencia (int16_t * vecIn, uint32_t longitud);

// Parámetros recibidos
//	r0:  vecIn
//	r1:  longitud

// Valor de retorno: uint32_t
.thumb_func
 	asm_potencia:
		push {r4 - r7}  // Se resguardan los valores de los registros en el stack
		cbz r0, _exit1	// Guarda de seguridad. Salir si vectorIn es una dirección nula
        mov r4, 0       // Acumulador inicializado en cero
        mov r5, r1      // Salvo longitud
	_loop1:
		sub   r1, #1	// longitud = longitud - 1
		ldrsh r3, [r0, r1, LSL #1] // Se carga desde el último valor hacia el primero
	    mul   r3, r3, r3   //MLA
	    add   r4,r3
		cbz  r1, _exit1	// Si r2 = 0, la función termina
		b    _loop1		// De lo contrario seguimos iterando

	_exit1:
	    udiv r0, r4, r5
		pop {r4 - r7} // Se recuperan los valores de los registros
		bx lr

.thumb_func
	asm_potencia_DSP:
		push {r4 - r7}  // Se resguardan los valores de los registros en el stack
		cbz r0, _exit1_dsp	// Guarda de seguridad. Salir si vectorIn es una dirección nula
        mov r4, 0       // Acumulador inicializado en cero
        mov r5, r1      // Salvo longitud

	_exit1_dsp:
		pop {r4 - r7} // Se recuperan los valores de los registros
		bx lr


/* Ejercicio 2*/
// Prototipo en archivo .h:
//

// Parámetros recibidos
//	r0: vectorIn
//	r1: longitud

// Valor de retorno: uint32_t con el indice del mayor elemento

/* Ejercicio 3*/
// Prototipo en archivo .h:
//

// Parámetros recibidos
//	r0: vectorIn
//	r1: vectorOut
//  r2: longitud
//  r3: N

// Valor de retorno: void

