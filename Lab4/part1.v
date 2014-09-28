/*
 ECE 4740 Lab 4 - Part 1
 Author: Daniel Tweed, 6791717 
 Fun with counters
*/

module part1(SW, KEY, HEX0, HEX1);
	input [1:0]SW; //enable, clear
	input [1:0]KEY; //unused, clock
	output [0:6]HEX0, HEX1;
	
	wire [3:0] Q;	
		
	counter4bit C(SW[0], KEY[0], SW[1], Q); //Used in fifth part
	//HEXseven_seg(Q[7:4], HEX1);  //Used in first part
	HEXseven_seg(Q[3:0], HEX0);
	
endmodule


module counter8bit(clear, clock, enable, Q);
	input clear, clock, enable;	
	output [7:0] Q;
	
	wire [7:0] e;
	
	assign e[0] = enable;	
	Tflipflop t0 (clear, clock, e[0], Q[0]);
	assign e[1] = e[0] & Q[0];
	Tflipflop t1 (clear, clock, e[1], Q[1]);
	assign e[2] = e[1] & Q[1];
	Tflipflop t2 (clear, clock, e[2], Q[2]);
	assign e[3] = e[2] & Q[2];
	Tflipflop t3 (clear, clock, e[3], Q[3]);
	assign e[4] = e[3] & Q[3];
	Tflipflop t4 (clear, clock, e[4], Q[4]);
	assign e[5] = e[4] & Q[4];
	Tflipflop t5 (clear, clock, e[5], Q[5]);
	assign e[6] = e[5] & Q[5];
	Tflipflop t6 (clear, clock, e[6], Q[6]);
	assign e[7] = e[6] & Q[6];
	Tflipflop t7 (clear, clock, e[7], Q[7]);
	
endmodule

module counter4bit(clear, clock, enable, Q);
	input clear, clock, enable;	
	output [3:0] Q;
	
	wire [3:0] e;
	
	assign e[0] = enable;	
	Tflipflop t0 (clear, clock, e[0], Q[0]);
	assign e[1] = e[0] & Q[0];
	Tflipflop t1 (clear, clock, e[1], Q[1]);
	assign e[2] = e[1] & Q[1];
	Tflipflop t2 (clear, clock, e[2], Q[2]);
	assign e[3] = e[2] & Q[2];
	Tflipflop t3 (clear, clock, e[3], Q[3]);	
	
endmodule

module Tflipflop(clear, clock, T, Q);
	input clear, clock, T;
	output reg Q;	
	
	always@(posedge clock)
		if (~clear)
			Q = 0;			
		else if (T) 
			Q = ~Q;					
endmodule

//From lab3 part 5
module HEXseven_seg (in, out);
	input [3:0] in;
	output reg[0:6] out;
	
	always@(in)
	begin
		case (in)
			0: out = 7'b0000001; 
			1: out = 7'b1001111;
			2: out = 7'b0010010;
			3: out = 7'b0000110;
			4: out = 7'b1001100;
			5: out = 7'b0100100;
			6: out = 7'b1100000;
			7: out = 7'b0001111;
			8: out = 7'b0000000;
			9: out = 7'b0001100;
			10:out = 7'b0001000;
			11:out = 7'b1100000;
			12:out = 7'b0110001;
			13:out = 7'b1000010;
			14:out = 7'b0110000;
			15:out = 7'b0111000;
			default: out = 7'b1111111;
		endcase
	end
endmodule

