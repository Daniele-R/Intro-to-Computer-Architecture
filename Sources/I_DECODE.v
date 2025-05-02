`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: I_DECODE
//////////////////////////////////////////////////////////////////////////////////

module I_DECODE
(
    input clk,
    input reset,
    input [31:0] IF_ID_latch,                           // instruction from IF/ID latch
    input [31:0] NPC_in,
    input reg_write,                                     // From WB stage
    input [4:0] mem_wb_writereg,                        // From WB stage
    input [31:0] mem_wb_writedata,                      // From WB stage
    output [8:0] control_bits_out,                      // Combined control
    output [31:0] NPC_out,
    output [31:0] rs_out,
    output [31:0] rt_out,
    output [31:0] ext_sign,
    output [4:0] MUX1,
    output [4:0] MUX2
);

    // Intermediate signals
    wire [8:0] control_bits;
    wire [31:0] read_data1, read_data2;
    wire [31:0] sign_extended_wire;


    control control_unit
     (
        .control(IF_ID_latch[31:26]),
        .controlbits(control_bits)
    );

    register reg_file
    (
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .read_reg1(IF_ID_latch[25:21]),
        .read_reg2(IF_ID_latch[20:16]),
        .write_reg(mem_wb_writereg),
        .write_data(mem_wb_writedata),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    sign_extend sign_extend_unit
    (
        .ext16(IF_ID_latch[15:0]),
        .ext32(sign_extended_wire)
    );

    id_ex_register id_ex_reg
    (
        .clk(clk),
        .reset(reset),
        .control_bits_in(control_bits),
        .NPC_in(NPC_in),
        .reg_rs_in(read_data1),
        .reg_rt_in(read_data2),
        .ext_sign_in(sign_extended_wire),
        .instr_20_16_in(IF_ID_latch[20:16]),
        .instr_15_11_in(IF_ID_latch[15:11]),
        .control_bits_out(control_bits_out),
        .NPC_out(NPC_out),
        .reg_rs_out(rs_out),
        .reg_rt_out(rt_out),
        .ext_sign_out(ext_sign),
        .instr_20_16_out(MUX1),
        .instr_15_11_out(MUX2)
    );

endmodule