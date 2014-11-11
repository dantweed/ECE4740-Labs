module proc (DIN, Resetn, Clock, Run, Done, BusWires);
	input [15:0] DIN;
	input Resetn, Clock, Run;
	output reg Done;
	output reg [15:0] BusWires;
	
	parameter T0 = 2'b00, T1 = 2'b01, T2 = 2'b10, T3 = 2'b11;
	
	//declare variables
	reg IRin, DINout, Ain, Gout, Gin, AddSub;
	reg [7:0] Rout, Rin;
	wire [7:0] Xreg, Yreg;
	wire [1:9] IR;
	wire [1:3] I;
	reg [9:0] MUXsel;
	wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7, result /* synthesis preserve */;
	wire [15:0] A, G /* synthesis preserve */;
	reg [1:0] Tstep_Q, Tstep_D /* synthesis preserve */;	
	
	assign I = IR[1:3];
	
	initial Tstep_Q = T0;

	dec3to8 decX (IR[4:6], 1'b1, Xreg);
	dec3to8 decY (IR[7:9], 1'b1, Yreg);
	
	// Control FSM state table	
	always @(Run, Done) begin
		case (Tstep_Q)
			T0: // data is loaded into IR in this time step
				if (!Run) Tstep_D = T0;
				else Tstep_D = T1;
			T1: if (Done) Tstep_D = T0;
				else Tstep_D = T2;
			T2: Tstep_D = T3;
			T3: Tstep_D = T0;
		endcase
	end

	// Control FSM outputs
	always @(Tstep_Q or I or Xreg or Yreg) begin
		//specify initial values
		IRin = 1'b0;
		Rout = 8'b00000000;
		Rin = 8'b00000000;
		DINout = 1'b0;
		Ain = 1'b0;
		Gout = 1'b0;
		Gin = 1'b0;
		AddSub = 1'b0;
		Done = 1'b0;
		
		case (Tstep_Q)
			T0: // store DIN in IR in time step 0
				begin
					IRin = 1'b1;
				end
			T1: //define signals in time step 1
				case (I)
					3'b000: begin
						Rout = Yreg;
						Rin = Xreg;
						Done = 1'b1;
					end
					3'b001: begin
						DINout = 1'b1;
						Rin = Xreg;
						Done = 1'b1;
					end
					3'b010: begin
						Rout = Xreg;
						Ain = 1'b1;						
					end
					3'b011: begin
						Rout = Xreg;
						Ain = 1'b1;						
					end
				endcase
			T2: //define signals in time step 2
				case (I)
					3'b010: begin
						Rout = Yreg;
						Gin = 1'b1;						
					end
					3'b011: begin
						Rout = Xreg;
						Gin = 1'b1;
						AddSub = 1'b1;						
					end
				endcase
			T3: //define signals in time step 3
				case (I)
					3'b010: begin
						Rin = Xreg;
						Gout = 1'b1;
						Done = 1'b1;						
					end
					3'b011: begin
						Rin = Xreg;
						Gout = 1'b1;
						Done = 1'b1;						
					end
				endcase
		endcase
	end

	// Control FSM flip-flops
	always @( posedge Clock, negedge Resetn)
		if (!Resetn)
			Tstep_Q <= T0;
		else
			Tstep_Q <= Tstep_D;			
	
	regn reg_0 (BusWires, Rin[0], Clock, R0);
	regn reg_1 (BusWires, Rin[1], Clock, R1);
	regn reg_2 (BusWires, Rin[2], Clock, R2);
	regn reg_3 (BusWires, Rin[3], Clock, R3);
	regn reg_4 (BusWires, Rin[4], Clock, R4);
	regn reg_5 (BusWires, Rin[5], Clock, R5);
	regn reg_6 (BusWires, Rin[6], Clock, R6);
	regn reg_7 (BusWires, Rin[7], Clock, R7);
	regn reg_IR (DIN, IRin, Clock, IR);
		defparam reg_IR.n = 9;
		
	regn reg_A (BusWires, Ain, Clock, A);
	regn reg_G (result, Gin, Clock, G);
	addsub AS (~AddSub, A, BusWires, result);
	//define the bus
	always @ (Rout or Gout or DINout)
		begin
			MUXsel[9:2] = Rout;
			MUXsel[1] = Gout;
			MUXsel[0] = DINout;
			case (MUXsel)
				10'b0000000001: BusWires <= DIN;
				10'b0000000010: BusWires <= G;
				10'b0000000100: BusWires <= R0;
				10'b0000001000: BusWires <= R1;
				10'b0000010000: BusWires <= R2;
				10'b0000100000: BusWires <= R3;
				10'b0001000000: BusWires <= R4;
				10'b0010000000: BusWires <= R5;
				10'b0100000000: BusWires <= R6;
				10'b1000000000: BusWires <= R7;
			endcase
		end	
endmodule

module dec3to8(W, En, Y);
	input [2:0] W;
	input En;
	output reg[0:7] Y;	

	always@(W or En) begin
		if (En == 1)
			case (W)
				3'b000: Y = 8'b00000001;
				3'b001: Y = 8'b00000010;
				3'b010: Y = 8'b00000100;
				3'b011: Y = 8'b00001000;
				3'b100: Y = 8'b00010000;
				3'b101: Y = 8'b00100000;
				3'b110: Y = 8'b01000000;
				3'b111: Y = 8'b10000000;
			endcase
		else
			Y = 8'b00000000;
		end
endmodule

module regn(R, Rin, Clock, Q);

	parameter n = 16;
	input [n-1:0] R;
	input Rin, Clock;
	output reg [n-1:0] Q;

	always @( posedge Clock)
		if (Rin) Q <= R;
endmodule