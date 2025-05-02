`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: I_FETCH
//////////////////////////////////////////////////////////////////////////////////

module I_FETCH
(
    input clk,
    input reset,
    input PCSrc,
    input [31:0] mem_npc,
    output [31:0] IF_ID_IR,
    output [31:0] IF_ID_NPC
);
    
    wire [31:0] inst_wire;

    wire [31:0] PC_out;
    wire [31:0] mux_out;
    wire [31:0] incremented_pc;

    program_counter pc 
    (
        .clk(clk),
        .reset(reset),
        .pc_in(mux_out),
        .pc_out(PC_out)
    );

    instruction_memory I_MEM 
    (
        .address(PC_out[8:2]),
        .instruction(inst_wire)
    );

    incrementer inc 
    (
        .pcin(PC_out),
        .pcout(incremented_pc)
    );

    mux pc_mux 
    (
        .a(mem_npc),
        .b(incremented_pc),
        .sel(PCSrc),
        .y(mux_out)
    );

    if_id_register if_id 
    (
        .clk(clk),
        .reset(reset),
        .npc(incremented_pc),
        .instr(inst_wire),
        .npc_out(IF_ID_NPC),
        .instr_out(IF_ID_IR)
    );

endmodule
