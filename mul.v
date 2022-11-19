
module top(input [9:0] op0, input [9:0] op1, output [19:0] result);
    assign result = op0 * op1;
endmodule

module top_large(input [19:0] op0, input [19:0] op1, output [39:0] result);
    assign result = op0 * op1;
endmodule
