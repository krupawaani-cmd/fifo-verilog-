`timescale 1ns/1ps
module fifo_tb();

  reg clk, rst, write, read;
  reg [7:0] din;
  wire [7:0] dout;
  wire fifo_empty, fifo_full;
  wire [3:0] status_counter;

  fifo uut (
    .clk(clk),
    .rst(rst),
    .write(write),
    .read(read),
    .din(din),
    .dout(dout),
    .fifo_empty(fifo_empty),
    .fifo_full(fifo_full),
    .status_counter(status_counter)
  );

  always #5 clk = ~clk; // 10ns period

  initial begin
    // --- Enable VCD dump ---
    $dumpfile("dump.vcd");
    $dumpvars(0, fifo_tb);

    // Initialize
    clk = 0; rst = 1; write = 0; read = 0; din = 0;
    #20 rst = 0;

    // Write 7 values (11..77)
    repeat (7) begin
      @(negedge clk);
      write = 1;
      din = din + 8'h11;
    end
    @(negedge clk) write = 0;

    #20;

    // Read 7 values back
    repeat (7) begin
      @(negedge clk);
      read = 1;
    end
    @(negedge clk) read = 0;

    #50;
    $finish;
  end

endmodule
