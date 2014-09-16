/*
 ECE 4740 Lab 2 - Part 6
 Author: Daniel Tweed, 6791717 
 Adder for two two-digit binary coded decimal numbers
 with input and output displayed on seven segment displays.
 Implementing the algorithm in the lab write up using 
 behavioural description of the modules.
*/

module part6 (SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
	input [15:0] SW;
	output [15:0] LEDR;
	output [0:6] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	assign LEDR = SW;
	reg [3:0] T1, T0, Z1, Z0, S2, S1, S0;
	reg c2, c1;
	
	always@(*)
	begin	
		T0 = SW[11:8]+SW[3:0];
		if (T0 > 9)
			begin
				Z0 = 10;
				c1 = 1;				
			end
		else 
			begin
				Z0 = 0;
				c1 = 0;				
			end 
		
		S0 = T0 - Z0;
		
		T1 = SW[15:12] + SW[7:4] + c1;
		if (T1 > 9)
			begin
				Z1 = 10;
				c2 = 1;
			end
		else
			begin
				Z1 = 0;
				c2 = 0;
			end
		
		S1 = T1 - Z1;
		S2 = c2;
	end 
		
	decode_7seg A1D (SW[15:12],HEX7); 
	decode_7seg A0D (SW[11:8],HEX6); 
	decode_7seg B1D (SW[7:4],HEX5); 
	decode_7seg B0D (SW[3:0],HEX4);
	assign HEX3 = 7'b1111111;
	decode_7seg S2D (S2,HEX2); 
	decode_7seg	S1D (S1,HEX1); 
	decode_7seg	S0D (S0,HEX0); 
endmodule

module decode_7seg(bits, D);
	input [3:0] bits;
	output reg [0:6] D;
	
	always @(bits)
	begin
		case (bits)
			0: D = 7'b0000001; 
			1: D = 7'b1001111;
			2: D = 7'b0010010;
			3: D = 7'b0000110;
			4: D = 7'b1001100;
			5: D = 7'b0100100;
			6: D = 7'b1100000;
			7: D = 7'b0001111;
			8: D = 7'b0000000;
			9: D = 7'b0001100;
			default: D = 7'b1111111;
		endcase		
	end	
endmodule