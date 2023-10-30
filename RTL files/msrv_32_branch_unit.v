module msrv_32_branch_unit(input wire [31:0] rs1_in,
		   input wire [31:0] rs2_in,
		   input wire[6:2] opcode_6_to_2_in,
		   input wire [2:0]funct3_in,
		   output reg branch_taken_out);
parameter brn=5'b110_00,
	  jal=5'b110_11,
	  jalr=5'b110_01;
always@(*)
begin
case(opcode_6_to_2_in)
brn:begin
	case(funct3_in)

         3'b000:branch_taken_out=(rs1_in == rs2_in);
         3'b001:branch_taken_out=(rs1_in != rs2_in);
         3'b100:branch_taken_out=($signed(rs1_in)   <  $signed(rs2_in));
         3'b101:branch_taken_out=($signed(rs1_in)   >= $signed(rs2_in));
         3'b110:branch_taken_out=($unsigned(rs1_in) <  $unsigned(rs2_in));
         3'b111:branch_taken_out=($unsigned(rs1_in) >= $unsigned (rs2_in));
         default: branch_taken_out=1'b0;
         endcase
	 end
jal: branch_taken_out=1'b1;
jalr:branch_taken_out=1'b1;
default: branch_taken_out=1'b0;
endcase
end	

endmodule 
