/*
 ECE 4740 Lab 4 - Part 4
 Author: Daniel Tweed, 6791717 
 Counter displayed on seven segment
*/
module part4(CLOCK_50, HEX0);
	input CLOCK_50;	
	output [0:6] HEX0;
	
	wire trigger;
	wire [3:0] count;

	reg clear;
	
	oneSecDelay delay(CLOCK_50, trigger);	
	counter4bit C (clear, trigger, 1, count);		
	seven_seg SS (count, HEX0);
	
	always@(negedge trigger) begin 
		if (count >= 9)
			clear <= 0;
		else 
			clear <= 1;
	end	
endmodule

//Approx equivalent to a 60 Hz clock
module oneSecDelay(clock, out);
	input clock;
	output reg out; //active high trigger
	
	reg [31:0] count = 0;
			
	always@(posedge clock) begin
		if (count >= 50000000) begin
			out <= 1;
			count <= 0;
		end else begin
			count <= count + 1;			
			out <= 0;
		end
	end

endmodule

//Re-used code from part 1
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

//Re-used code from lab 3
module seven_seg (in, out);
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
