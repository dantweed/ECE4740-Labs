/*
 ECE 4740 Lab 3 - Part 1
 Author: Daniel Tweed, 6791717 
 A gated RS latch, implmented for simulation
 only
*/

//Code from lab description figure 2b
module part1 (Clk, R, S, Q);
	input Clk, R, S;
	output Q;
	wire R_g, S_g, Qa, Qb /* synthesis keep */ ;
	assign R_g = R & Clk;
	assign S_g = S & Clk;
	assign Qa = ~(R_g | Qb);
	assign Qb = ~(S_g | Qa);
	assign Q = Qa;
endmodule