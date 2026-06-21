module IF_ID_register (
    input clk, rst, flush, stall,
    input [31:0] instr_in,
    output reg [31:0] instr_out
);
always @(posedge clk or posedge rst) begin
    if (rst || flush) instr_out <= 0;
    else if (!stall) instr_out <= instr_in;
end
endmodule

module ID_EX_register (
    input clk, rst, flush,
    input [31:0] d1_in, d2_in,
    input [4:0] rs_in, rt_in, rd_in,
    input [5:0] funct_in,
    output reg [31:0] d1_out, d2_out,
    output reg [4:0] rs_out, rt_out, rd_out,
    output reg [5:0] funct_out
);
always @(posedge clk or posedge rst) begin
    if (rst || flush) begin
        d1_out <= 0; d2_out <= 0;
        rs_out <= 0; rt_out <= 0; rd_out <= 0;
        funct_out <= 0;
    end else begin
        d1_out <= d1_in; d2_out <= d2_in;
        rs_out <= rs_in; rt_out <= rt_in; rd_out <= rd_in;
        funct_out <= funct_in;
    end
end
endmodule

module EX_MEM_register (
    input clk, rst,
    input [31:0] alu_in,
    input [4:0] rd_in,
    output reg [31:0] alu_out,
    output reg [4:0] rd_out
);
always @(posedge clk or posedge rst) begin
    if (rst) begin alu_out <= 0; rd_out <= 0; end
    else begin alu_out <= alu_in; rd_out <= rd_in; end
end
endmodule

module MEM_WB_register (
    input clk, rst,
    input [31:0] alu_in,
    input [4:0] rd_in,
    output reg [31:0] alu_out,
    output reg [4:0] rd_out
);
always @(posedge clk or posedge rst) begin
    if (rst) begin alu_out <= 0; rd_out <= 0; end
    else begin alu_out <= alu_in; rd_out <= rd_in; end
end
endmodule
