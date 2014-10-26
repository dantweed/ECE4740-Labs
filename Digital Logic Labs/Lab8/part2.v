/*
 ECE 4740 Lab 8 - Part 2
 Author: Daniel Tweed, 6791717 
*/
module part2 (SW, LEDG, KEY, LEDR, HEX0, HEX1, HEX4, HEX5, HEX6, HEX7);
	input [17:0] SW;
	input [0:0] KEY;
	output [7:0] LEDR;
	output [0:0] LEDG;
	output [0:6] HEX0, HEX1, HEX4, HEX5, HEX6, HEX7;
	
	wire clock, wren; 
	wire [7:0] datain, dataout;
	wire [4:0] addr;
	
	assign clock = KEY[0];
	assign LEDR = dataout;
	assign wren = SW[17];
	assign LEDG = wren;
	assign datain = SW[7:0];
	assign addr = SW[15:11];	
	
	ramlpm RAM1(addr,clock,datain,wren,dataout);
	
	seven_seg A1 (addr[4:4], HEX7);
	seven_seg A0 (addr[3:0], HEX6);
	seven_seg din1 (datain[7:4], HEX5);
	seven_seg din0 (datain[3:0], HEX4);
	seven_seg dout1 (dataout[7:4], HEX1);
	seven_seg dout0 (dataout[3:0], HEX0);
	

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
