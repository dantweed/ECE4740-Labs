/*
 ECE 4740 Lab 8 - Part 5
 Author: Daniel Tweed, 6791717 
*/
module part5(HEX3, HEX2, HEX1, HEX0, SW, LEDG, KEY, CLOCK_50);

	input CLOCK_50;
	input [17:0] SW;
	input [0:0] KEY;
	output [8:8] LEDG;
	output [0:6] HEX0, HEX1, HEX2, HEX3;
	
	wire secClk, wren;	
	wire [7:0] dataout, datain;	
	wire [4:0] waddr;	
	reg [4:0] raddr;
		
	initial raddr = 5'b0;
	assign wren = SW[17];
	assign waddr = SW[15:11];
	assign datain = SW[7:0];
	assign LEDG = wren;
	
	ram2p ram (CLOCK_50, datain, raddr, waddr, wren, dataout);
	
	oneSecDelay onesec (CLOCK_50, secClk);
	
	seven_seg d1 (dataout[7:4], HEX1);
	seven_seg d0 (dataout[3:0], HEX0);
	seven_seg a1 (raddr[4:4], HEX3);
	seven_seg a0 (raddr[3:0], HEX2);
	
	always@(posedge secClk or negedge KEY[0])  
		if (~KEY[0])
			raddr <= 0;
		else
			raddr <= raddr + 1;	

endmodule

//Approx equivalent to a 60 Hz clock
//Re-used code from lab 5
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