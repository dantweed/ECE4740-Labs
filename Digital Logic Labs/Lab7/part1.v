module part1 (LEDR, LEDG, SW, KEY);
	input [1:0] SW;
	input [0:0]KEY;
	output [8:0] LEDR;
	output [0:0] LEDG;
	
	reg [8:0] y;		
	
	initial y = 9'b000000001;	
	
	assign LEDG[0] = (y[8] || y[4]);
	assign LEDR = y;
	
	always@(posedge KEY[0] or negedge SW[0]) begin
		if (~SW[0]) begin
			y = 9'b000000001;					
		end else begin
			case (y) 
				9'b000000001: begin  //A
						if (SW[1]) 
							y = 9'b000100000;
						else
							y = 9'b000000010;
					end
				9'b000000010: begin //B 						
						if (SW[1]) 
							y = 9'b000100000;
						else
							y = 9'b000000100;
					end
				9'b000000100: begin //C				
						if (SW[1]) 
							y = 9'b000100000;
						else
							y = 9'b000001000;
					end
				9'b000001000: begin 	//D				
						if (SW[1]) 
							y = 9'b000100000;
						else
							y = 9'b000010000;
					end
				9'b000010000: begin 	//E
						if (SW[1]) 
							y = 9'b000100000;						
					end
				9'b000100000: begin //F 						
						if (SW[1]) 
							y = 9'b001000000;
						else
							y = 9'b000000010;
					end
				9'b001000000: begin //G				
						if (SW[1]) 
							y = 9'b010000000;
						else
							y = 9'b000000010;
					end
				9'b010000000: begin 	//H
						if (SW[1]) 
							y = 9'b100000000;
						else
							y = 9'b000000010;
					end
				9'b100000000: begin 	//I
						if (~SW[1]) 
							y = 9'b000000010;						
					end	
				default: y = 9'b000000001;
			endcase
		end
		
	end
	
endmodule

