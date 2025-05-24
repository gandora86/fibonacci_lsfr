`timescale 1ns/1ps

module lfsr_tb;

    parameter WIDTH = 16;
    integer   txt_write;

    reg clk;
    reg reset;
    reg lfsr_enable;

    wire [WIDTH -1:0] prn;
    
    initial begin
        // File to write output for observation
        txt_write = $fopen("output.txt");
        clk = 0; reset = 1; lfsr_enable = 0;
        repeat(3) begin
            #50 reset = ~reset;
        end
        lfsr_enable = 1;
        #(2**WIDTH*10)
        $fclose(txt_write);
        #100 $stop();
    end

    initial begin
        forever begin
            #5 clk = ~clk;
        end
    end

    lfsr lfsr_inst
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