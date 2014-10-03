/*
 ECE 4740 Lab 2 - Part 3
 Author: Daniel Tweed, 6791717 
 Four bit full adder, with input from switches 
 displayed on red LED's and output displayed on 
 green LED's.
*/

//Code basically the same as that given in lab intro on D2L
//Typed it in, so some differences
module part3 (SW, LEDR, LEDG);
	input [8:0] SW;
	output [8:0] LEDR;
	output [4:0] LEDG;
	assign LEDR=SW;
	adder4 A4 (SW[8],SW[7:4],SW[3:0],LEDG[4:0]);
endmodule

module adder4 (carryin,X,Y,S);
	input carryin;
	input [3:0] X,Y;
	output reg [4:0] S;
	always @(*)
		S=X+Y+carryin;
endmodule