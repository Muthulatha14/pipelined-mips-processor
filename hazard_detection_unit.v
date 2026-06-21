module hazard_detection_unit (
    input [4:0] id_rs, id_rt,
    input [4:0] ex_rd,
    input [4:0] mem_rd,
    output stall
);
assign stall = ((id_rs != 0 && (id_rs == ex_rd || id_rs == mem_rd)) ||
                 (id_rt != 0 && (id_rt == ex_rd || id_rt == mem_rd)));
endmodule
