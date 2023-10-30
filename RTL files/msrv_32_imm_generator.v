module msrv_32_imm_generator(input wire [31:7] instr_in, 
                          input wire [2:0] imm_type_in,
                          output reg [31:0] imm_out);


reg [31:0]concat_i;
reg [31:0]concat_s;
reg [31:0]concat_b;
reg [31:0]concat_u;
reg [31:0]concat_j;
reg [31:0]concat_csr;

always @(*) begin 
concat_i={{20{instr_in[31]}},instr_in[31:20]};
concat_s={{20{instr_in[31]}},instr_in[31:25],instr_in[11:7]};
concat_b={{20{instr_in[31]}},instr_in[7],instr_in[30:25],instr_in[11:8],1'b0};
concat_u={instr_in[31:12],12'h000};
concat_j={{12{instr_in[31]}},instr_in[19:12],instr_in[20],instr_in[30:21],1'b0};
concat_csr={27'b0,instr_in[19:15]};

case(imm_type_in)
   3'b000 : imm_out= concat_i;
   3'b001 : imm_out= concat_i;
   3'b010 : imm_out= concat_s;
   3'b011 : imm_out= concat_b;
   3'b100 : imm_out= concat_u;
   3'b101 : imm_out= concat_j;
   3'b110 : imm_out= concat_csr;
   3'b111 : imm_out= concat_i;
endcase

end
endmodule
