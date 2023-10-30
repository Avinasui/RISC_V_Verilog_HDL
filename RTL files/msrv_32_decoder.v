
module msrv_32_decoder( input trap_taken_in,
		        input funct7_5_in,
		        input wire [6:0] opcode_in,
		        input wire [2:0] funct3_in,
		        input wire [1:0] iadder_out_1_to_0_in,

			output reg [2:0]wb_mux_sel_out,
			output reg [2:0]imm_type_out,
			output reg [2:0]csr_op_out,
			output reg mem_wr_req_out,
			output reg [3:0]alu_opcode_out,
			output reg [1:0]load_size_out,
			output reg load_unsigned_out,
			output reg alu_src_out,
			output reg iadder_src_out,
			output reg csr_wr_en_out,
			output reg rf_wr_en_out,
			output reg illegal_instr_out,
			output reg misaligned_load_out,
			output reg misaligned_store_out);

reg      is_branch,
          is_jal,
	  is_jalr,
          is_auipc,
	  is_lui,
	  is_op,
 	  is_op_imm,
   	  is_load,
	  is_store,
	  is_system,
	  is_misc_mem;

wire is_addi;
wire is_slti;
wire is_sltiu;
wire is_andi;
wire is_ori;
wire is_xori;

reg  is_implemented_instr;
wire is_csr;
wire mal_word,mal_half;

assign mal_word = (funct3_in == 3'b001) & (iadder_out_1_to_0_in   != 2'b00); 
assign mal_half = (funct3_in == 3'b010) & (iadder_out_1_to_0_in   != 1'b0); 

always @(*) begin
case(opcode_in[6:2])
    5'b11000:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b10000000000;
    5'b11011:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b01000000000;
    5'b11001:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b00100000000;
    5'b00101:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b00010000000;
    5'b01101:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b00001000000;
    5'b01100:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b00000100000;
    5'b00100:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b00000010000;
    5'b00000:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b00000001000;
    5'b01000:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b00000000100;
    5'b11100:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b00000000010;
    5'b00011:   {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b00000000001;
    default:    {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} <= 11'b00000000000;
  endcase
end

assign is_addi  = (is_op_imm && (funct3_in == 3'b000));
assign is_slti  = (is_op_imm && (funct3_in == 3'b010));
assign is_sltiu = (is_op_imm && (funct3_in == 3'b100));
assign is_andi  = (is_op_imm && (funct3_in == 3'b101));
assign is_ori   = (is_op_imm && (funct3_in == 3'b110));
assign is_xori  = (is_op_imm && (funct3_in == 3'b111));
assign is_csr    = is_system &(funct3_in[2] | funct3_in[1] | funct3_in[0] ); 


always@(*) begin

  case (opcode_in)
    7'b0110011: is_implemented_instr <= 1'b1;  // R-type instruction
    7'b0010011: is_implemented_instr <= 1'b1;  // I-type instruction
    7'b0000011: is_implemented_instr <= 1'b1;  // I-type instruction
    7'b0100011: is_implemented_instr <= 1'b1;  // I-type instruction
    7'b1100011: is_implemented_instr <= 1'b1;  // S-type instruction
    7'b1101111: is_implemented_instr <= 1'b1;  // U-type instruction
    7'b1100111: is_implemented_instr <= 1'b1;  // UJ-type instruction
    7'b0110111: is_implemented_instr <= 1'b1;
    7'b0010111: is_implemented_instr <= 1'b1;
    7'b1110011: is_implemented_instr <= 1'b1;
    default: is_implemented_instr <= 1'b0;  // Set to zero for invalid opcodes
  endcase

alu_opcode_out[2:0] <= funct3_in;
alu_opcode_out[3]   <= funct7_5_in & ~((is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori));
load_size_out       <=funct3_in[1:0];
load_unsigned_out   <=funct3_in[2];
alu_src_out         <=opcode_in[5];
iadder_src_out      <=(is_load | is_store | is_jalr);

csr_wr_en_out       <= is_csr; 
rf_wr_en_out        <= (is_lui | is_auipc | is_jalr | is_jal | is_op | is_load | is_csr | is_op_imm);

wb_mux_sel_out [0]  <= (is_load | is_auipc | is_jal | is_jalr);
wb_mux_sel_out [1]  <= (is_lui | is_auipc);
wb_mux_sel_out [2]  <= (is_csr | is_jal | is_jalr);

imm_type_out [0]    <= (is_op_imm | is_load | is_jalr | is_branch | is_jal);
imm_type_out [1]    <= (is_store | is_branch | is_csr);
imm_type_out [2]    <= (is_lui | is_auipc | is_jal | is_csr);

csr_op_out          <=funct3_in;

misaligned_load_out  <= (mal_word | mal_half) & is_load;
misaligned_store_out <= (mal_word | mal_half) & is_store;
mem_wr_req_out       <= is_store & (!trap_taken_in & !mal_word & !mal_half);

illegal_instr_out    <= ((!opcode_in[1]) | (!opcode_in[0]) | (!is_implemented_instr));

end
endmodule 
