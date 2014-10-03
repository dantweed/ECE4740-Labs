/*
 ECE 4740 Lab 1 - Part 4
 Author: Daniel Tweed, 6791717 
 Rotate the work 'HELLO' around 8 seven segment with 
 rotation selected by user input
*/
//
module part6 (SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
	input [17:0] SW;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	
	wire [2:0] M0, M1, M2, M3, M4, M5, M6, M7;
	wire [2:0] sw2, sw1, sw0;
	
	//Blanks
	assign sw2 =3'b111;
	assign sw1 =3'b111;
	assign sw0 =3'b111;
	
	/* This next block credited to Thong Le, Available: http://letrthong.blogspot.ca/2012/03/verilog-de2.html
	 * Understood how to solve this, but searched for better ways, couldn't find any others and
	 * didn't want to type it out at that point. 
	 */
	mux_3bit_8to1  m7(SW[17:15],sw2  ,sw1  , sw0 , SW[14:12], SW[11:9],  SW[8:6],   SW[5:3],   SW[2:0], M7);
	mux_3bit_8to1  m6(SW[17:15],sw1  , sw0 , SW[14:12], SW[11:9],  SW[8:6],   SW[5:3],   SW[2:0], sw2  ,M6);
	mux_3bit_8to1  m5(SW[17:15],sw0  , SW[14:12], SW[11:9],  SW[8:6],   SW[5:3],   SW[2:0], sw2 ,sw1  , M5);
	mux_3bit_8to1  m4(SW[17:15],SW[14:12], SW[11:9],  SW[8:6],   SW[5:3],   SW[2:0], sw2 ,sw1  ,sw0, M4);
	mux_3bit_8to1  m3(SW[17:15],SW[11:9],  SW[8:6],   SW[5:3],   SW[2:0], sw2 ,sw1  ,sw0,SW[14:12], M3);
	mux_3bit_8to1  m2(SW[17:15],SW[8:6],   SW[5:3],   SW[2:0], sw2 ,sw1  ,sw0,SW[14:12],SW[11:9], M2);
	mux_3bit_8to1  m1(SW[17:15], SW[5:3],   SW[2:0], sw2 ,sw1  ,sw0,SW[14:12],SW[11:9],SW[8:6],   M1);
	mux_3bit_8to1  m0(SW[17:15],SW[2:0], sw2 ,sw1  ,sw0,SW[14:12],SW[11:9],SW[8:6], SW[5:3],  M0);
	
	//Decode character, or blank, to 7-segnment display
	char_7seg(M0, HEX0);	
	char_7seg(M1, HEX1);	
	char_7seg(M2, HEX2);	
	char_7seg(M3, HEX3);	
	char_7seg(M4, HEX4);	
	char_7seg(M5, HEX5);	
	char_7seg(M6, HEX6);	
	char_7seg(M7, HEX7);
endmodule


//----------------------------------------------------------
// implements a 3-bit wide 8-to-1 mux
// Code credited to Thong Le, Availalble: http://letrthong.blogspot.ca/2012/03/verilog-de2.html

module mux_3bit_8to1(S, U, V, W, X, Y, J,K,L,M);
input [2:0] S, U, V, W, X, Y,J,K,L;
output [2:0] M;
assign M = (S == 3'b000 )? U:
           (S == 3'b001 )? V:
           (S == 3'b010 )? W:
           (S == 3'b011 )? X:
           (S == 3'b100 )? Y:
           (S == 3'b101 )? J:
           (S == 3'b110 )? K:L ; 
endmodule

//Re-used decoder from part 4
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