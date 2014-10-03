/*
 ECE 4740 Lab 1 - Part 4
 Author: Daniel Tweed, 6791717 
 Rotate the word 'HELLO' on 7-seg displays with 
 rotation selected by user input
*/

module part5 (SW, HEX0, HEX1, HEX2, HEX3, HEX4);
	input [17:0] SW;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4;
	
	wire [2:0] M0, M1, M2, M3, M4;
	
	//Using separate MUX for each letter, instead of re-writing the MUX for 
	//multiple outputs
	mux_3bit_5to1 (SW[17:15], SW[2:0],SW[14:12],SW[11:9],SW[8:6],SW[5:3], M0);
	mux_3bit_5to1 (SW[17:15], SW[5:3],SW[2:0],SW[14:12],SW[11:9],SW[8:6], M1);
    mux_3bit_5to1 (SW[17:15], SW[8:6],SW[5:3],SW[2:0],SW[14:12],SW[11:9], M2);	
	mux_3bit_5to1 (SW[17:15], SW[11:9],SW[8:6],SW[5:3],SW[2:0],SW[14:12], M3);
	mux_3bit_5to1 (SW[17:15], SW[14:12],SW[11:9],SW[8:6],SW[5:3],SW[2:0], M4);
	
	//Decode the selected letter for 7-segment display
	char_7seg(M0, HEX0);	
	char_7seg(M1, HEX1);	
	char_7seg(M2, HEX2);	
	char_7seg(M3, HEX3);	
	char_7seg(M4, HEX4);	

endmodule

// Implements a 3-bit wide 5-to-1 multiplexer
// Code from Altera UP Labs design files available for download filename: part5.v
module mux_3bit_5to1 (S, U, V, W, X, Y, M);
	input [2:0] S, U, V, W, X, Y;
	output [2:0] M;
	wire [1:3] m_0, m_1, m_2;	// intermediate multiplexers

	// 5-to-1 multiplexer for bit 0
	assign m_0[1] = (!S[0] & U[0]) | (S[0] & V[0]);
	assign m_0[2] = (!S[0] & W[0]) | (S[0] & X[0]);
	assign m_0[3] = (!S[1] & m_0[1]) | (S[1] & m_0[2]);
	assign M[0] = (!S[2] & m_0[3]) | (S[2] & Y[0]); // 5-to-1 multiplexer output

	// 5-to-1 multiplexer for bit 1
	assign m_1[1] = (!S[0] & U[1]) | (S[0] & V[1]);
	assign m_1[2] = (!S[0] & W[1]) | (S[0] & X[1]);
	assign m_1[3] = (!S[1] & m_1[1]) | (S[1] & m_1[2]);
	assign M[1] = (!S[2] & m_1[3]) | (S[2] & Y[1]); // 5-to-1 multiplexer output
	
	// 5-to-1 multiplexer for bit 2
	assign m_2[1] = (!S[0] & U[2]) | (S[0] & V[2]);
	assign m_2[2] = (!S[0] & W[2]) | (S[0] & X[2]);
	assign m_2[3] = (!S[1] & m_2[1]) | (S[1] & m_2[2]);
	assign M[2] = (!S[2] & m_2[3]) | (S[2] & Y[2]); // 5-to-1 multiplexer output
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