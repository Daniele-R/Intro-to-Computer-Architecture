`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: id_ex_register
//////////////////////////////////////////////////////////////////////////////////

module id_ex_register
(
    input clk,
    input reset,
    input [8:0] control_bits_in,
    input [31:0] NPC_in,
    input [31:0] reg_rs_in,
    input [31:0] reg_rt_in,
    input [31:0] ext_sign_in,
    input [4:0] instr_20_16_in,
    input [4:0] instr_15_11_in,
    output reg [8:0] control_bits_out,
    output reg [31:0] NPC_out,
    output reg [31:0] reg_rs_out,
    output reg [31:0] reg_rt_out,
    output reg [31:0] ext_sign_out,
    output reg [4:0] instr_20_16_out,
    output reg [4:0] instr_15_11_out
);

    always @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            control_bits_out <= 9'b0;
            NPC_out <= 32'h00000000;
            reg_rs_out <= 32'h00000000;
            reg_rt_out <= 32'h00000000;
            ext_sign_out <= 32'h00000000;
            instr_20_16_out <= 5'b00000;
            instr_15_11_out <= 5'b00000;
        end else 
        begin
            control_bits_out <= control_bits_in;
            NPC_out <= NPC_in;
            reg_rs_out <= reg_rs_in;
            reg_rt_out <= reg_rt_in;
            ext_sign_out <= ext_sign_in;
            instr_20_16_out <= instr_20_16_in;
            instr_15_11_out <= instr_15_11_in;
        end
    end

endmodule
