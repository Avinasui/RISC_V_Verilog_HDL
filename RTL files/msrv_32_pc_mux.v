module msrv_32_pc_mux (
  
  input wire rst_in,
  input wire [1:0] pc_src_in,
  input wire [31:0] epic_in,
  input wire [31:0]  trap_address_in,
  input wire branch_taken_in,
  input wire [31:1] iaddr_in,
  input wire  ahb_ready_in,
  input wire [31:0] pc_in,

  output reg [31:0] imaddr_out,
  output reg [31:0] pc_mux_out,
  output reg [31:0] pc_plus_4_out,
  output reg  misaligned_instr_logic_out
);


  // PC_MUX logic
  reg [31:0] concat;
  reg [31:0] next_pc;
  
  
  always @(*) begin
    concat={iaddr_in[31:1],1'b0};
    pc_plus_4_out=pc_in+32'h00000004;
  
  if (branch_taken_in) begin
    next_pc=concat;
  end

  else begin
    next_pc=pc_plus_4_out;
  end

  case(pc_src_in) 
         
      2'b00: pc_mux_out=32'h00000000;
      2'b01: pc_mux_out=epic_in;
      2'b10: pc_mux_out=trap_address_in;
      2'b11: pc_mux_out=next_pc; 
      default pc_mux_out=next_pc;
   endcase 

   misaligned_instr_logic_out=branch_taken_in & next_pc[1];

    if (rst_in) begin
      imaddr_out <= 32'h0; 
     end

    else if (ahb_ready_in) begin
      imaddr_out <= pc_mux_out; 
    end

  end

endmodule
