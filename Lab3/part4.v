/*
 ECE 4740 Lab 3 - Part 4
 Author: Daniel Tweed, 6791717 
 A gated D latch
 Using gated D latches to implement positive
 and negative edge triggered D flip flops.
*/

module part4(D, Clk, Qa, Qb, Qc);
	
	input D, Clk;
	output Qa, Qb, Qc;
	
	D_latch A(D, Clk, Qa);
	D_FF posFF(D, Clk, Qb);
	D_FF negFF(D, ~Clk, Qc);

endmodule

module D_latch(D, Clk, Q);
	input D, Clk;
	output reg Q;
	
	always@(D,Clk)
		if (Clk)
			Q=D;
endmodule

module D_FF(D, Clk, Q);
	input D, Clk;
	output Q;
	
	wire Qm;
	
	D_latch D0(D, ~Clk, Qm);
	D_latch D1(Qm, Clk, Q);
endmodule

