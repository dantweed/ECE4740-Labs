module part2 (SW, LEDR, LEDG, KEY);
	input [8:0]SW;
	input [1:0] KEY; //Clock, reset
	output [7:0] LEDR;
	output [8:8] LEDG;
	
	reg [7:0] sum;
	reg carry;
	
	assign LEDR = sum;
	assign LEDG = carry;
	
	always@(posedge KEY[1] or negedge KEY[0]) begin
		if (~KEY[0]) begin
			sum <= 0;
			carry <= 0;
		end else if (SW[8])
			{carry, sum} = sum -  SW[7:0];
		else 
			{carry, sum} = sum + SW[7:0];
	end
	

endmodule

