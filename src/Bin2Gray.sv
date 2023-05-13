module Bin2Gray #(
    parameter int WIDTH = 4
) (
    input  wire [WIDTH-1:0] bin,
    output reg  [WIDTH-1:0] gray
);

  always_comb begin
    gray[WIDTH-1] = bin[WIDTH-1];
    for (int i = WIDTH - 2; i >= 0; i--) gray[i] = bin[i] ^ bin[i+1];
  end

endmodule
