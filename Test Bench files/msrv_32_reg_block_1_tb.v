
module at;
// Inputs
reg clk;
reg rst;
  reg [1:0] pc_src_in;
  reg [31:0] epic_in;
  reg [31:0] trap_address_in;
  reg branch_taken_in;
  reg [31:0] iaddr_in;
  reg ahb_ready_in;
  reg [31:0] pc_in;

  // Outputs
  wire [31:0] iaddr_out;
  wire [31:0] pc_plus_4_out;
  wire misaligned_instr_logic_out;
  wire [31:0] pc_mux_out;
// Outputs
  wire [31:0] pc_out;
// Instantiate the DUT
msrv_32_reg_block_1 DUT (.ms_risc32_mp_clk_in(clk),
.ms_risc32_mp_rst_in(rst),.pc_out(pc_out));

  msrv_32_pc_mux U1 (
     .rst_in(rst),
    .pc_src_in(pc_src_in),
    .epic_in(epic_in),
    .trap_address_in(trap_address_in),
    .branch_taken_in(branch_taken_in),
    .iaddr_in(iaddr_in),
    .ahb_ready_in(ahb_ready_in),
    .pc_in(pc_out),
    .iaddr_out(iaddr_out),
    .pc_plus_4_out(pc_plus_4_out),
    .misaligned_instr_logic_out(misaligned_instr_logic_out),
    .pc_mux_out(pc_mux_in)
  );

// Clock generation
always #5 clk = ~clk;

initial begin
// Initialize inputs
clk = 0;
rst = 1;


// Apply reset
#10 rst = 0;

// Check reset value
          pc_src_in = 2'b11;
          epic_in = 32'hAABBCCDD;
          trap_address_in = 32'h11223344;
          branch_taken_in = 0;
          iaddr_in = 32'h11223344;
          ahb_ready_in = 1;
          #10
          pc_src_in = 2'b11;
          epic_in = 32'hAABBCCDD;
          trap_address_in = 32'h11223344;
          branch_taken_in = 1;
          iaddr_in = 32'h11223344;
          ahb_ready_in = 1;
         #10
          pc_src_in = 2'b01;
          epic_in = 32'hAABBCCDD;
          trap_address_in = 32'h11223344;
          branch_taken_in = 1;
          iaddr_in = 32'h11223344;
          ahb_ready_in = 1;
         #10
          pc_src_in = 2'b00;
          epic_in = 32'hAABBCCDD;
          trap_address_in = 32'h11223344;
          branch_taken_in = 1;
          iaddr_in = 32'h11223344;
          ahb_ready_in = 1;
         #10
           
// Simulate other cycles
#20 $finish;
end
// Monitor outputs
always @(posedge clk) begin
$display("pc_out = %h", pc_out);
end
endmodule 
