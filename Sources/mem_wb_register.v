`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: mem wb register
//////////////////////////////////////////////////////////////////////////////////

module mem_wb_register
(
    input clk,
    input reset,
    input [1:0] wb_ctl_in,
    input [31:0] read_data_in,
    input [31:0] alu_result_in,
    input [4:0] write_reg_in,
    output reg [1:0] wb_ctl_out,
    output reg [31:0] read_data_out,
    output reg [31:0] alu_result_out,
    output reg [4:0] write_reg_out
);

    always @(posedge clk or posedge reset) 
    begin
        if (reset) 
        begin
            wb_ctl_out <= 2'b0;
            read_data_out <= 32'b0;
            alu_result_out <= 32'b0;
            write_reg_out <= 5'b0;
        end else 
        begin
            wb_ctl_out <= wb_ctl_in;
            read_data_out <= read_data_in;
            alu_result_out <= alu_result_in;
            write_reg_out <= write_reg_in;
        end
    end

endmodule