module part1_4 (SW, KEY, LEDR);
	input [1:0] KEY;
	input [17:0] SW;
	output [17:0] LEDR;
	
	proc P1(SW[15:0], KEY[0], KEY[1], SW[17], LEDR[17], LEDR[15:0]);
	
endmodule
