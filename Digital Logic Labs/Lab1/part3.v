/*
 ECE 4740 Lab 1 - Part 3
 Author: Daniel Tweed, 6791717 
 3 bit wide 5-to-1 MUX
*/

module part3 (SW, LEDR, LEDG);
	input [17:0]SW;
	output [17:0]LEDR;
	output [2:0]LEDG;	
	
	// Display input values of x0,y0 ... x7, y7 on red LED's
	assign LEDR = SW;

	mux_3bit_5to1 (SW[17:15], SW[14:12],SW[11:9],SW[8:6],SW[5:3],SW[2:0], LEDG);	
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