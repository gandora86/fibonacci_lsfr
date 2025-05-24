`timescale 1ns/1ps

module lfsr_tb;

    parameter WIDTH = 4;
    integer   txt_write;

    reg clk;
    reg reset;
    reg lfsr_enable;

    wire [WIDTH -1:0] prn;
    
    initial begin
        // File to write output for observation
        txt_write = $fopen("fibonacci_output.txt");
        clk = 0; reset = 1; lfsr_enable = 0;
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
        repeat(2*2**WIDTH) begin
            #50 lfsr_enable = ~lfsr_enable;
        end
        $fclose(txt_write);
        #100 $finish();
    end
    // Set max count =1 for simulation only
    fibonacci_lfsr #(.COUNT(1)) fibonacci_lfsr_inst
    (
        .clk(clk),
        .reset(reset),
        .lfsr_enable(lfsr_enable),

        .prn(prn)
    );

    always @(prn) begin
        $fmonitor(txt_write , "%d", prn);
    end
    
endmodule