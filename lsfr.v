`timescale 1ns/1ps

module lfsr #(
    parameter WIDTH = 16
) (
    input wire  clk,
    input wire  reset,
    input wire  lfsr_enable,
    output reg [WIDTH -1:0] prn    // pseudo random number
);

    always @(posedge clk) begin
        if (reset) begin
            prn <= {WIDTH{1'b1}};
        end else begin
            if(lfsr_enable) begin
                prn <= {prn[WIDTH -2:5], prn[4]^prn[WIDTH-1], prn[3], prn[2]^prn[WIDTH-1], prn[1]^prn[WIDTH-1] ,prn[0], prn[WIDTH-1]};
            end
        end
    end
    
endmodule
