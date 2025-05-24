`timescale 1ns/1ps

module fibonacci_lfsr (
    input wire  clk,
    input wire  reset,
    input wire  lfsr_enable,
    output reg [3:0] prn    // pseudo random number
);

    localparam START = 3'd0;
    localparam READ_SEED = 3'd1;
    localparam INIT_LFSR = 3'd2;
    localparam SHIFT_LFSR = 3'd3;
    localparam HOLD = 3'd4;
  
    reg [2:0] state;
    reg [3:0] seed_reg;

    always @(posedge clk) begin
        if (reset) begin
            prn <= 'b0;
            seed_reg <= 'b0011;
            state <= START;
        end else begin
            case (state)
                START : begin
                    prn <= 'b0;
                    state <= READ_SEED;
                end
                READ_SEED : begin
                    seed_reg <= 4'b0011;
                    state <= INIT_LFSR;
                end
                INIT_LFSR: begin
                    prn <= seed_reg;
                    state <= SHIFT_LFSR;
                end
                SHIFT_LFSR: begin
                    prn <= {prn[2:0], prn[3] ^prn[1]};
                    state <= HOLD;
                end
                HOLD: begin
                    prn <= prn;
                    if(lfsr_enable) begin
                        state <= SHIFT_LFSR;
                    end else begin
                        state <= HOLD;
                    end
                end
                default: state <= START;
            endcase
        end
    end
    
endmodule