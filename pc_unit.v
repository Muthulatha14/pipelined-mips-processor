module pc_unit (
    input clk, rst, stall,
    output reg [31:0] pc
);
always @(posedge clk or posedge rst) begin
    if (rst) pc <= 0;
    else if (!stall) pc <= pc + 4;
end
endmodule
