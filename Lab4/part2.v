/*
 ECE 4740 Lab 4 - Part 2
 Author: Daniel Tweed, 6791717 
 16-bit counter based on behavioural description
*/

module part2(enable, reset, clock, Q);
	input enable, reset, clock;
	output reg [15:0] Q;
	
	
	
	always@(posedge clock) begin
		if (~reset)
			Q <= 0;
		else if (enable)
			Q <= Q+1;
	end	

endmodule
