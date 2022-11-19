
module top_unsigned(input [5:0] op0, input [6:0] op1, output [63:0] sum0);
    assign sum0     = op0 + op1;
endmodule

module top_unsigned10(input [5:0] op0, input [6:0] op1, output [9:0] sum0);
    assign sum0     = op0 + op1;
endmodule

module top_signed(input signed [5:0] op0, input signed [6:0] op1, output signed [63:0] sum0);
    assign sum0     = op0 + op1;
endmodule
