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
.global asm_medDif
.global asm_medDif_DSP

/* Ejercicio 1 */
//Ciclos_C   = 246
//Ciclos_ASM =  73
//Ciclos_DSP =  51
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
		sub   r1, #1	           // longitud = longitud - 1
		ldrsh r3, [r0, r1, LSL #1] // Se carga desde el último valor hacia el primero
	    mla   r4,r3,r3,r4          // mul   r3, r3, r3  |  add   r4,r3
		cbz   r1, _exit1	       // Si r1 = 0, la función termina
		b     _loop1		       // De lo contrario seguimos iterando

	_exit1:
	    udiv r0, r4, r5
		pop {r4 - r7} // Se recuperan los valores de los registros
		bx lr

.thumb_func
	asm_potencia_DSP:
		push {r4 - r7}      // Se resguardan los valores de los registros en el stack
		cbz r0, _exit1_dsp	// Guarda de seguridad. Salir si vectorIn es una dirección nula
        mov r4, 0           // Acumulador inicializado en cero
        mov r5, r1          // Salvo longitud

	_loop1_dsp:
		sub   r1, #2	           // longitud = longitud - 2
		ldr   r3, [r0, r1, LSL #1] // Se carga desde el último valor hacia el primero de a dos
	    smlad r4,r3,r3,r4          // multiplicar y sumar dos elementos
		cbz   r1, _exit1_dsp       // Si r1 = 0, la función termina
		b     _loop1_dsp		   // De lo contrario seguimos iterando

	_exit1_dsp:
	    udiv r0, r4, r5
		pop {r4 - r7} // Se recuperan los valores de los registros
		bx lr


/* Ejercicio 2*/
//Ciclos_C   = 464
//Ciclos_ASM = 131
//Ciclos_DSP =  52
// Prototipo en archivo .h:
// void asm_medDif(int8_t * e, int8_t *x, int8_t *y, uint16_t longitud);

// Parámetros recibidos
//	r0: e
//	r1: x
//	r2: y
//	r3: longitud

// Valor de retorno: void
.thumb_func
	asm_medDif:
		push {r4 - r7}  // Se resguardan los valores de los registros en el stack
		cbz r0, _exit2	// Guarda de seguridad.
		cbz r1, _exit2	// Guarda de seguridad.
		cbz r2, _exit2	// Guarda de seguridad.

	_loop2:
		sub   r3, #1	   // longitud = longitud - 1
		ldrsb r4, [r1, r3] // Se carga x
	    ldrsb r5, [r2, r3] // Se carga y
	    sub   r6, r4, r5   //  'e' = 'x' - 'y'
	    asr   r6, r6, #1   //  'e' = ('x' - 'y') / 2
	    strb  r6, [r0, r3] //   e  = 'e'
		cbz   r3, _exit2   // Si r3 = 0, la función termina
		b     _loop2	   // De lo contrario seguimos iterando

	_exit2:
		pop {r4 - r7} // Se recuperan los valores de los registros
		bx lr

.thumb_func
	asm_medDif_DSP:
		push {r4 - r7}  // Se resguardan los valores de los registros en el stack
		cbz r0, _exit2_dsp	// Guarda de seguridad.
		cbz r1, _exit2_dsp	// Guarda de seguridad.
		cbz r2, _exit2_dsp	// Guarda de seguridad.

	_loop2_dsp:
		sub    r3, #4	        // longitud = longitud - 4
		ldr    r4, [r1, r3]     // Se carga x
	    ldr    r5, [r2, r3]     // Se carga y
        shsub8 r6, r4, r5       // 'e' = ('x' - 'y') / 2
	    str    r6, [r0, r3]     //  e  = 'e'
		cbz    r3, _exit2_dsp          // Si r3 = 0, la función termina
		b      _loop2_dsp	           // De lo contrario seguimos iterando

	_exit2_dsp:
		pop {r4 - r7} // Se recuperan los valores de los registros
		bx lr




/* Ejercicio 3*/
// Prototipo en archivo .h:
//

// Parámetros recibidos
//	r0: vectorIn
//	r1: vectorOut
//  r2: longitud
//  r3: N

// Valor de retorno: void

