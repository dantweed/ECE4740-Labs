.equ LIST_FILE, 0x9000

.global _start
_start:
	
	movia	r4, LIST_FILE
	ldw		r5, (r4)  			/* r5 is outer loop counter */	
 	ldw		r7, 4(r4)	  		/* r7 holds the current largest number found so far */	
	subi	r13, r5, 0			/* r13 used to set initial value of inner loop counter */
	
OUTERLOOP:
	subi	r5, r5, 1       	/* Decrement the counter */
	beq		r5, r0, STOP  		/* Finished if r5 is equal to 0 */
	addi	r6, r13,0			/* r6 is the inner loop counter */
	addi 	r4, r4, 4			/* r4 used as the outer loop pointer */
	addi	r9, r4, 0			/* r9 used as the inner loop pointer */
	ldw		r7, (r4)
	add		r12, r4, r0
	
INNERLOOP:
	subi	r6, r6, 1	  		/* Decrement the counter */
	beq		r6, r0, SWAP    	/* Finished if r5 is equal to 0 */
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
	br 		OUTERLOOP
	
STOP:	
	br		STOP		  /* Remain here if done */

