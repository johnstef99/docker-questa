`timescale 1ns / 1ps

module Gray2Bin_tb;
  parameter int WIDTH = 3;

  reg  [WIDTH-1:0] gray_tb;
  wire [WIDTH-1:0] bin_tb;

  Gray2Bin #(
      .WIDTH(WIDTH)
  ) gray2bin (
      .gray(gray_tb),
      .bin (bin_tb)
  );

  initial begin
    gray_tb = 0;
    assert(gray_tb == 0)begin
      $display("[PASS]");
      $display("[FAIL]");
      $display("other message");
    end
    for (integer i = 0; i < 2 ** WIDTH; i++) begin
      #10 gray_tb = gray_tb + 1;
    end
    #10 $finish;
  end

endmodule
