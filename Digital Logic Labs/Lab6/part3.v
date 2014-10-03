module part3 (KEY, SW, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input [1:0] KEY;  //clock, reset
	input [15:0] SW;
	output [0:6] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
		
	reg [15:0] P;

	always@ (posedge KEY[1] or negedge KEY[0]) begin
		if (~KEY[0])
			P <=0;
		else 
			P <= SW[15:8]*SW[7:0];		
	end 
	
	seven_seg A1 (SW[15:12], HEX7);
	seven_seg A0 (SW[11:8], HEX6);
	
	seven_seg B1 (SW[7:4], HEX5);
	seven_seg B0 (SW[3:0], HEX4);
	
	seven_seg P3 (P[15:12], HEX3);
	seven_seg P2 (P[11:8], HEX2);
	seven_seg P1 (P[7:4], HEX1);
	seven_seg P0 (P[3:0], HEX0);	

endmodule

module seven_seg (in, out);
	input [4:0] in;
	output reg[0:6] out;
	
	always@(in)
	begin
		case (in)
			0: out = 7'b0000001; 
			1: out = 7'b1001111;
			2: out = 7'b0010010;
			3: out = 7'b0000110;
			4: out = 7'b1001100;
			5: out = 7'b0100100;
			6: out = 7'b1100000;
			7: out = 7'b0001111;
			8: out = 7'b0000000;
			9: out = 7'b0001100;
			10:out = 7'b0001000;
			11:out = 7'b1100000;
			12:out = 7'b0110001;
			13:out = 7'b1000010;
			14:out = 7'b0110000;
			15:out = 7'b0111000;
			default: out = 7'b1111111;
		endcase
	end
endmodule
