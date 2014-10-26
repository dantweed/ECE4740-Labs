/*
 ECE 4740 Lab 8 - Part 4
 Author: Daniel Tweed, 6791717 
	Solution inspired (heavily) by Ben Bergman's solutions located at
		https://github.com/BenBergman/AlteraDE2Labs_Verilog/blob/master/AlteraLab8/part4.v
*/
module part4 (SRAM_ADDR, SRAM_DQ, SRAM_CE_N, SRAM_OE_N, SRAM_WE_N, SRAM_UB_N, SRAM_LB_N, 
						SW, LEDG, KEY, LEDR, HEX0, HEX1, HEX4, HEX5, HEX6, HEX7);
	input [17:0] SW;
	input [3:0] KEY;
	output [7:0] LEDR;
	output [0:0] LEDG;
	output [0:6] HEX0, HEX1, HEX4, HEX5, HEX6, HEX7;
	
	output [17:0] SRAM_ADDR;
	inout [15:0] SRAM_DQ;
	
	output SRAM_CE_N;
	output SRAM_OE_N;
	output SRAM_WE_N;
	output SRAM_UB_N;
	output SRAM_LB_N;
	
	assign SRAM_ADDR[17:5] = 13'b0000000000000;
	assign SRAM_DQ[15:8] = 8'b00000000;
	assign SRAM_CE_N = 0;
	assign SRAM_OE_N = 0;
	assign SRAM_UB_N = 0;
	assign SRAM_LB_N = 0;
	assign SRAM_WE_N = wren;		
	assign SRAM_ADDR = addr;	
	
	wire clock, wren; 
	wire [7:0] datain;
	reg [7:0] dataout;
	reg [7:0] dataIO;
	wire [4:0] addr;
	
	assign clock = KEY[0];
	assign LEDR = dataout;
	assign wren = SW[17];
	assign LEDG = ~wren;
	assign datain = SW[7:0];
	assign addr = SW[15:11];
	assign SRAM_DQ[7:0] = dataIO;
	
	always@(posedge clock) begin
		 if (~wren)
			dataIO = datain;
		 else 
			dataout = dataIO;		 
	end
	
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
