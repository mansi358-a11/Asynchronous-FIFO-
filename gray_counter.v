module gray_counter#(
  parameter ADDR_WIDTH =4
)(
  input wire clk,
  input wire rst_n,
  input wire en,
  output reg [ADDR_WIDTH:0] bin_ptr,
  output wire [ADDR_WIDTH:0] gray_ptr
);

always@(posedge clk or negedge rst_n) begin
  if(!rst_n)
  bin_ptr<=0;
  else if (en)
  bin_ptr<=bin_ptr+1;
end

assign gray_ptr =(bin_ptr>>1^bin_ptr);

endmodule