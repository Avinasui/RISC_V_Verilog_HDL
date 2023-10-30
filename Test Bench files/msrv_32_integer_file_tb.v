`timescale 1ns / 1ps

module msrv_32_integer_file_tb;

  // Inputs
  reg ms_risc32_mp_clk_in;
  reg ms_risc32_mp_rst_in;
  reg [4:0] rs_1_addr_in;
  reg [4:0] rs_2_addr_in;
  reg [4:0] rd_addr_in;
  reg [31:0] rd_in;
  reg wr_en_in;

  // Outputs
  wire [31:0] rs_1_out;
  wire [31:0] rs_2_out;

  // Instantiate the module under test
  msrv_32_integer_file uut (
    .ms_risc32_mp_clk_in(ms_risc32_mp_clk_in),
    .ms_risc32_mp_rst_in(ms_risc32_mp_rst_in),
    .rs_1_addr_in(rs_1_addr_in),
    .rs_2_addr_in(rs_2_addr_in),
    .rd_addr_in(rd_addr_in),
    .rd_in(rd_in),
    .wr_en_in(wr_en_in),
    .rs_1_out(rs_1_out),
    .rs_2_out(rs_2_out)
  );

  // Clock generation
  always begin
    ms_risc32_mp_clk_in = 0;
    #5;
    ms_risc32_mp_clk_in = 1;
    #5;
  end

  // Stimulus generation
  initial begin
    ms_risc32_mp_rst_in = 1; // Reset active
    wr_en_in = 0;
    rd_addr_in = 0;
    rs_1_addr_in = 0;
    rs_2_addr_in = 0;
    rd_in = 0;
    #10;

    ms_risc32_mp_rst_in = 0; // Release reset

    // Test Write Operation
    wr_en_in = 1;
    rd_addr_in = 1;
    rd_in = 15;
    #10;

    // Test Read Operations
    wr_en_in = 0;
    rs_1_addr_in = 2;
    rs_2_addr_in = 1;
    #10;

    // Add more test cases as needed...

    // End simulation
    $finish;
  end

  // Monitor and display results
  always @(posedge ms_risc32_mp_clk_in) begin
    $display("Time=%t: rs_1_out=%h, rs_2_out=%h", $time, rs_1_out, rs_2_out);
  end

endmodule

