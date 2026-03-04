module async_fifo #(
  parameter DATA_WIDTH =8,
  parameter ADDR_WIDTH =4
)
(
  input wire wr_clk,
  input wire rd_clk,
  input wire rst_n,

  input wire wr_en,
  input wire rd_en,

  input wire [DATA_WIDTH-1:0]  wr_data,
  output reg [DATA_WIDTH-1:0] rd_data,

  output wire full,
  output wire empty
);

wire [ADDR_WIDTH-1:0] wr_bin , wr_gray;
wire [ADDR_WIDTH-1:0] rd_bin , rd_gray;

wire [ADDR_WIDTH-1:0] wr_gray_sync;
wire [ADDR_WIDTH-1:0] rd_gray_sync;


//gray counter instance
gray_counter #(.ADDR_WIDTH(ADDR_WIDTH)) wr_ptr(
  .clk(wr_clk),
  .rst_n(rst_n),
  .en(wr_en && !full),
  .gray_ptr(wr_gray),
  .bin_ptr(wr_bin)
);

gray_counter #(.ADDR_WIDTH(ADDR_WIDTH)) rd_ptr(
  .clk(rd_clk),
  .rst_n(rst_n),
  .en(rd_en && !empty),
  .gray_ptr(rd_gray),
  .bin_ptr(rd_bin)
);

sync_2ff #(.WIDTH(ADDR_WIDTH+1))  sync_wr2rd(
  .clk(rd_clk),
  .rst_n(rst_n),
  .d_in(wr_gray),
  .d_out(wr_gray_sync)
);

sync_2ff #(.WIDTH(ADDR_WIDTH+1))  sync_rd2wr(
  .clk(wr_clk),
  .rst_n(rst_n),
  .d_in(rd_gray),
  .d_out(rd_gray_sync)
);

assign empty =(rd_gray == wr_gray_sync);
assign full =(wr_gray == {~rd_gray_sync[ADDR_WIDTH:ADDR_WIDTH-1],rd_gray_sync[ADDR_WIDTH-2:0]});



fifo_mem #(.DATA_WIDTH(DATA_WIDTH),
.ADDR_WIDTH(ADDR_WIDTH))
mem_inst(
  .wr_clk(wr_clk),
  .rd_clk(rd_clk),
  .wr_en(wr_en && !full), 
  .rd_en(rd_en && !empty),
  .wr_addr(wr_bin[ADDR_WIDTH-1:0]),
  .rd_addr(rd_bin[ADDR_WIDTH-1:0]),
  .wr_data(wr_data),
  .rd_data(rd_data)
);
endmodule