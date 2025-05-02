`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: pc
//////////////////////////////////////////////////////////////////////////////////

module program_counter
(
    input clk,
    input reset,
    input [31:0] pc_in,
    output reg [31:0] pc_out
);

    always @(posedge clk or posedge reset) 
    begin
        if (reset)
            pc_out <= 32'h00000000;
        else
            pc_out <= pc_in;
    end

endmodule