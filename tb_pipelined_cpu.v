module tb_pipelined_cpu;

reg clk, rst;
pipelined_cpu uut (.clk(clk), .rst(rst));

always #5 clk = ~clk;

initial begin
    clk = 0; rst = 1;
    #10 rst = 0;

    uut.RF.regs[1] = 15;
    uut.RF.regs[2] = 5;

    repeat (8) begin
        #10;
        $display("PC=%0d | fwd_a=%b fwd_b=%b | wb_rd=%0d wb_alu=%0d",
                   uut.pc, uut.forward_a, uut.forward_b, uut.wb_rd, uut.wb_alu);
    end

    $display("FINAL REGISTERS: x3=%0d (ADD 15+5) x5=%0d (SUB x3-x1, should be 20-15=5)",
               uut.RF.regs[3], uut.RF.regs[5]);

    $finish;
end

endmodule
