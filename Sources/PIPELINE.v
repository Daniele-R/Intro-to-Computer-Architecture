`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: Pipeline
//////////////////////////////////////////////////////////////////////////////////

module PIPELINE
(
    input clk,
    input reset,
    input [31:0] mem_npc,
    input [4:0] mem_wb_writereg,
    input [31:0] mem_wb_writedata,
    output [1:0] WB_out,
    output [31:0] read_data_out,
    output [31:0] alu_result_out,
    output [4:0] write_reg_out,
    output PCSrc,
    output [31:0] write_data_out 
);

    wire [31:0] IF_ID_IR;
    wire [31:0] IF_ID_NPC;
    wire [8:0] control_bits_out;
    wire [31:0] NPC_out;
    wire [31:0] rs_out;
    wire [31:0] rt_out;
    wire [31:0] ext_sign;
    wire [4:0] MUX1;
    wire [4:0] MUX2;

    wire [1:0] WB_out_EX;
    wire [2:0] mem_out_EX;
    wire [31:0] alu_out_EX;
    wire Zero_EX, reg_write_out;
    wire [31:0] add_out_EX;
    wire [31:0] B_out_EX;
    wire [4:0] MUX_out_EX;

    I_FETCH fetch_stage
    (
        .clk(clk),
        .reset(reset),
        .PCSrc(PCSrc),
        .mem_npc(mem_npc),
        .IF_ID_IR(IF_ID_IR),
        .IF_ID_NPC(IF_ID_NPC)
    );


    I_DECODE decode_stage
    (
        .clk(clk),
        .reset(reset),
        .IF_ID_latch(IF_ID_IR),
        .NPC_in(IF_ID_NPC),
        .reg_write(reg_write_out),
        .mem_wb_writereg(mem_wb_writereg),
        .mem_wb_writedata(mem_wb_writedata),
        .control_bits_out(control_bits_out),
        .NPC_out(NPC_out),
        .rs_out(rs_out),
        .rt_out(rt_out),
        .ext_sign(ext_sign),
        .MUX1(MUX1),
        .MUX2(MUX2)
    );

    I_EXECUTE execute_stage
    (
        .clk(clk),
        .reset(reset),
        .WB_in(control_bits_out[8:7]),
        .mem_in(control_bits_out[6:4]),
        .ex_in(control_bits_out[3:0]),
        .NPC_in(NPC_out),
        .A_in(rs_out),
        .B_in(rt_out),
        .mm_in(ext_sign),
        .RT_in(MUX1),
        .RD_in(MUX2),
        .WB_out(WB_out_EX),
        .mem_out(mem_out_EX),
        .alu_out(alu_out_EX),
        .Zero(Zero_EX),
        .add_out(add_out_EX),
        .B_out(B_out_EX),
        .MUX_out(MUX_out_EX)
    );

    MEMORY memory_stage
    (
        .clk(clk),
        .reset(reset),
        .WB_in(WB_out_EX), 
        .mem_in(mem_out_EX), 
        .alu_result_in(alu_out_EX), 
        .write_data_in(B_out_EX), 
        .write_reg_in(MUX_out_EX), 
        .Zero_in(Zero_EX), 
        .WB_out(WB_out), 
        .read_data_out(read_data_out), 
        .alu_result_out(alu_result_out), 
        .write_reg_out(write_reg_out), 
        .PCSrc(PCSrc)
    );

    WB wb_stage
    (
        .WB_control(WB_out),  
        .read_data(read_data_out), 
        .alu_result(alu_result_out),  
        .write_data(write_data_out), 
        .reg_write(reg_write_out)  
    );

endmodule
