/*
 ECE 4740 Lab 4 - Part 4
 Author: Daniel Tweed, 6791717 
 Three digit BCD counter, with count displayed on seven segment displays
*/

module part2 (CLOCK_50, KEY, HEX2, HEX1, HEX0);
	input CLOCK_50;
	input [0:0] KEY;
	output [0:6] HEX2, HEX1, HEX0;
	
	wire [11:0] count;
	wire trigger;
	
	oneSecDelay delay(CLOCK_50, trigger);
	BCDcounter_3digit BCD(KEY[0], trigger, count);
	
	seven_seg SS0 (count[3:0], HEX0);
	seven_seg SS1 (count[7:4], HEX1);
	seven_seg SS2 (count[11:8], HEX2);

	
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

module BCDcounter_3digit(clear, clock, out);
	input clear, clock;
	output [11:0] out;
	
	reg clk1, clk2;
	
	counter four_bit0(clock, clear, out[3:0]);
		defparam four_bit0.n = 4;
		defparam four_bit0.m = 10;
	counter four_bit1(clk1, clear, out[7:4]);
		defparam four_bit1.n = 4;
		defparam four_bit1.m = 10;
	counter four_bit2(clk2, clear, out[11:8]);
		defparam four_bit2.n = 4;
		defparam four_bit2.m = 10;

	always@(posedge clock) begin
		if (out[3:0] >= 9)
			clk1 <= 1;
		else clk1 <=0;
		
		if (out[7:4] >= 9)
			clk2 <= 1;
		else 
			clk2 <=0;				
	end
endmodule

//Code from part 1 
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
			default: out = 7'b1111111;
		endcase
	end
endmodule