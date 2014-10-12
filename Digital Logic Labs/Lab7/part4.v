module part4(CLOCK_50, SW, KEY, LEDR);
	input CLOCK_50;
	input [2:0] SW;
	input [1:0] KEY;
	output [0:0] LEDR;
	
	wire halfsec;
	
	reg out = 0;
	integer count = 0;
	reg [11:0] letter = 0;
	reg [11:0] length = 0;
	
	
	parameter A = 6'b010111, B = 10'b0111010101, C= 12'b011101011101, D = 8'b01110101, E = 2'b01, F = 10'b0101011101, Ga = 10'b0111011101, H = 8'b01010101;
	parameter lenA = 6, lenB = 10, lenC = 12, lenD = 8, lenE = 2, lenF = 10, lenG = 10, lenH = 9;	
	
	halfSecond cntr (CLOCK_50, KEY[0], halfsec);
	
	
	always@(negedge KEY[1] or posedge halfsec or negedge KEY[0]) begin
		if (~KEY[1]) begin 
			case (SW)
			0: begin 
					letter = A;
					length = lenA;
				end				
			1: begin 
					letter = B;
					length = lenB;
				end
			2: begin
					letter = C;
					length = lenC;
				end
			3: begin 
					letter = D;
					length = lenD;
				end
			4: begin 
					letter = E;
					length = lenE;
				end
			5: begin	
					letter = F;
					length = lenF;
				end
			6: begin 
					letter = Ga;
					length = lenG;
				end
			7: begin 
					letter = H;
					length = lenH;
				end
			default: begin 
							letter = 0;			
							length = 0;
						end
		endcase
		end else if (~KEY[0]) begin 
			letter = 0;
			length = 0;
			count = 0;	
		end else begin 
			if (count == length)
				count = 0;
			out <= letter[count];
			count <= count + 1;	
		end
	end
	
		assign LEDR = out;
		
endmodule

module halfSecond(Clk, reset, out);
	input Clk, reset;
	output reg out;
	
	reg [31:0] count = 0;
	
	always@(posedge Clk or negedge reset) begin
		if (~reset) begin 
			 count = 0;
			 out = 0;
		end else begin
			count = count + 1;
			if (count > 24999999) begin
				count = 0;
				out = 1;
			end
		end
			
	end
	
	
	

endmodule
