/*
 ECE 4740 Lab 2 - Part 4
 Author: Daniel Tweed, 6791717 
 Adder for two one-digit binary coded decimal numbers
 with input and output displayed on seven segment displays
*/

module part4(SW, LEDR, LEDG, HEX0, HEX1, HEX4, HEX6);
	input [8:0] SW;
	output [0:6] HEX0, HEX1, HEX4, HEX6;
	output [8:0] LEDR;
	output [8:0]LEDG;
	
	wire [4:0] sum;
	wire [3:0] A,B;
	wire [7:0] sum_BCD;	
	
	assign LEDR = SW;
	check_inputs (SW[7:4], SW[3:0], LEDG[8]);
	toBCD_5bits A_BCD (SW[7:4], A);
	toBCD_5bits B_BCD(SW[3:0], B);
	decode_7seg A_7Seg (A[3:0], HEX6);
	decode_7seg B_7Seg (B[3:0], HEX4);
	
	adder4(SW[8],SW[7:4],SW[3:0], sum);
	toBCD_5bits S_BCD (sum, sum_BCD);
	
	assign LEDG[7:0] = sum_BCD;
	
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

module check_inputs(A, B, error);
	input [3:0] A, B;
	output error;
	
	assign error = ( A > 9) | (B > 9);
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

module toBCD_5bits(bits, out);
	input [4:0] bits;
	output reg [7:0] out;
	
	reg [4:0] temp;
	
	always@(*)
	begin
		temp = bits;
		if (temp > 9)
			begin
				out[7:4] = 4'b0001;
				temp = temp - 10;
			end
		else
			out[7:4] = 4'b0000;
		out[3:0] = temp;		
	end
endmodule
