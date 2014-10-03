/*
 ECE 4740 Lab 2 - Part 5
 Author: Daniel Tweed, 6791717 
 Converts a six bit binary number to two decimal digits
 displayed on seven segment displays as well as on LED's 
 in binary coded decimal.
*/

module part7(SW, LEDR, LEDG, HEX1, HEX0);
	input [5:0] SW;
	output [0:6] HEX1, HEX0;
	output [5:0] LEDR;
	output [7:0] LEDG;
	
	reg [7:0] bcd;
	reg [5:0] temp;
	
	assign LEDR = SW;
	
	always 
		begin
			temp = SW;
			bcd[3:0] = temp %10;
			temp = temp/10;
			bcd[7:4] = temp;		
		end
	
	assign LEDG = bcd;
		
	decode_7seg(bcd[7:4], HEX1);
	decode_7seg(bcd[3:0], HEX0);
		
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
