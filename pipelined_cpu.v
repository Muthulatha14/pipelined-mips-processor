module pipelined_cpu (
    input clk, rst
);
wire [31:0] pc, instr, instr_id;
wire [4:0] rs, rt, rd_id;
wire [5:0] funct_id;
wire [31:0] rd1, rd2;
wire [31:0] ex_d1, ex_d2;
wire [4:0] ex_rs, ex_rt, ex_rd;
wire [5:0] ex_funct;
wire [31:0] alu_a, alu_b, alu_result;
wire [31:0] mem_alu;
wire [4:0] mem_rd;
wire [31:0] wb_alu;
wire [4:0] wb_rd;
wire [1:0] forward_a, forward_b;

reg we, ex_mem_we, mem_wb_we;

pc_unit PC (.clk(clk), .rst(rst), .stall(1'b0), .pc(pc));
instruction_memory IMEM (.addr(pc), .instr(instr));
IF_ID_register IFID (.clk(clk), .rst(rst), .flush(1'b0), .stall(1'b0), .instr_in(instr), .instr_out(instr_id));

decode_unit DEC (.instr(instr_id), .rs(rs), .rt(rt), .rd(rd_id), .funct(funct_id));

register_file RF (
    .clk(clk), .we(we),
    .rs(rs), .rt(rt), .rd(wb_rd),
    .write_data(wb_alu),
    .read_data1(rd1), .read_data2(rd2)
);

ID_EX_register IDEX (
    .clk(clk), .rst(rst), .flush(1'b0),
    .d1_in(rd1), .d2_in(rd2),
    .rs_in(rs), .rt_in(rt), .rd_in(rd_id),
    .funct_in(funct_id),
    .d1_out(ex_d1), .d2_out(ex_d2),
    .rs_out(ex_rs), .rt_out(ex_rt), .rd_out(ex_rd),
    .funct_out(ex_funct)
);

forwarding_unit FU (
    .id_ex_rs(ex_rs), .id_ex_rt(ex_rt),
    .ex_mem_rd(mem_rd), .mem_wb_rd(wb_rd),
    .ex_mem_reg_write(ex_mem_we), .mem_wb_reg_write(mem_wb_we),
    .forward_a(forward_a), .forward_b(forward_b)
);

assign alu_a = (forward_a == 2'b10) ? mem_alu :
               (forward_a == 2'b01) ? wb_alu  : ex_d1;
assign alu_b = (forward_b == 2'b10) ? mem_alu :
               (forward_b == 2'b01) ? wb_alu  : ex_d2;

alu ALU (.a(alu_a), .b(alu_b), .funct(ex_funct), .result(alu_result));
EX_MEM_register EXMEM (
    .clk(clk), .rst(rst),
    .alu_in(alu_result), .rd_in(ex_rd),
    .alu_out(mem_alu), .rd_out(mem_rd)
);

MEM_WB_register MEMWB (
    .clk(clk), .rst(rst),
    .alu_in(mem_alu), .rd_in(mem_rd),
    .alu_out(wb_alu), .rd_out(wb_rd)
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        we <= 0; ex_mem_we <= 0; mem_wb_we <= 0;
    end else begin
        we <= 1; ex_mem_we <= 1; mem_wb_we <= 1;
    end
end

endmodule
