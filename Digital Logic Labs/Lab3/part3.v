/*
 ECE 4740 Lab 3 - Part 3
 Author: Daniel Tweed, 6791717 
 A gated D latch
 Using gated D latches to implement a master-slave
 D flip flop.
*/

module part3(SW, LEDR);

	input [1:0] SW; //D and lock 
	output [0:0] LEDR; //Q
	
	wire Qm;
	
	gated_Dlatch master(SW[1], SW[0], Qm);
	gated_Dlatch slave (SW[1], Qm, LEDR);
	
endmodule

module gated_Dlatch (Clk, D, Q);
	input D, Clk;
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