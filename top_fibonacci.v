`timescale 1ns/1ps

module top #(
    parameter WIDTH = 8,
    parameter COUNT = 500_000
) (
    input wire  clk,
    input wire  reset,
    input wire  [WIDTH -1:0] seed,
    input wire  seed_pulse,         // pulse 1 to read input seed
    input wire  lfsr_pulse,         // pulse 1 to calculate next random pattern

    output wire error,              // error is 1 when seed is all zeros next pattern can't be caluclated or the output is all zeros
    output wire [WIDTH -1:0] prn,    // pseudo random number
    output wire [6:0] seg,
    output wire [7:0] anode_activate
);

    wire seed_pulse_wire;
    wire lfsr_pulse_wire;

    // for button debounce
    debounce_mealy_fsm dbounce_seed_pulse (
       .clk(clk),
       .b(seed_pulse),
       .d(seed_pulse_wire)
    );
    debounce_mealy_fsm dbounce_lfsr_pulse (
        .clk(clk),
        .b(lfsr_pulse),
        .d(lfsr_pulse_wire)
    );

    fibonacci_lfsr #(.COUNT(COUNT)) fibonacci_lfsr_inst
    (
        .clk(clk),
        .reset(reset),
        .seed(seed),
        .seed_pulse(seed_pulse_wire),
        .lfsr_enable(lfsr_pulse_wire),

        .error(error),
        .prn(prn)
    );

    seven_segment #(.WIDTH(WIDTH), .COUNT(COUNT)
    ) uut (
        .clk(clk),
        .reset(reset),
        .word(prn),
        .seg(seg),
        .anode_activate(anode_activate)
    );
    
endmodule