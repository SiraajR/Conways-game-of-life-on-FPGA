module CellState (Clock, AdjCell, exist, reset);
 input logic Clock, reset;
 input logic [7:0] AdjCell;
 output logic exist;
 
 logic [1:0] counter;
 
 CellCount c0 (AdjCell, counter);
 
 enum {alive, dead} ps, ns;
 
 always_comb begin
  case(ps)
  alive: if (counter[1]) ns = ps;
         else ns = dead;
  dead:  if (counter == 2'b11) ns = alive;
         else ns = ps;
  endcase
 end
 
 always_ff @(posedge Clock) begin
  if (reset) begin
   ps <= dead;
  end 
 
  else
   ps <= ns;
  end

 assign exist = (ps == alive);
endmodule 




//Uses the values of the switches to locate through the 16x16 LED array 
module CellCount (AdjCell, counter);
 input logic [7:0] AdjCell;
 output logic [1:0] counter;
 
 logic [2:0] count;
 
 assign counter = ~count[2] ? count[1:0] : 2'b00;
 
 assign count = AdjCell[0] + AdjCell[1] + AdjCell[2] + AdjCell[3]
               + AdjCell[4] + AdjCell[5] + AdjCell[6] + AdjCell[7];

endmodule 



module CellState_testBench();

	logic Clock_50;
	logic [7:0] AdjCell;
	logic exist;
	
	CellState dut(.Clock(Clock_50), .AdjCell , .exist);
	
	parameter Clock_Period =100;
	initial begin
		Clock_50 <= 0;
		forever #(Clock_50/2) Clock_50 <= ~ Clock_50;
	end
	
	initial begin
		@(posedge Clock_50);
		AdjCell <= 8'b00000001;	@(posedge Clock_50);
		@(posedge Clock_50);
		AdjCell <= 8'b00000110;@(posedge Clock_50);
		@(posedge Clock_50);
		AdjCell <= 8'b00010010;@(posedge Clock_50);
		@(posedge Clock_50);
		AdjCell <= 8'b00101010;@(posedge Clock_50);
		@(posedge Clock_50);
	$stop;
	end
endmodule
