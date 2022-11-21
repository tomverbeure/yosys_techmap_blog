
`define MAX(a,b) (a >  b ? a : b)

`ifndef Y_MIN_WIDTH
`define Y_MIN_WIDTH   1
`endif

`ifndef REDUCE_SIGNED
`define REDUCE_SIGNED 0
`endif

(* techmap_celltype = "$add" *)
module add_reduce (A, B, Y);
    parameter A_SIGNED = 0;
    parameter B_SIGNED = 0;
    parameter A_WIDTH = 1;
    parameter B_WIDTH = 1;
    parameter Y_WIDTH = 1;

    (* force_downto *)
    input [A_WIDTH-1:0] A;
    (* force_downto *)
    input [B_WIDTH-1:0] B;
    (* force_downto *)
    output [Y_WIDTH-1:0] Y;

    localparam SIGNED_ADDER = (A_SIGNED == 1 && B_SIGNED == 1);

    generate 
        if (Y_WIDTH <= `Y_MIN_WIDTH) begin
            // Can't make Y smaller than a predefined size.
            wire _TECHMAP_FAIL_ = 1;    
        end
        else if (Y_WIDTH <= A_WIDTH+1) begin
            // Output is already at minimal size.
            wire _TECHMAP_FAIL_ = 1;    
        end
        else if (SIGNED_ADDER && !`REDUCE_SIGNED) begin
            // Don't reduce a signed adder unless explicitly enabled.
            wire _TECHMAP_FAIL_ = 1;    
        end
        else if (B_WIDTH > A_WIDTH) begin
            // Normalizate to guarantee that the A input will always be 
	    // larger than the B input for the main transformation.
            \$add #(
                .A_SIGNED(B_SIGNED), 
                .B_SIGNED(A_SIGNED), 
                .A_WIDTH(B_WIDTH),
                .B_WIDTH(A_WIDTH),
                .Y_WIDTH(Y_WIDTH)
            ) _TECHMAP_REPLACE_ (
                .A(B), 
                .B(A), 
                .Y(Y)
            );
        end
        else begin
            // Actual output reduction transformation
            // Y is too large and can be truncated.
            localparam ADDER_WIDTH  = `MAX(`Y_MIN_WIDTH, A_WIDTH+1);

            \$add #(
                .A_SIGNED(A_SIGNED), 
                .B_SIGNED(B_SIGNED), 
                .A_WIDTH(A_WIDTH),
                .B_WIDTH(B_WIDTH),
                .Y_WIDTH(ADDER_WIDTH)
            ) _TECHMAP_REPLACE_ (
                .A(A), 
                .B(B), 
                .Y(Y[ADDER_WIDTH-1:0]) 
            );
            assign Y[Y_WIDTH-1:ADDER_WIDTH] = { (Y_WIDTH-ADDER_WIDTH){SIGNED_ADDER ? Y[ADDER_WIDTH-1] : 1'b0} };
        end
    endgenerate

    
endmodule

