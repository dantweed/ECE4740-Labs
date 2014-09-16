/*
 ECE 4740 Lab 2 - Part 1
 Author: Daniel Tweed, 6791717 
 Displays input binary number as decimal
 on seven segment displays
*/

module part1 (SW, LEDR, HEX0, HEX1, HEX2, HEX3);
	input [15:0] SW;
	output [0:6] HEX0, HEX1, HEX2, HEX3;
	output [15:0] LEDR;
		
	digit_7seg SS0(SW[3:0], HEX0);
	digit_7seg SS1(SW[7:4], HEX1);
	digit_7seg SS2(SW[11:8], HEX2);
	digit_7seg SS3(SW[15:12], HEX3);
	
	assign LEDR = SW;  //Just to see input
endmodule

module digit_7seg(bits, out);
	input [3:0] bits;
	output reg [0:6] out;
	
	always @(*)
	case (bits)
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
endmodule 