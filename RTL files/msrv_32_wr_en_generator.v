module msrv_32_wr_en_generator(
	input wire flush_in,
	input wire rf_wr_en_reg_in,
	input wire csr_wr_en_reg_in,
	output wire wr_en_integer_file_out,
	output wire wr_en_csr_file_out);

assign wr_en_integer_file_out = (flush_in) ? 0 : rf_wr_en_reg_in;
assign wr_en_csr_file_out     = (flush_in) ? 0 : csr_wr_en_reg_in;
endmodule
