.equ STACK, 0x10000
.equ N, 6

.global _start

	/* 
	 *  Macros founds in "IL2206 Embedded Systems 2009: Getting started with NIOS II.."  
	 *	Course notes: Royal Institute of Technology, Stockholm, Sweden (author not listed)
	 *	Online: http://www.ict.kth.se/courses/IL2206/0910/ovn/IL2206-ovn0-2009.pdf
	 */ 
.macro PUSH reg
	subi 	sp, sp, 4
	stw 	\reg, 0(sp)
.endm

.macro POP reg
	ldw 	\reg, 0(sp)
	addi 	sp, sp, 4
.endm

_start:
	movia 	sp, STACK				/* Initialize stack  */
	movia	r3, N
	PUSH 	r3							
	call	FIBONACCI

END:	
	br		END			  /* Remain here if done */
	
FIBONACCI:
	POP		r5			/* Grab N from the stack */
	PUSH	ra			/* Preserve registers */
	PUSH	r6
	PUSH	r7
	beq		r5, zero, N_ZERO	/* Check is N = 0 */
	subi	r5, r5, 1
	beq		r5, zero, N_ONE		/* Check if N = 1 */
	br		N_GTE2				/* Otherwise, N >= 2 */
	
N_ZERO:
	addi	r4, zero, 0
	br		DONE
	
N_ONE:
	addi	r4, zero, 1
	br		DONE
	
N_GTE2:
	subi	r6, r5, 1
	PUSH	r5
	call	FIBONACCI	/* fib(n-1) */
	addi	r7, r4, 0
	PUSH 	r6
	call	FIBONACCI	/* fib(n-2) */
	add 	r4, r4, r7  /* fib(n) = fib (n-2) + fib(n-1)
	
DONE:
	POP		r7
	POP		r6
	POP		ra		/* restore registers */ 
	ret
	
	
	
	
	