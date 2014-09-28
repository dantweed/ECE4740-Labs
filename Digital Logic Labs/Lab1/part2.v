/*
 ECE 4740 Lab 1 - Part 2
 Author: Daniel Tweed, 6791717 
 8-bit MUX 
 Code from Dr. McLeod's lab outline notes
*/

module part2 (SW, LEDR, LEDG);
	input [17:0]SW;
	output [17:0]LEDR;
	output [7:0]LEDG;
	
	// Display input values of x0,y0 ... x7, y7 on red LED's
	assign LEDR = SW;
	
	// SW[17] is selector between (x0, y0) ... (x7, y7) <==> SW[0],SW[8] ... SW[7],SW[15]
	// Display output values on green LED's
	assign LEDG[7:0] = (SW[17] == 0 )?SW[7:0]:SW[15:8] ;
endmodule