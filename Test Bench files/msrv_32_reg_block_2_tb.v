module msrv_32_reg_block_2_tb;

  // Define signals for your module inputs and outputs
  reg ms_risc32_mp_clk_in;
  reg ms_risc32_mp_rst_in;
  reg [4:0] rd_addr_in;
  reg [11:0] csr_addr_in;
  reg [31:0] rs1_in;
  reg [31:0] rs2_in;
  reg [31:0] pc_in;
  reg [31:0] pc_plus_4_in;
  reg branch_taken_in;
  reg [31:0] iaddr_in;
  reg [3:0] alu_opcode_in;
  reg [1:0] load_size_in;
  reg load_unsigned_in;
  reg alu_src_in;
  reg csr_wr_en_in;
  reg rf_wr_en_in;
  reg [2:0] wb_mux_sel_in;
  reg [2:0] csr_op_in;
  reg [31:0] imm_in;

  wire [4:0] rd_addr_reg_out;
  wire [11:0] csr_addr_reg_out;
  wire [31:0] rs1_reg_out;
  wire [31:0] rs2_reg_out;
  wire [31:0] pc_reg_out;
  wire [31:0] pc_plus_4_reg_out;
  wire [31:0] iaddr_out_reg_out;
  wire [3:0] alu_opcode_reg_out;
  wire [1:0] load_size_reg_out;
  wire load_unsigned_reg_out;
  wire alu_src_reg_out;
  wire csr_wr_en_reg_out;
  wire rf_wr_en_reg_out;
  wire [2:0] wb_mux_sel_reg_out;
  wire [2:0] csr_op_reg_out;
  wire [31:0] imm_reg_out;

  // Instantiate the module to be tested
  msrv_32_reg_block_2 dut (
    .ms_risc32_mp_clk_in(ms_risc32_mp_clk_in),
    .ms_risc32_mp_rst_in(ms_risc32_mp_rst_in),
    .rd_addr_in(rd_addr_in),
    .csr_addr_in(csr_addr_in),
    .rs1_in(rs1_in),
    .rs2_in(rs2_in),
    .pc_in(pc_in),
    .pc_plus_4_in(pc_plus_4_in),
    .branch_taken_in(branch_taken_in),
    .iaddr_in(iaddr_in),
    .alu_opcode_in(alu_opcode_in),
    .load_size_in(load_size_in),
    .load_unsigned_in(load_unsigned_in),
    .alu_src_in(alu_src_in),
    .csr_wr_en_in(csr_wr_en_in),
    .rf_wr_en_in(rf_wr_en_in),
    .wb_mux_sel_in(wb_mux_sel_in),
    .csr_op_in(csr_op_in),
    .imm_in(imm_in),
    .rd_addr_reg_out(rd_addr_reg_out),
    .csr_addr_reg_out(csr_addr_reg_out),
    .rs1_reg_out(rs1_reg_out),
    .rs2_reg_out(rs2_reg_out),
    .pc_reg_out(pc_reg_out),
    .pc_plus_4_reg_out(pc_plus_4_reg_out),
    .iaddr_out_reg_out(iaddr_out_reg_out),
    .alu_opcode_reg_out(alu_opcode_reg_out),
    .load_size_reg_out(load_size_reg_out),
    .load_unsigned_reg_out(load_unsigned_reg_out),
    .alu_src_reg_out(alu_src_reg_out),
    .csr_wr_en_reg_out(csr_wr_en_reg_out),
    .rf_wr_en_reg_out(rf_wr_en_reg_out),
    .wb_mux_sel_reg_out(wb_mux_sel_reg_out),
    .csr_op_reg_out(csr_op_reg_out),
    .imm_reg_out(imm_reg_out)
  );

  // Initialize the testbench clock

 
  always 
    #5 ms_risc32_mp_clk_in = ~ms_risc32_mp_clk_in; // Toggle clock every 5 time units
  

  // Reset and initialize inputs
  initial begin
    ms_risc32_mp_clk_in = 0;
    ms_risc32_mp_rst_in = 1;
    

    // Initialize your inputs here
    rd_addr_in = 5'b10100;        // Example rd_addr input
    csr_addr_in = 12'hABC;        // Example csr_addr input
    rs1_in = 32'h12345678;        // Example rs1 input
    rs2_in = 32'h87654321;        // Example rs2 input
    pc_in = 32'h80000000;         // Example pc input
    pc_plus_4_in = 32'h80000004;  // Example pc_plus_4 input
    branch_taken_in = 1'b1;      // Example branch_taken input
    iaddr_in = 32'hAABBCCDD;     // Example iaddr input
    alu_opcode_in = 4'b1100;     // Example alu_opcode input
    load_size_in = 2'b11;        // Example load_size input
    load_unsigned_in = 1'b1;     // Example load_unsigned input
    alu_src_in = 1'b0;           // Example alu_src input
    csr_wr_en_in = 1'b1;         // Example csr_wr_en input
    rf_wr_en_in = 1'b0;          // Example rf_wr_en input
    wb_mux_sel_in = 3'b010;      // Example wb_mux_sel input
    csr_op_in = 3'b101;          // Example csr_op input
    imm_in = 32'hFEDCBA98;       // Example imm input

    // De-assert reset
    #10 ms_risc32_mp_rst_in = 0;
    #100
    ms_risc32_mp_rst_in = 1;
    ms_risc32_mp_clk_in = 0;
    rd_addr_in = 5'b10101;        // Example rd_addr input
    csr_addr_in = 12'h1BC;        // Example csr_addr input
    rs1_in = 32'h12345456;        // Example rs1 input
    rs2_in = 32'h87654325;        // Example rs2 input
    pc_in = 32'h80000022;         // Example pc input
    pc_plus_4_in = 32'h80000224;  // Example pc_plus_4 input
    branch_taken_in = 1'b0;      // Example branch_taken input
    iaddr_in = 32'hAABBC45D;     // Example iaddr input
    alu_opcode_in = 4'b1111;     // Example alu_opcode input
    load_size_in = 2'b11;        // Example load_size input
    load_unsigned_in = 1'b1;     // Example load_unsigned input
    alu_src_in = 1'b0;           // Example alu_src input
    csr_wr_en_in = 1'b1;         // Example csr_wr_en input
    rf_wr_en_in = 1'b1;          // Example rf_wr_en input
    wb_mux_sel_in = 3'b110;      // Example wb_mux_sel input
    csr_op_in = 3'b100;          // Example csr_op input
    imm_in = 32'hFEDC6A98;  

    #10 ms_risc32_mp_rst_in = 0;
    #100
    
    // Continue with other test scenarios

    // Finish simulation
     $finish;
  end
endmodule

