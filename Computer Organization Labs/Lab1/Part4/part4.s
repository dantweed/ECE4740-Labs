.equ STORE, 0x1000
.equ N, 0xffc
.global _start

_start:
	movia	r4, STORE	/*r4 points to next available
							storage address*/	
	movia	r3, N
	ldw r5, (r3)	/*r5 is used to as a counter */
						
/*the first two Fibonacci numbers 
NB: Assumes n > 2 (otherwise why write a program?)*/
	stw zero, (r4)			
	
	subi r5, r5, 1		/*decrement the counter*/
	movia r8, 1	
	stw r8, 4(r4)	
	
	
LOOP:
	subi r5, r5, 1		/*decrement the counter*/
	beq r5, r0, DONE	/*finished when counter hits zero*/
	ldw r8, 4(r4)
	ldw r6, (r4)
	add r7, r8, r6
	stw r7, 8(r4)		/*store the next Fibonacci number*/
	addi r4, r4, 4 		/*increment the address pointer*/
	br LOOP	
DONE:
	br DONE				/*stay here is done*/
	
	.org 0xffc
COUNT:
	.word 18				/*Number of Fibonacci numbers to
							calculate*/

