/*
 ECE 4740 Lab 3 - Part 2.4
 Author: Daniel Tweed, 6791717 
 A gated D latch
 Code from lab description figure 2b, modified to a D latch
 implementable on the DE2-115 board
*/

// A gated D latch
//Code from lab description figure 2b, modified to a D latch
//Implementable on the DE2-115 board
module part2 (SW, LEDR);
	input [1:0] SW;  //D and lock 
	output [0:0] LEDR;	//Q
	
	wire Clk, S, R, R_g, S_g, Qa, Qb /* synthesis keep */ ;
	
	assign Clk = SW[1]; 
	assign S = SW[0]; //D
	assign R = ~SW[0]; //~D
	assign R_g = R & Clk;
	assign S_g = S & Clk;
	assign Qa = ~(S_g | Qb);
	assign Qb = ~(R_g | Qa);
	assign LEDR = Qa;  //Q
	
endmodule