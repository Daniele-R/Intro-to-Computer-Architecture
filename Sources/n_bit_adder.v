`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:    Daniele Ricciardelli
// Design Name: 
// Module Name: n_adder
//////////////////////////////////////////////////////////////////////////////////

module n_bit_adder #(parameter N = 32)
(
    input [N-1:0] a,
    input [N-1:0] b,
    input cin,
    output [N-1:0] sum,
    output cout
);

    wire [N:0] carry;
    assign carry[0] = cin;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : adder_loop
            full_adder fa 
            (
                .a(a[i]),
                .b(b[i]),
                .cin(carry[i]),
                .sum(sum[i]),
                .cout(carry[i+1])
            );
        end
    endgenerate

    assign cout = carry[N];

endmodule

module full_adder
(
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule