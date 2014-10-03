/*
 ECE 4740 Lab 3 - Part 2.1
 Author: Daniel Tweed, 6791717 
 A gated D latch
 Code from lab description figure 2b, modified to a D latch,
 written for simulation only
*/

module part2 (Clk, D, Q);
	input Clk, D;
	output Q;	
	wire S, R, R_g, S_g, Qa, Qb /* synthesis keep */ ;
	assign S = D;
	assign R = ~D;
	assign R_g = R & Clk;
	assign S_g = S & Clk;
	assign Qa = ~(S_g | Qb);
	assign Qb = ~(R_g | Qa);
	assign Q = Qa;
endmodule