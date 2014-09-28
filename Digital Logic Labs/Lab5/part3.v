/*
 ECE 4740 Lab 4 - Part 4
 Author: Daniel Tweed, 6791717 
 Time of day clock, using BCD counters from part 2. Allows pre-set 
 of current HH:MM.
*/

module part3(CLOCK_50, SW, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2);
	input CLOCK_50;
	input [17:0] SW;
	output [0:6] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2;
	
	wire [8:0] hour, min, sec;
	
	wire trigger;
	reg sec_trigger, min_trigger, hr_trigger;		
		
	clock60Hz clock60 (SW[17], CLOCK_50, trigger);
	
	BCDcounter_2digit(clear, clock, out);
	
	BCDcounter_2digit BCD_sec (1, 0, sec_trigger, sec);
		defparam BCD_sec.mod = 60;
	BCDcounter_2digit BCD_min (1, SW[7:0], min_trigger, min);
		defparam BCD_min.mod = 60;
	BCDcounter_2digit BCD_hr (1, SW[15:8], hr_trigger, hour);
		defparam BCD_hr.mod = 24;
	
	seven_seg SS2 (sec[3:0], HEX2);
	seven_seg SS3 (sec[7:4], HEX3);
	seven_seg SS4 (min[3:0], HEX4);
	seven_seg SS5 (min[7:4], HEX5);
	seven_seg SS6 (hour[3:0], HEX6);
	seven_seg SS7 (hour[7:0], HEX7);	
	
	always@(negedge CLOCK_50) begin			
		sec_trigger <= trigger;
		if (sec == 0)
			min_trigger <= 1;
		else
			min_trigger <= 0;		
	end	

	always@(negedge min_trigger) begin
		if (min == 0)
			hr_trigger <= 1;
		else
			hr_trigger <= 0;		
	end
endmodule


//Approx equivalent to a 60 Hz clock
module clock60Hz(enable, clock, out);
	input clock, enable;
	output reg out; 
	
	reg [31:0] count = 0;
			
	always@(posedge clock) begin
		if (enable) begin 
			if (count >= 50000000) begin
				out <= 1;
				count <= 0;
			end else begin
				count <= count + 1;			
				out <= 0;
			end
		end
	end

endmodule

//Modified from part 2, to be a 2 digit counter
module BCDcounter_2digit(clear, set, clock, out);
	parameter mod = 0;
	
	input clear, clock;
	input [7:0] set;
	output [7:0] out;
	
	reg clk1, clk2, reset;
	
	counter four_bit0(clock, set[3:0], reset, out[3:0]);
		defparam four_bit0.n = 4;
		defparam four_bit0.m = 10;
	counter four_bit1(clk1, set[7:4], reset, out[7:4]);
		defparam four_bit1.n = 4;
		defparam four_bit1.m = 10;	

	always@(posedge clock) begin
		if (out[3:0] >= 9)
			clk1 <= 1;
		else clk1 <=0;						
		if (out >= mod)
			reset <= 0;
		else 
			reset <= clear;
		
	end
endmodule

//Code from part 1 
module counter(clock, set, reset_n, Q);
	parameter n;
	parameter m;
	
	input clock, reset_n;
	input [n-1:0] set;
	output reg [n-1:0] Q;
	
	initial
		Q = set;
		
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