module register_file (
    input clk, we,
    input  [4:0] rs, rt, rd,
    input  [31:0] write_data,
    output [31:0] read_data1, read_data2
);
reg [31:0] regs [0:31];
integer i;
initial for (i = 0; i < 32; i = i + 1) regs[i] = 0;

always @(posedge clk)
    if (we && rd != 0) regs[rd] <= write_data;

// Write-then-read forwarding: avoids same-cycle read/write race
assign read_data1 = (rs == 0) ? 32'b0 :
                     (we && rd == rs) ? write_data : regs[rs];
assign read_data2 = (rt == 0) ? 32'b0 :
                     (we && rd == rt) ? write_data : regs[rt];
endmodule
