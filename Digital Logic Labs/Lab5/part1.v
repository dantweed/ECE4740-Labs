/*
 ECE 4740 Lab 4 - Part 4
 Author: Daniel Tweed, 6791717 
 Using parameters to define an n-bit counter modulo m
*/

module part1 (KEY, LEDR);
	input [1:0] KEY; //clock, reset;
	output [7:0] LEDR; //count
	
	counter eight_bit(KEY[1], KEY[0], LEDR);
		defparam eight_bit.n = 8;
		defparam eight_bit.m = 5;

endmodule

module counter(clock, reset_n, Q);
	parameter n;
	parameter m;

	input clock, reset_n;
	output reg [n-1:0] Q;
		
	always @(posedge clock or negedge reset_n) begin
		if (~reset_n)
			Q <= 0;			
		else if (Q < m)
			Q <= Q + 1'b1;			
		else
			Q <=0;
	end
endmodule
