module decode_unit (
    input [31:0] instr,
    output [4:0] rs, rt, rd,
    output [5:0] funct
);
assign rs    = instr[25:21];
assign rt    = instr[20:16];
assign rd    = instr[15:11];
assign funct = instr[5:0];
endmodule
