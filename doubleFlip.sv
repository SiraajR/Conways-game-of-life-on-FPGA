module doubleFlip (Clock, Reset, KEY, out);	
	input logic Clock, Reset, KEY;
	output logic out;
	logic out_dff;
	
	
	always_ff @(posedge Clock) begin
        if (Reset) begin
            out_dff <= 1;
        end else begin
            out_dff <= KEY;
        end
    end

    always_ff @(posedge Clock) begin
        if (Reset) begin
            out <= 1;
        end else begin
            out <= out_dff;
        end
    end
	
endmodule 
