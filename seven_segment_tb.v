`timescale 1ns/1ps

module seven_segment_tb;

    parameter WIDTH = 8;
    parameter COUNT = 1;

    reg clk;
    reg reset;
    reg [WIDTH -1:0] word;

    wire [6:0] seg;
    wire [7:0] anode_activate;

    initial begin
        clk = 0; reset = 1;
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
        word = $random();
        repeat(10) begin
            #50;
        end
        word = $random();
        repeat(10) begin
            #50;
        end
        word = $random();
        repeat(10) begin
            #50;
        end
        #100 $finish();
    end
    // Set max count =1 for simulation only
    seven_segment #(.WIDTH(WIDTH), .COUNT(COUNT)
    ) uut (
        .clk(clk),
        .reset(reset),
        .word(word),
        .seg(seg),
        .anode_activate(anode_activate)
    );
    
endmodule