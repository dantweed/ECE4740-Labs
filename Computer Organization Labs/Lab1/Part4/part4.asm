.equ n, 0xffc
.equ store, 0x1000
.global _start

_start:
	movia	r4, store	*r4 points to next available
							storage address*/
	ldw r5, 0(n)		*r4 is used to as a counter */
						*the first two Fibonacci numbers 
							NB: Assumes n > 2 (otherwise
							why write a program?)
						*/
	stw 0, (r4)			
	addi r4, r4, 1 		*increment the address pointer*/
	subi r5, r5, 1		*decrement the counter*/
	stw 1, (r4)			
	addi r4, r4, 1 		*increment the address pointer*/
	
	
LOOP:
	subi r5, r5, 1		*decrement the counter*/
	beq r5, r0, DONE	*finished when counter hits zero
	add r7, (r4-1), (r4-2)
	stw r7, (r4)		*store the next Fibonacci number*/
	addi r4, r4, 1 		*increment the address pointer*/
		
DONE:
	br DONE				*stay here is done*/