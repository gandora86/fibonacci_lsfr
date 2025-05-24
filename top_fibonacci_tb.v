`timescale 1ns/1ps

module top_tb;

    parameter WIDTH = 8;
    integer   txt_write;

    reg clk;
    reg reset;
    reg [WIDTH -1:0] seed;
    reg seed_pulse;
    reg lfsr_pulse;

    wire error;
    wire [WIDTH -1:0] prn;
    wire [6:0] seg;
    wire [7:0] anode_activate;

    initial begin
        // File to write output for observation
        txt_write = $fopen("fibonacci_output.txt");
        clk = 0; reset = 1; seed_pulse = 0; lfsr_pulse = 0;
        repeat(3) begin
            #50 reset = ~reset;
        end
    end

    initial begin
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        seed = $random();
        #200 seed_pulse = 1; #50 seed_pulse = 0;
        repeat(2*2**WIDTH) begin
            #50 lfsr_pulse = ~lfsr_pulse;
        end
        $fclose(txt_write);
        #100 $finish();
    end
    // Set max count =1 for simulation only
    top #(.COUNT(1)) uut_inst
    (
        .clk(clk),
        .reset(reset),
        .seed(seed),
        .seed_pulse(seed_pulse),
        .lfsr_pulse(lfsr_pulse),

        .error(error),
        .prn(prn),
        .seg(seg),
        .anode_activate(anode_activate)
    );

    always @(prn) begin
        $fmonitor(txt_write , "%d", prn);
    end
    
endmodule