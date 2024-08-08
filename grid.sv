module grid (Clock, Reset, redPixel, SW, out);
 input logic Clock, Reset;
 input logic  [15:0][15:0] redPixel;
 input logic [9:0] SW;
 output logic [15:0] [15:0] out;
 
 logic [15:0] RowSelect, ColumnSelect;
 logic control;
 
 decoder4_16 row (.switch(SW[3:0]), .enable(1'b1), .out(RowSelect));
 decoder4_16 column (.switch(SW[7:4]), .enable(1'b1), .out(ColumnSelect));
 
 genvar i, j;
 generate
  for (i = 0; i < 16; i++) begin : rowGeneration
   for (j = 0; j < 16; j++) begin : columnGeneration
    CellManager dot (.Clock(Clock), .curr(redPixel[i][j]), .RowSelect(RowSelect[i]), .ColumnSelect(ColumnSelect[j]), .state(SW[9]), .out(out[i][j]), .Input(SW[8]));
   end
  end
 endgenerate
endmodule

module decoder4_16 (switch, enable, out);
 input logic [3:0] switch;
 input logic enable;
 output logic [15:0] out;
 
 assign out = {16{enable}} & (1'b1 << switch);
endmodule



module grid_testbench();
 logic CLOCK_50;
 logic Reset;
 logic [15:0][15:0] redPixel;
 logic [9:0] SW;
 logic [15:0] [15:0] out;

 grid dut (.Clock(CLOCK_50), .Reset, .redPixel, .SW, .out);

 parameter CLOCK_PERIOD = 100;
  initial begin
	 CLOCK_50 <= 0;
	 forever #(CLOCK_PERIOD / 2) CLOCK_50 <= ~CLOCK_50;
  end
  
  initial begin
   SW <= 10'b1001001100; 		                  @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0101001101;		            		@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0101001001; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0110010010; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b0100000000; 							   @(posedge CLOCK_50);
															   @(posedge CLOCK_50);
	SW <= 10'b1100010101; 		                  @(posedge CLOCK_50);
       														@(posedge CLOCK_50);
	SW <= 10'b1100101010; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b1011110010; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	SW <= 10'b1000101101; 							   @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	$stop;
	end
endmodule 
