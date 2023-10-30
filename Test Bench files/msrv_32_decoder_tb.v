module msrv_32_decoder_tb;
  reg trap_taken_in;
  reg [4:0] funct7_5_in;
  reg [6:0] opcode_in;
  reg [2:0] funct3_in;
  reg [1:0] iadder_out_1_to_0_in;

  wire [2:0] wb_mux_sel_out;
  wire [2:0] imm_type_out;
  wire [2:0] csr_op_out;
  wire mem_wr_reg_out;
  wire [3:0] alu_opcode_out;
  wire [1:0] load_size_out;
  wire load_unsigned_out;
  wire alu_src_out;
  wire iadder_src_out;
  wire csr_wr_en_out;
  wire rf_wr_en_out;
  wire illegal_instr_out;
  wire misaligned_load_out;
  wire misaligned_store_out;

  // Instantiate the msrv_32_decoder module
  msrv_32_decoder uut (
    .trap_taken_in(trap_taken_in),
    .funct7_5_in(funct7_5_in),
    .opcode_in(opcode_in),
    .funct3_in(funct3_in),
    .iadder_out_1_to_0_in(iadder_out_1_to_0_in),
    .wb_mux_sel_out(wb_mux_sel_out),
    .imm_type_out(imm_type_out),
    .csr_op_out(csr_op_out),
    .mem_wr_reg_out(mem_wr_reg_out),
    .alu_opcode_out(alu_opcode_out),
    .load_size_out(load_size_out),
    .load_unsigned_out(load_unsigned_out),
    .alu_src_out(alu_src_out),
    .iadder_src_out(iadder_src_out),
    .csr_wr_en_out(csr_wr_en_out),
    .rf_wr_en_out(rf_wr_en_out),
    .illegal_instr_out(illegal_instr_out),
    .misaligned_load_out(misaligned_load_out),
    .misaligned_store_out(misaligned_store_out)
  );

  initial begin
    // Initialize inputs
    trap_taken_in = 0;
    funct7_5_in = 1;
    opcode_in = 7'b0110011;  // Example opcode (R-type instruction)
    funct3_in = 3'b000;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;  // Example iadder_out_1_to_0

    // Add more test vectors and assignments here

    // Add stimulus for other inputs

    // Simulate for a while
    #10;
     trap_taken_in = 0;
    funct7_5_in = 0;
    opcode_in = 7'b0010011;  // Example opcode (R-type instruction)
    funct3_in = 3'b000;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;
#10
    trap_taken_in = 0;
    funct7_5_in = 0;
    opcode_in = 7'b0010011;  // Example opcode (R-type instruction)
    funct3_in = 3'b010;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;
#10
    trap_taken_in = 0;
    funct7_5_in = 0;
    opcode_in = 7'b0010011;  // Example opcode (R-type instruction)
    funct3_in = 3'b111;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;
#10
    trap_taken_in = 0;
    funct7_5_in = 0;
    opcode_in = 7'b1110011;  // Example opcode (R-type instruction)
    funct3_in = 3'b111;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;
#10

    trap_taken_in = 0;
    funct7_5_in = 0;
    opcode_in = 7'b1101100;  // Example opcode (R-type instruction)
    funct3_in = 3'b111;      // Example funct3
    iadder_out_1_to_0_in = 2'b00;
#10
    // Display the results
    $display("wb_mux_sel_out: %b", wb_mux_sel_out);
    $display("imm_type_out: %b", imm_type_out);
    $display("csr_op_out: %b", csr_op_out);
    $display("mem_wr_reg_out: %b", mem_wr_reg_out);
    $display("alu_opcode_out: %b", alu_opcode_out);
    $display("load_size_out: %b", load_size_out);
    $display("load_unsigned_out: %b", load_unsigned_out);
    $display("alu_src_out: %b", alu_src_out);
    $display("iadder_src_out: %b", iadder_src_out);
    $display("csr_wr_en_out: %b", csr_wr_en_out);
    $display("rf_wr_en_out: %b", rf_wr_en_out);
    $display("illegal_instr_out: %b", illegal_instr_out);
    $display("misaligned_load_out: %b", misaligned_load_out);
    $display("misaligned_store_out: %b", misaligned_store_out);

    // End simulation
    $finish;
  end

endmodule

