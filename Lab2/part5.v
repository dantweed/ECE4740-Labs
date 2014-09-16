/*
 ECE 4740 Lab 2 - Part 5
 Author: Daniel Tweed, 6791717 
 Adder for two two-digit binary coded decimal numbers
 with input and output displayed on seven segment displays
*/

module part5(SW, LEDR, HEX0, HEX1, HEX2, HEX4, HEX5, HEX6, HEX7);
	input [15:0] SW;
	output [0:6] HEX0, HEX1, HEX2, HEX4, HEX5, HEX6, HEX7;
	output [15:0] LEDR;
		
	wire [3:0] sum1, sum2;
	reg [3:0] A1, A0, B1, B0;
	reg carry;
	reg [7:0] sum;
	wire [11:0] sum_BCD;	
	
	assign LEDR = SW;

	decode_7seg A1_7Seg (SW[15:12], HEX7);
	decode_7seg A0_7Seg (SW[11:8], HEX6);
	decode_7seg B1_7Seg (SW[7:4], HEX5);
	decode_7seg B0_7Seg (SW[3:0], HEX4);
	
	adder4 (0, SW[11:8], SW[3:0], sum1);	
	adder4 (0, SW[15:12], SW[7:4], sum2);
	
	always
		begin
			sum = sum2*10+sum1;
		end
		
		
	toBCD_3digits S_BCD (sum, sum_BCD);
	
	decode_7seg Sd2_7Seg (sum_BCD[11:8], HEX2);
	decode_7seg Sd1_7Seg (sum_BCD[7:4], HEX1);
	decode_7seg Sd0_7Seg (sum_BCD[3:0], HEX0);	
endmodule

module adder4 (carryin,X,Y,S);
	input carryin;
	input [3:0] X,Y;
	output reg [4:0] S;
	always @(*)
		S=X+Y+carryin;
endmodule

module decode_7seg(bits, D);
	input [4:0] bits;
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

module toBCD_3digits(bits, out);
	input [7:0] bits;
	output reg [11:0] out;
	
	reg [7:0] temp;
	
	always@(*)
	begin
		temp = bits;
		out[3:0]	= temp % 10;
		temp = temp / 10;
		out[7:4] = temp % 10;
		temp = temp / 10;
		out[11:8] = temp %10;
	end
endmodule
