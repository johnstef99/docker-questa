module Gray2Bin #(
    parameter int WIDTH = 4
) (
    input  wire [WIDTH-1:0] gray,
    output reg  [WIDTH-1:0] bin
);

  always_comb begin
    bin[WIDTH-1] = gray[WIDTH-1];
    for (int i = WIDTH - 2; i >= 0; i--) bin[i] = gray[i] ^ bin[i+1];
  end

endmodule
