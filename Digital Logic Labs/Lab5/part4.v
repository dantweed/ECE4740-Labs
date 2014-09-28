/*
 ECE 4740 Lab 4 - Part 4
 Author: Daniel Tweed, 6791717 
 Morse code display on LED, for letter A-H.
*/

/*
 *	Clocking based on 'solution' from Ben Bergman, Altera DE2 labs_verilog found 
 *	online at https://github.com/BenBergman/AlteraDE2Labs_Verilog/blob/master/AlteraLab5/part4.v.
 *  
 */
module part4 (CLOCK_50, KEY, SW, LEDR);
	input CLOCK_50;
	input [1:0] KEY;
	input [2:0] SW;
	output reg [0:0] LEDR;
	
	wire [25:0] halfsec;
	wire pulse;
	wire [3:0] index;
	wire reset;
	
	reg half;
	reg [11:0] out;
	
	// generate half second clock
	counter C0 (CLOCK_50, KEY[0], halfsec);
		defparam C0.n = 26;
		defparam C0.m = 25000000;
		
	counter C1 (half, KEY[0], pulse);
		defparam C1.n = 1;
		defparam C1.m = 2;

		always @ (negedge CLOCK_50) begin
			if (halfsec == 24999999)
				half = 1;
			else
				half = 0;
		end

	always @ (negedge KEY[1]) begin
		case (SW[2:0])
			0: out = 12'b010111000000; // A
			1: out = 12'b011101010100; // B
			2: out = 12'b011101011101; // C
			3: out = 12'b011101010000; // D
			4: out = 12'b010000000000; // E
			5: out = 12'b010101110100; // F
			6: out = 12'b011101110100; // G
			7: out = 12'b010101010000; // H
		endcase
	end

	assign reset = KEY[1] && KEY[0];
	counter C2 (pulse, reset, index);
		defparam C2.n = 4;
		defparam C2.m = 12;

		always begin
			case (index)
				0:LEDR[0] = out[11];
				1:LEDR[0] = out[10];
				2:LEDR[0] = out[9];
				3:LEDR[0] = out[8];
				4:LEDR[0] = out[7];
				5:LEDR[0] = out[6];
				6:LEDR[0] = out[5];
				7:LEDR[0] = out[4];
				8:LEDR[0] = out[3];
				9:LEDR[0] = out[2];
				10:LEDR[0] = out[1];
				11:LEDR[0] = out[0];
			endcase
		end
endmodule
	
//Code from part 1 
module counter(clock, reset_n, Q);
	parameter n;
	parameter m;
	
	input clock, reset_n;
	output reg [n-1:0] Q;
	
			
	always @(posedge clock or negedge reset_n) begin
		if (~reset_n)
			Q <= 0;			
		else if (Q < m)
			Q <= Q + 1'b1;			
		else
			Q <=0;
	end
endmodule	
	