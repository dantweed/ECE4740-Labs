/*
 ECE 4740 Lab 1 - Part 4
 Author: Daniel Tweed, 6791717 
 Diplay characters 'H', 'E', 'L' and 'O' on seven segment 
 display, selected by user input on switches
*/

module part4 (SW, HEX0);
	input [2:0] SW;
	output [0:6] HEX0;
	
	char_7seg(SW, HEX0);
endmodule

//Seven segment display decoder
module char_7seg(c, out);
	input [2:0] c;
	output [0:6]out;
	
	//Derived from truth table in lab description
	assign out[0] = !( c[0] & !c[2] );
	assign out[1] = !( !c[2] & ( (!c[1] & !c[0]) | (c[1] & c[0]) ) );
	assign out[2] = !( !c[2] & ( (!c[1] & !c[0]) | (c[1] & c[0]) ) );
	assign out[3] = !( !c[2] & (c[1] | c[0]) );
	assign out[4] = !( !c[2] );
	assign out[5] = !( !c[2] );
	assign out[6] = !( !c[2] & !c[1] );
endmodule