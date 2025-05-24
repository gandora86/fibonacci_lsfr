`timescale 1ns/1ps

module seven_segment #(
    parameter WIDTH = 8,
    parameter COUNT = 500_000
) (
    input wire  clk,
    input wire  reset,
    input wire  [WIDTH -1:0] word,
    output reg  [6:0] seg,
    output wire [7:0] anode_activate
);
    localparam COUNT_WIDTH = $clog2(COUNT);

    reg [6:0] segment_patterns [15:0];
    reg [COUNT_WIDTH -1:0] counter;
    reg clk_seven_seg;
    reg [1:0] display;
    reg [6:0] seg0;
    reg [6:0] seg1;
    // turn on only two
    assign anode_activate = ~{6'b000000, display};

    always @(posedge clk) begin
        if (reset) begin
            seg0 <= 'b0;
            seg1 <= 'b1;
            segment_patterns[0] = ~7'b1111110; // 0
            segment_patterns[1] = ~7'b0110000; // 1
            segment_patterns[2] = ~7'b1101101; // 2
            segment_patterns[3] = ~7'b1111001; // 3
            segment_patterns[4] = ~7'b0110011; // 4
            segment_patterns[5] = ~7'b1011011; // 5
            segment_patterns[6] = ~7'b1011111; // 6
            segment_patterns[7] = ~7'b1110000; // 7
            segment_patterns[8] = ~7'b1111111; // 8
            segment_patterns[9] = ~7'b1111011; // 9
            segment_patterns[10] = ~7'b1110111; // A
            segment_patterns[11] = ~7'b0011111; // b
            segment_patterns[12] = ~7'b1001110; // C
            segment_patterns[13] = ~7'b0111101; // d
            segment_patterns[14] = ~7'b1001111; // E
            segment_patterns[15] = ~7'b1000111; // F
        end else begin
            // Seven Segment Calculation
            case (word[3:0])
                4'd0: seg0 <= segment_patterns[0];
                4'd1: seg0 <= segment_patterns[1];
                4'd2: seg0 <= segment_patterns[2];
                4'd3: seg0 <= segment_patterns[3];
                4'd4: seg0 <= segment_patterns[4];
                4'd5: seg0 <= segment_patterns[5];
                4'd6: seg0 <= segment_patterns[6];
                4'd7: seg0 <= segment_patterns[7];
                4'd8: seg0 <= segment_patterns[8];
                4'd9: seg0 <= segment_patterns[9];
                4'd10: seg0 <= segment_patterns[10];
                4'd11: seg0 <= segment_patterns[11];
                4'd12: seg0 <= segment_patterns[12];
                4'd13: seg0 <= segment_patterns[13];
                4'd14: seg0 <= segment_patterns[14];
                4'd15: seg0 <= segment_patterns[15];
            endcase
            case (word[7:4])
                4'd0: seg1 <= segment_patterns[0];
                4'd1: seg1 <= segment_patterns[1];
                4'd2: seg1 <= segment_patterns[2];
                4'd3: seg1 <= segment_patterns[3];
                4'd4: seg1 <= segment_patterns[4];
                4'd5: seg1 <= segment_patterns[5];
                4'd6: seg1 <= segment_patterns[6];
                4'd7: seg1 <= segment_patterns[7];
                4'd8: seg1 <= segment_patterns[8];
                4'd9: seg1 <= segment_patterns[9];
                4'd10: seg1 <= segment_patterns[10];
                4'd11: seg1 <= segment_patterns[11];
                4'd12: seg1 <= segment_patterns[12];
                4'd13: seg1 <= segment_patterns[13];
                4'd14: seg1 <= segment_patterns[14];
                4'd15: seg1 <= segment_patterns[15];
            endcase
        end
    end

    // Clock Divider to meet setup time for the sevn segment
    always@(posedge clk)begin
        if(reset) begin
            counter <= 'b0;
            clk_seven_seg <= 'b0;
        end else begin
            if(counter <= COUNT) begin
                counter <= counter + 1;
                clk_seven_seg <= clk_seven_seg;
            end
            else begin
                counter <= 0;
                clk_seven_seg <= ~clk_seven_seg;
            end
        end
    end
    // set the seven segment display on for only two segments and display
    always @(posedge clk_seven_seg or posedge reset) begin
        if (reset) begin
            display <= 'b0;
            seg <= 'b1;
        end else begin
            if(display == 2'b10) begin
                seg <= seg0;
                display <= 2'b01;
            end else begin
                seg <= seg1;
                display <= 2'b10;
            end
        end
    end
    
endmodule