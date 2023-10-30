module msrv_32_instruction_mux(input wire flush_in,
				input wire [31:0] ms_risc32_mp_instr_in,
				output wire [6:0]  opcode_out,
				output wire [2:0]  funct3_out,
				output wire [6:0]  funct7_out,
				output wire [4:0]  rs1addr_out,
				output wire [4:0]  rs2addr_out,
				output wire [4:0]  rdaddr_out,
				output wire [11:0] csr_addr_out,
				output wire [31:7] instr_out);
reg [31:0] instr_mux;

always @(*) begin
     instr_mux<= (flush_in) ? 32'h00000013 : (ms_risc32_mp_instr_in);
end
assign opcode_out   = instr_mux[6:0];
assign funct3_out   = instr_mux[14:12];
assign funct7_out   = instr_mux[31:25];
assign csr_addr_out = instr_mux[31:20];
assign rs1addr_out  = instr_mux[19:15];
assign rs2addr_out  = instr_mux[24:20];
assign rdaddr_out   = instr_mux[11:7];
assign instr_out    = instr_mux[31:7];

endmodule 