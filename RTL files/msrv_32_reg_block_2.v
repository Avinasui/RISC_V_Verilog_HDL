module msrv_32_reg_block_2(input wire  ms_risc32_mp_clk_in,
  input wire  ms_risc32_mp_rst_in,
  input wire[4:0] rd_addr_in,
  input wire[11:0] csr_addr_in,
  input wire signed [31:0] rs1_in,
  input wire signed [31:0] rs2_in,
  input wire[31:0] pc_in,
  input wire[31:0] pc_plus_4_in,
  input wire branch_taken_in,
  input wire[31:0] iaddr_in,
  input wire[3:0]  alu_opcode_in,
  input wire[1:0]  load_size_in,
  input wire load_unsigned_in,
  input wire alu_src_in,
  input wire csr_wr_en_in,
  input wire rf_wr_en_in,
  input wire [2:0]  wb_mux_sel_in,
  input wire [2:0]  csr_op_in,
  input wire signed [31:0] imm_in,
  
  output reg[4:0] rd_addr_reg_out,
  output reg[11:0] csr_addr_reg_out,
  output reg signed [31:0] rs1_reg_out,
  output reg[31:0] rs2_reg_out,
  output reg[31:0] pc_reg_out,
  output reg[31:0] pc_plus_4_reg_out,
  
  output reg[31:0] iaddr_out_reg_out,
  output reg[3:0]  alu_opcode_reg_out,
  output reg[1:0]  load_size_reg_out,
  output reg load_unsigned_reg_out,
  output reg alu_src_reg_out,
  output reg csr_wr_en_reg_out,
  output reg rf_wr_en_reg_out,
  output reg [2:0]  wb_mux_sel_reg_out,
  output reg [2:0]  csr_op_reg_out,
  output reg [31:0] imm_reg_out
  );

always @(posedge ms_risc32_mp_clk_in or posedge ms_risc32_mp_rst_in ) begin
if (ms_risc32_mp_rst_in) begin
        rd_addr_reg_out   <= 0;
        csr_addr_reg_out  <= 0;
        rs1_reg_out       <= 0;
        rs2_reg_out	  <= 0;
        pc_reg_out	  <= 0;
        pc_plus_4_reg_out <= 0;
  
        iaddr_out_reg_out <= 0;
        alu_opcode_reg_out<= 0;
        load_size_reg_out <= 0;
        load_unsigned_reg_out<=0;
        alu_src_reg_out   <= 0;
        csr_wr_en_reg_out <= 0;
        rf_wr_en_reg_out  <= 0;
        wb_mux_sel_reg_out<= 0;
   	csr_op_reg_out    <= 0;
	imm_reg_out       <= 0;
end

else begin  
	rd_addr_reg_out   <= rd_addr_in;
        csr_addr_reg_out  <= csr_addr_in;
        rs1_reg_out       <= rs1_in;
        rs2_reg_out	  <= rs2_in;
        pc_reg_out	  <= pc_in;
        pc_plus_4_reg_out <= pc_plus_4_in;
  
        iaddr_out_reg_out <= iaddr_in;
        alu_opcode_reg_out<= alu_opcode_in;
        load_size_reg_out <= load_size_in;
        load_unsigned_reg_out<=load_unsigned_in;
        alu_src_reg_out   <= alu_src_in;
        csr_wr_en_reg_out <= csr_wr_en_in;
        rf_wr_en_reg_out  <= rf_wr_en_in;
        wb_mux_sel_reg_out<= wb_mux_sel_in;
   	csr_op_reg_out    <= csr_op_in;
	imm_reg_out       <= imm_in;
        case(branch_taken_in)
        1'b1 : iaddr_out_reg_out<=1'b0;
        1'b0 : iaddr_out_reg_out<= iaddr_in[0];
        endcase
end
end 
endmodule

