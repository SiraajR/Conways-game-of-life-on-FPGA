module CellManager (Clock, curr, RowSelect, ColumnSelect, state, Input, out);
	input logic Clock, curr, RowSelect, ColumnSelect, state, Input;
	output logic out;
	logic next, control,internal;
 
	assign control = (RowSelect & ColumnSelect) | state;
 
	mux2_1 m0 (.out(internal), .i0(Input), .i1(curr), .sel(state));
	mux2_1 m1 (.out(next), .i0(out), .i1(internal), .sel(control));
 
	always_ff @(posedge Clock) begin
		out <= next;
	end
endmodule

//From lab 1
module mux2_1(out, i0, i1, sel);  
 output logic out;   
 input  logic i0, i1, sel;   
   
 assign out = (i1 & sel) | (i0 & ~sel);   
endmodule  
  
module mux2_1_testbench();  
 logic i0, i1, sel;   
 logic out;   
   
 mux2_1 dut (.out, .i0, .i1, .sel);   
  
 initial begin  
	  sel=0; i0=0; i1=0; #10;   
	  sel=0; i0=0; i1=1; #10;   
	  sel=0; i0=1; i1=0; #10;   
	  sel=0; i0=1; i1=1; #10;   
	  sel=1; i0=0; i1=0; #10;   
	  sel=1; i0=0; i1=1; #10;   
	  sel=1; i0=1; i1=0; #10;   
	  sel=1; i0=1; i1=1; #10;   
	 end  
endmodule


module CellManager_testbench();
 logic CLOCK_50;
 logic curr, RowSelect, ColumnSelect, state, out;

 CellManager dut (.Clock(CLOCK_50), .curr, .RowSelect, .ColumnSelect, .state, .out);

 parameter CLOCK_PERIOD = 100;
  initial begin
	 CLOCK_50 <= 0;
	 forever #(CLOCK_PERIOD / 2) CLOCK_50 <= ~CLOCK_50;
  end
  
  initial begin
   															           @(posedge CLOCK_50);
	RowSelect <= 1; ColumnSelect <= 1; curr <= 1; state <= 0; @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 0; curr <= 0;  							           @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 0;						                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 1;   							                 @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 1;		                                @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 0; curr <= 1;  							        @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 0;						                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 1; 							                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 1; curr <= 1; state <= 1; 		        @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 0; curr <= 0;  							        @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 0;						                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 1;   							                 @(posedge CLOCK_50);				
   															           @(posedge CLOCK_50);
	RowSelect <= 0; curr <= 1;  							        @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 0;						                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 1; 							                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	$stop;
	end
endmodule
