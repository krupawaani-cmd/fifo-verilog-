`timescale 1ns/1ps
module fifo #(
    parameter DEPTH = 8,
    parameter WIDTH = 8
)(
    input clk,
    input rst,
    input write,
    input read,
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout,
    output fifo_full,
    output fifo_empty,
    output reg [$clog2(DEPTH):0] status_counter
);

    reg [WIDTH-1:0] mem [0:DEPTH-1];
    reg [$clog2(DEPTH)-1:0] wr_ptr, rd_ptr;

    assign fifo_full  = (status_counter == DEPTH);
    assign fifo_empty = (status_counter == 0);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            status_counter <= 0;
            dout <= 0;
        end else begin
            // Write
            if (write && !fifo_full) begin
                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
                status_counter <= status_counter + 1;
            end
            // Read
            if (read && !fifo_empty) begin
                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                status_counter <= status_counter - 1;
            end
        end
    end
endmodule
