/*
 ECE 4740 Lab 1 - Part 1
 Author: Daniel Tweed, 6791717 
 Simple module that connects the SW switches to the LEDR lights
 Code from Altera UP Lab instructions
*/

module part1 (SW, LEDR);
	input [17:0] SW; // toggle switches
	output [17:0] LEDR; // red LEDs
	assign LEDR = SW;
endmodule