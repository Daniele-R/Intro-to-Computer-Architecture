`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: sign_extend
//////////////////////////////////////////////////////////////////////////////////

module sign_extend
(
    input [15:0] ext16,
    output [31:0] ext32
);

    assign ext32 = {{16{ext16[15]}}, ext16};

endmodule
