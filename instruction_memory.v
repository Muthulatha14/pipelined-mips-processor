module instruction_memory (
    input  [31:0] addr,
    output [31:0] instr
);
reg [31:0] imem [0:63];
initial begin
    // ADD x3, x1, x2   -> x3 = 15 + 5 = 20
    imem[0] = {6'b000000, 5'd1, 5'd2, 5'd3, 5'd0, 6'b100000};
    // SUB x5, x3, x1   -> x5 = x3 - x1 = 20 - 15 = 5  (DEPENDS on x3!)
    imem[1] = {6'b000000, 5'd3, 5'd1, 5'd5, 5'd0, 6'b100010};
    imem[2] = 32'b0;
    imem[3] = 32'b0;
    imem[4] = 32'b0;
end
assign instr = imem[addr[31:2]];
endmodule
