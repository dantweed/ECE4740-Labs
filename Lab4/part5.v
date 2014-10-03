/*
 ECE 4740 Lab 4 - Part 4
 Author: Daniel Tweed, 6791717 
 Ticker tape display of the word 'HELLO'
*/

module part5 (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
	input CLOCK_50;
	output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	
	wire trigger;
	wire [3:0] count;

	reg clear;
	
	wire [2:0] M0, M1, M2, M3, M4, M5, M6, M7;
	wire [2:0] sw7, sw6, sw5, sw4, sw3, sw2, sw1, sw0;
	
	assign sw7 = 3'b000;
	assign sw6 = 3'b001;
	assign sw5 = 3'b010;
	assign sw4 = 3'b010;
	assign sw3 = 3'b011;
	assign sw2 = 3'b111;
	assign sw1 = 3'b111;
	assign sw0 = 3'b111;
		
	oneSecDelay delay(CLOCK_50, trigger);	
	counter4bit C (clear, trigger, 1, count);		
	
	always@(negedge trigger) begin 
		if (count >= 7)
			clear <= 0;
		else 
			clear <= 1;
	end	
	
	//Modified from lab 1 part 6
	mux_3bit_8to1  m7(count, sw2, sw1, sw0, sw7, sw6, sw5, sw4, sw3, M7);
	mux_3bit_8to1  m6(count, sw1, sw0, sw7, sw6, sw5, sw4, sw3, sw2, M6);
	mux_3bit_8to1  m5(count, sw0, sw7, sw6, sw5, sw4, sw3, sw2, sw1, M5);
	mux_3bit_8to1  m4(count, sw7, sw6, sw5, sw4, sw3, sw2, sw1, sw0, M4);
	mux_3bit_8to1  m3(count, sw6, sw5, sw4, sw3, sw2, sw1, sw0, sw7, M3);
	mux_3bit_8to1  m2(count, sw5, sw4, sw3, sw2, sw1, sw0, sw7, sw6, M2);
	mux_3bit_8to1  m1(count, sw4, sw3, sw2, sw1, sw0, sw7, sw6, sw5, M1);
	mux_3bit_8to1  m0(count, sw3, sw2, sw1, sw0, sw7, sw6, sw5, sw4, M0);

	char_7seg(M0, HEX0);	
	char_7seg(M1, HEX1);	
	char_7seg(M2, HEX2);	
	char_7seg(M3, HEX3);	
	char_7seg(M4, HEX4);	
	char_7seg(M5, HEX5);	
	char_7seg(M6, HEX6);	
	char_7seg(M7, HEX7);
	
	
endmodule

//Approx equivalent to a 60 Hz clock
//Re-used from part 4
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

//Re-used code from part 1
module counter4bit(clear, clock, enable, Q);
	input clear, clock, enable;	
	output [3:0] Q;
	
	wire [3:0] e;
	
	assign e[0] = enable;	
	Tflipflop t0 (clear, clock, e[0], Q[0]);
	assign e[1] = e[0] & Q[0];
	Tflipflop t1 (clear, clock, e[1], Q[1]);
	assign e[2] = e[1] & Q[1];
	Tflipflop t2 (clear, clock, e[2], Q[2]);
	assign e[3] = e[2] & Q[2];
	Tflipflop t3 (clear, clock, e[3], Q[3]);	
	
endmodule

module Tflipflop(clear, clock, T, Q);
	input clear, clock, T;
	output reg Q;	
	
	always@(posedge clock)
		if (~clear)
			Q = 0;			
		else if (T) 
			Q = ~Q;					
endmodule


//Everything below here re-used from Lab1 part 6
//----------------------------------------------------------
// implements a 3-bit wide 8-to-1 mux
// Code courtesty of Thong Le, http://letrthong.blogspot.ca/2012/03/verilog-de2.html

module mux_3bit_8to1(S, U, V, W, X, Y, J,K,L,M);
input [2:0] S, U, V, W, X, Y,J,K,L;
output [2:0] M;
assign M = (S== 3'b000 )? U:
           (S == 3'b001 )? V:
           (S == 3'b010 )? W:
           (S == 3'b011 )? X:
           (S == 3'b100 )? Y:
           (S == 3'b101 )? J:
           (S == 3'b110 )? K:L ; 
endmodule
	
	
// Implements a 3-bit wide 5-to-1 multiplexer
// Code from Altera UP Labs design files for lab 1 part 5
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


// Implemensts logic to display H, E, L or O depending on values of c
module char_7seg(c, out);
	input [2:0] c;
	output [0:6]out;
	
	assign out[0] = !( c[0] & !c[2] );
	assign out[1] = !( !c[2] & ( (!c[1] & !c[0]) | (c[1] & c[0]) ) );
	assign out[2] = !( !c[2] & ( (!c[1] & !c[0]) | (c[1] & c[0]) ) );
	assign out[3] = !( !c[2] & (c[1] | c[0]) );
	assign out[4] = !( !c[2] );
	assign out[5] = !( !c[2] );
	assign out[6] = !( !c[2] & !c[1] );
endmodule
