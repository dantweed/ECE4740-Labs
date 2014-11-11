module part2 (SW, KEY, LEDR);
	input [2:0] KEY;
	input [17:0] SW;
	output [17:0] LEDR;
	
	wire [15:0] data;
	wire [4:0] addr;
	
	upcounter addCounter1 (KEY[0], KEY[1], addr);
	lpm_rom1port mem1 (addr, KEY[1], data);
	
	proc P1(data, KEY[0], KEY[2], SW[17], LEDR[17], LEDR[15:0]);
	
endmodule

module upcounter(resetn, clock, Q);
	
	parameter n = 5;
	input clock;
	input resetn;
	output reg [n-1:0] Q;
	
	initial Q = 0;
	
	always @( posedge clock or negedge resetn)
		if (!resetn)
			Q <= 0;
		else
			Q <= Q + 1;
	
endmodule 
