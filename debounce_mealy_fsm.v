`timescale 1ns/1ps

module debounce_mealy_fsm (
    input   wire  clk,
    input   wire  b,
    output  reg   d
);
    reg [1:0] state;

    always @(posedge clk) begin
        case(state)
            2'b00: begin    // Waiting
                if (b) begin
                    state   <= 2'b01;
                    d       <= 1'b0;
                end else begin
                    state   <= 2'b00;
                    d       <= 1'b0;
                end
            end
            2'b01: begin    // Pressed
                if (b) begin
                    state   <= 2'b11;
                    d       <= 1'b0;
                end else begin
                    state   <= 2'b00;
                    d       <= 1'b0;
                end
            end
            2'b11: begin    // Held
                if (b) begin
                    state   <= 2'b11;
                    d       <= 1'b0;
                end else begin
                    state   <= 2'b10;
                    d       <= 1'b0;
                end
            end
            2'b10: begin    // Released
                if (b) begin
                    state   <= 2'b01;
                    d       <= 1'b0;
                end else begin
                    state   <= 2'b00;
                    d       <= 1;
                end
            end
            default: begin    // Waiting
                if (b) begin
                    state   <= 2'b01;
                    d       <= 1'b0;
                end else begin
                    state   <= 2'b00;
                    d       <= 1'b0;
                end
            end
        endcase 
    end

endmodule
