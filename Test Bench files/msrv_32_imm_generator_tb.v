module msrv_32_imm_generator_tb;

  reg [31:7] instr_in;
  reg [2:0] imm_type_in;
  wire [31:0] imm_out;

  // Instantiate the module to be tested
  msrv_32_imm_generator dut (
    .instr_in(instr_in),
    .imm_type_in(imm_type_in),
    .imm_out(imm_out)
  );

  // Clock generation (you can adjust the clock parameters as needed)
  reg clk = 0;
  always begin
    #5 clk = ~clk;
  end

  // Test vectors
  initial begin
    // Test 1: imm_type_in = 000 (concat_i)
    instr_in = 32'h12345678; // Replace with your test instruction
    imm_type_in = 3'b000;
    #10;
    // Check the result
    if (imm_out !== 32'h56781234) $display("Test 1 Failed!");

    // Test 2: imm_type_in = 010 (concat_s)
    instr_in = 32'h9A345678; // Replace with your test instruction
    imm_type_in = 3'b010;
    #10;
    // Check the result
    if (imm_out !== 32'hDE345678) $display("Test 2 Failed!");

    // Add more tests for other immediate types as needed...

    // Test 3: imm_type_in = 111 (concat_i)
    instr_in = 32'hAABBCCDD; // Replace with your test instruction
    imm_type_in = 3'b111;
    #10;
    // Check the result
    if (imm_out !== 32'hDDDDDDDD) $display("Test 3 Failed!");

    // Terminate simulation
    $finish;
  end

endmodule

