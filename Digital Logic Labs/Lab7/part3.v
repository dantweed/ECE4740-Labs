
//Could have done this with one register and just kept track 
//of if we were counting 1's or zeroes, and reset if it switches.
module part3(LEDG, SW, KEY);
	input [1:0] SW;
	input [0:0] KEY;
	output [0:0] LEDG;	
	
	reg [3:0] ones, zeroes; 
		
	initial ones = 0;
	initial zeroes = 0;	

	
	always@(posedge KEY[0] or negedge SW[0]) begin
		if (~SW[0]) begin
			ones <= 4'b0;
			zeroes <= 4'b0;
		end else begin
			if (SW[1]) begin
				zeroes <= 4'b0;							
				ones <= ones << 1;		
				ones[0] <= 1'b1;	
			end else begin
				ones <= 4'b0;				
				zeroes <= zeroes << 1;			
				zeroes[0] <= 1'b1;
			end		
		end
	end
	
	assign LEDG = (zeroes[3] || ones[3]);

endmodule
