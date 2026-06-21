module alu (
    input  [31:0] a, b,
    input  [5:0]  funct,
    output reg [31:0] result
);
always @(*) begin
    case (funct)
        6'b100000: result = a + b; // ADD
        6'b100010: result = a - b; // SUB
        6'b100100: result = a & b; // AND
        6'b100101: result = a | b; // OR
        default:   result = 32'b0;
    endcase
end
endmodule
