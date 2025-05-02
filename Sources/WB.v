`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: WB
//////////////////////////////////////////////////////////////////////////////////

module WB
(
    input [1:0] WB_control,
    input [31:0] read_data,
    input [31:0] alu_result,
    output [31:0] write_data,
    output reg_write
);

    // Control signals
    wire mem_to_reg = WB_control[0];
    assign reg_write = WB_control[1];

    // Selects between memory data and alu result
    mux #(32) wb_mux 
    (
        .a(read_data),
        .b(alu_result),
        .sel(mem_to_reg),
        .y(write_data)
    );

endmodule
