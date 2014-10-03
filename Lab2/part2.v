/*
 ECE 4740 Lab 2 - Part 2
 Author: Daniel Tweed, 6791717 
 Convert four bit binary number input on switches
 to two decimal digits, displayed on seven segment
 displays.
*/

module part2 (SW, HEX0, HEX1);
	input [3:0] SW;
	output [0:6] HEX0, HEX1;
	
	digitize(SW, HEX1, HEX0);
	
endmodule

module digitize (bits, D1, D0);
	input [3:0] bits;
	output reg [0:6] D1, D0;
	reg [3:0] temp;
	

	always @(*)
	begin
		temp = bits;
		case (temp)
			0,1,2,3,4,5,6,7,8,9: D1 = 7'b0000001;
			10,11,12,13,14,15: begin 
									D1 = 7'b1001111;
									temp = temp - 10;
								end 
		endcase
		case (temp)
			0: D0 = 7'b0000001; 
			1: D0 = 7'b1001111;
			2: D0 = 7'b0010010;
			3: D0 = 7'b0000110;
			4: D0 = 7'b1001100;
			5: D0 = 7'b0100100;
			6: D0 = 7'b1100000;
			7: D0 = 7'b0001111;
			8: D0 = 7'b0000000;
			9: D0 = 7'b0001100;
			default: D0 = 7'b1111111;
		endcase
	end
endmodule
