.equ LIST_FILE, 0x9000
.equ STACK, 0x10000

.global _start

	/* Macros founds in "IL2206 Embedded Systems 2009: Getting started with NIOS II.."  
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
	addi	r3, zero, 0
	movia	r3, LIST_FILE
	ldw		r2, (r3)		/* Size of the list*/
	addi	r3, r3, 4			/* Address of the first element of the list */
	call	SORT	
DONE:	
	br		DONE			  /* Remain here if done */

SORT:	
	PUSH	r4
	PUSH	r5
	PUSH	r6
	PUSH	r7
	PUSH	r8
	PUSH	r9
	PUSH	r10
	PUSH	r11
	PUSH	r12
	PUSH	r13					/* Preserve register values */
	
	addi	r5, r2, 0  			/* r5 is outer loop counter */	
 	ldw		r7, (r3)	  		/* r7 holds the current largest number found so far */	
	subi	r13, r2, 0			/* r13 used to set initial value of inner loop counter */
	addi 	r4, r3, 0			/* r4 used as the outer loop pointer */
	addi	r9, r3, 0			/* r9 used as the inner loop pointer */
	
OUTERLOOP:
	subi	r5, r5, 1       	/* Decrement the counter */
	beq		r5, r0, STOP  		/* Finished if r5 is equal to 0 */
	addi	r6, r13,0			/* r6 is the inner loop counter */	
	ldw		r7, (r4)
	add		r12, r4, r0
	
INNERLOOP:
	subi	r6, r6, 1	  		/* Decrement the counter */
	beq		r6, r0, SWAP    	/* Finished if r6 is equal to 0 */
	addi	r9, r9, 4	  		/* Increment the inner loop pointer */
	ldw		r8, (r9)	  		/* Get the next number */
	bge		r7, r8, INNERLOOP 	/* Check if larger number found */
	addi 	r7, r8, 0
	add		r12, r9, r0	  		/* Update the address  largest number found	*/
	br		INNERLOOP

SWAP:
	ldw 	r10, (r12)
	ldw 	r11, (r4)
	stw		r10, (r4)
	stw		r11, (r12)
	subi 	r13, r13, 1
	addi 	r7, r8, 0
	addi 	r4, r3, 4			/* r4 used as the outer loop pointer */
	addi	r9, r4, 4			/* r9 used as the inner loop pointer */
	br 		OUTERLOOP
	
STOP:	
	POP		r13
	POP		r12
	POP		r11
	POP		r10
	POP		r9
	POP		r8
	POP		r7
	POP		r6
	POP		r5
	POP		r4					/* Recover register values*/ 
	ret		



