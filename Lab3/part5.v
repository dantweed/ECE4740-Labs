/*
 ECE 4740 Lab 3 - Part 5
 Author: Daniel Tweed, 6791717 
 A gated D latch
 Implementing two bytes of memory to store and display
 a user input number and the previously input number
 concurrently.
*/

module part5(SW, KEY, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input [15:0] SW; //User input
	input [1:0] KEY; //Manual clock and asynchronous reset
	output [0:6]HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0; //Display HEX value of user input

	wire [15:0] Q;
	
	D_FF I15(SW[15], ~KEY[1], ~KEY[0], Q[15]);
	D_FF I14(SW[14], ~KEY[1], ~KEY[0], Q[14]);
	D_FF I13(SW[13], ~KEY[1], ~KEY[0], Q[13]);
	D_FF I12(SW[12], ~KEY[1], ~KEY[0], Q[12]);
	D_FF I11(SW[11], ~KEY[1], ~KEY[0], Q[11]);
	D_FF I10(SW[10], ~KEY[1], ~KEY[0], Q[10]);
	D_FF I9(SW[9], ~KEY[1], ~KEY[0], Q[9]);
	D_FF I8(SW[8], ~KEY[1], ~KEY[0], Q[8]);
	D_FF I7(SW[7], ~KEY[1], ~KEY[0], Q[7]);
	D_FF I6(SW[6], ~KEY[1], ~KEY[0], Q[6]);
	D_FF I5(SW[5], ~KEY[1], ~KEY[0], Q[5]);
	D_FF I4(SW[4], ~KEY[1], ~KEY[0], Q[4]);
	D_FF I3(SW[3], ~KEY[1], ~KEY[0], Q[3]);
	D_FF I2(SW[2], ~KEY[1], ~KEY[0], Q[2]);
	D_FF I1(SW[1], ~KEY[1], ~KEY[0], Q[1]);
	D_FF I0(SW[0], ~KEY[1], ~KEY[0], Q[0]);
	
	seven_seg A3 (Q[15:12], HEX7);
	seven_seg A2 (Q[11:8], HEX6);
	seven_seg A1 (Q[7:4], HEX5);
	seven_seg A0 (Q[3:0], HEX4);
	seven_seg B3 (SW[15:12], HEX3);
	seven_seg B2 (SW[11:8], HEX2);
	seven_seg B1 (SW[7:4], HEX1);
	seven_seg B0 (SW[3:0], HEX0);

endmodule

module D_latch(D, Clk, reset, Q);
	input D, reset, Clk;
	output reg Q;
	
	always@(D,reset, Clk)
	begin
		if (Clk)
			Q=D;
		if (reset)
			Q=0;
	end
endmodule

module D_FF(D, Clk, reset, Q);
	input D, reset, Clk;
	output  Q;
	
	wire Qm;
	
	D_latch(D, Clk, reset, Qm);
	D_latch(Qm, ~Clk, reset, Q);
endmodule

//Seven segment decoder (HEX) 
module seven_seg (in, out);
	input [4:0] in;
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
