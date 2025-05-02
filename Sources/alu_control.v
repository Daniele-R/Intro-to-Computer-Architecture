`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: alu_control 
//////////////////////////////////////////////////////////////////////////////////

module alu_control
(
    input [1:0] alu_op,      
    input [5:0] funct,       
    output reg [2:0] alu_control 
);

    always @(*) 
    begin
        case (alu_op)
            2'b00: alu_control = 3'b010;                     // LW/SW: Add
            2'b01: alu_control = 3'b110;                     // BEQ: Subtract
            2'b10: begin                                     // R-type instructions
                case (funct)
                    6'b100000: alu_control = 3'b010;         // ADD
                    6'b100010: alu_control = 3'b110;         // SUB
                    6'b100100: alu_control = 3'b000;         // AND
                    6'b100101: alu_control = 3'b001;         // OR
                    6'b101010: alu_control = 3'b111;         // SLT
                    default:   alu_control = 3'bxxx;         // Default (noncare)
                endcase
            end
            default: alu_control = 3'bxxx;
        endcase
    end

endmodule