`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: data memory
//////////////////////////////////////////////////////////////////////////////////

module data_memory
(
    input clk,
    input [7:0] address,
    input [31:0] write_data,
    input mem_read,
    input mem_write,
    output reg [31:0] read_data
);

    // Declare 256 32-bit memory locations 
    (*rom_style = "block"*) reg [31:0] memory [0:255];
 
    initial 
    begin
        memory[0] = 32'b00000000000000000000000000000000;
        memory[1] = 32'b00000000000000000000000000000001;
        memory[2] = 32'b00000000000000000000000000000010;
        memory[3] = 32'b00000000000000000000000000000011;
        memory[4] = 32'b00000000000000000000000000000100;
        memory[5] = 32'b00000000000000000000000000000101;
    end

    // Read
    always @(*) 
    begin
        if (mem_read)
            read_data = memory[address];
        else
            read_data = 32'bz;
    end

    // Write
    always @(posedge clk) 
    begin
        if (mem_write)
            memory[address] = write_data;
    end

endmodule