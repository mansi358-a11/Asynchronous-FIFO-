module tb_async_fifo;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    reg wr_clk, rd_clk, rst_n;
    reg wr_en, rd_en;
    reg [DATA_WIDTH-1:0] wr_data;
    wire [DATA_WIDTH-1:0] rd_data;
    wire full, empty;

    // DUT
    async_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .wr_clk (wr_clk),
        .rd_clk (rd_clk),
        .rst_n  (rst_n),
        .wr_en  (wr_en),
        .rd_en  (rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .full   (full),
        .empty  (empty)
    );

    // WRITE CLOCK (fast)
    always #5 wr_clk = ~wr_clk;   // 100 MHz

    // READ CLOCK (slow)
    always #12 rd_clk = ~rd_clk;  // ~40 MHz

    initial begin
        wr_clk = 0;
        rd_clk = 0;
        rst_n  = 0;
        wr_en  = 0;
        rd_en  = 0;
        wr_data = 0;

        #20 rst_n = 1;

        // WRITE PHASE
        repeat (10) begin
            @(posedge wr_clk);
            if (!full) begin
                wr_en   = 1;
                wr_data = wr_data + 1;
            end
        end
        wr_en = 0;

        // READ PHASE
        repeat (10) begin
            @(posedge rd_clk);
            if (!empty)
                rd_en = 1;
        end
        rd_en = 0;

        #100 $finish;
    end

    initial begin
        $dumpfile("async_fifo.vcd");
        $dumpvars(0, tb_async_fifo);
    end

endmodule
