`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: if id register
//////////////////////////////////////////////////////////////////////////////////

module if_id_register
(
    input wire clk,
    input wire reset,
    input wire [31:0] npc,
    input wire [31:0] instr,                    // cant use instruction :c
    output reg [31:0] npc_out,
    output reg [31:0] instr_out
);

    always @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            npc_out <= 32'h00000000;
            instr_out <= 32'h00000000;
        end else 
        begin
            npc_out <= npc;
            instr_out <= instr;
        end
    end
    
endmodule
