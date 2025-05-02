`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: alu
//////////////////////////////////////////////////////////////////////////////////

module alu
(
    input [31:0] a,
    input [31:0] b,
    input [2:0] alu_control,
    output reg [31:0] result,
    output reg zero
);

    always @(*) 
    begin
        case (alu_control)
            3'b000: result  = a & b;          // AND
            3'b001: result  = a | b;          // OR
            3'b010: result  = a + b;          // ADD
            3'b011: result  = 32'bx;
            3'b100: result  = 32'bx;
            3'b110: result  = a - b;          // SUB
            3'b111: result  = 32'bx;
            default: result = 32'bx;          // Noncare
        endcase

        zero = (result == 32'b0);             // Zero flag when result = 0
    end

endmodule
