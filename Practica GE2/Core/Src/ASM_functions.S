/* ################## Guía de Ejercicios 2 ################## */
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
.global asm_pack32to16
.global asm_max

/* Ejercicio 1 */
// Prototipo en archivo .h:
//void asm_pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);

// Parámetros recibidos
//	r0:  vectorIn
//	r1:  vectorOut
//  r2:  longitud

// Valor de retorno: void
.thumb_func
 	asm_pack32to16:
		push {r4 - r7} // Se resguardan los valores de los registros en el stack

		// Guarda de seguridad
		cbz r0, _exit1	// Salir si vectorIn es una dirección nula
		cbz r1, _exit1	// Salir si vectorOut es una dirección nula

	_loop1:
		sub r2, #1	// longitud = longitud - 1
		ldr  r3, [r0, r2, LSL #2] // Se carga desde el último valor hacia el primero
		lsr  r3, r3, #16       	  // r3 = r3>>16
		strh r3, [r1, r2, LSL #1] // Se guarda el resultado
		cbz r2, _exit1	// Si r2 = 0, la función termina
		b _loop1		// De lo contrario seguimos iterando

	_exit1:
		pop {r4 - r7} // Se recuperan los valores de los registros
		bx lr

/* Ejercicio 2*/
// Prototipo en archivo .h:
//uint32_t asm_max (int32_t * vectorIn, uint32_t longitud);

// Parámetros recibidos
//	r0: vectorIn
//	r1: longitud

// Valor de retorno: uint32_t con el indice del mayor elemento
.thumb_func
	asm_max:
		push {r4 - r7} // Se resguardan los valores de los registros en el stack

		// Guarda de seguridad
		cbz r0, _exit2	// Salir si vectorIn es una dirección nula


	_exit2:
		pop {r4 - r7} // Se recuperan los valores de los registros
		bx lr

/* Ejercicio 3*/
// Prototipo en archivo .h:
//

// Parámetros recibidos
//	r0:
//	r1:


// Valor de retorno:








/* Ejercicio 4 */
// Prototipo en archivo .h:
//

// Parámetros recibidos
//	r0:
//	r1:


// Valor de retorno:





