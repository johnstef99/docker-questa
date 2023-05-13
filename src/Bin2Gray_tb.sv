`timescale 1ns / 1ps

module Bin2Gray_tb;
  parameter int WIDTH = 3;

  reg  [WIDTH-1:0] bin_tb;
  wire [WIDTH-1:0] gray_tb;

  Bin2Gray #(
      .WIDTH(WIDTH)
  ) bin2gray (
      .bin (bin_tb),
      .gray(gray_tb)
  );

  initial begin
    bin_tb = 0;
    for (integer i = 0; i < 2 ** WIDTH; i++) begin
      #10 bin_tb = bin_tb + 1;
    end
    #10 $finish;
  end

  wire _unused_ok_ = &{1'b0, gray_tb, 1'b0};

endmodule
