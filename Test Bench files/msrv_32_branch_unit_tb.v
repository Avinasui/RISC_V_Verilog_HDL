module msrv_32_branch_unit_tb;
  reg [31:0] rs1_in, rs2_in;
  reg [6:2] opcode_6_to_2_in;
  reg [2:0] funct3_in;
  wire branch_taken_out;
  
  // Instantiate the module under test
  msrv_32_branch_unit uut (
    .rs1_in(rs1_in),
    .rs2_in(rs2_in),
    .opcode_6_to_2_in(opcode_6_to_2_in),
    .funct3_in(funct3_in),
    .branch_taken_out(branch_taken_out)
  );

  // Clock generation
  reg clk = 0;
  always #5 clk = ~clk;

  // Test case 1
  initial begin
    // Initialize inputs
    rs1_in = 3;        // Modify inputs as needed
    rs2_in = 5;
    opcode_6_to_2_in = 5'b110_11; // brn
    funct3_in = 3'b100; // Signed less than

    // Apply inputs
    #10; // Wait for a few clock cycles
    rs1_in = 5;        // Modify inputs as needed
    rs2_in = 5;
    opcode_6_to_2_in = 5'b110_00; // brn
    funct3_in = 3'b100; // Signed less than

    #10; // Wait for a few clock cycles
    rs1_in = 5;        // Modify inputs as needed
    rs2_in = 5;
    opcode_6_to_2_in = 5'b110_00; // brn
    funct3_in = 3'b000; // Signed less than

    // Apply inputs
    #10; // Wait for a few clock cycles
    rs1_in = 5;        // Modify inputs as needed
    rs2_in = 5;
    opcode_6_to_2_in = 5'b110_11;
    funct3_in = 3'b000;
   
    #10; // Wait for a few clock cycles
    rs1_in = 5;        // Modify inputs as needed
    rs2_in = 5;
    opcode_6_to_2_in = 5'b110_11;
    funct3_in = 3'b000;
   
    #10; // Wait for a few clock cycles
     rs1_in = 5;        // Modify inputs as needed
     rs2_in = 5;
     opcode_6_to_2_in = 5'b110_01;
    funct3_in = 3'b000;
    // Check the output
    if (branch_taken_out == 1'b1) begin
      $display("Test case 1 PASSED");
    end else begin
      $display("Test case 1 FAILED");
    end

    // Add more test cases as needed

    $finish; // Finish simulation
  end

endmodule

