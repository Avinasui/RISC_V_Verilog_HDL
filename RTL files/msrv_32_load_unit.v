module msrv_32_load_unit(input wire ahb_resp_in,
			 input wire [31:0]ms_risc32_mp_dmdata_in,
                         input [1:0]iadder_out_1_to_0_in,
			 input load_unsigned_in,
			 input wire [1:0]load_size_in,
			 output reg [31:0] lu_output_out);

wire a,b,c,d;

assign a = load_unsigned_in ? 0 : ms_risc32_mp_dmdata_in[7];
assign b = load_unsigned_in ? 0 : ms_risc32_mp_dmdata_in[15];
assign c = load_unsigned_in ? 0 : ms_risc32_mp_dmdata_in[23];
assign d = load_unsigned_in ? 0 : ms_risc32_mp_dmdata_in[31];

always @* begin

if(!ahb_resp_in)begin
	if(load_size_in==2'b00)begin
           case(iadder_out_1_to_0_in)
		2'b00 : lu_output_out = {{24{a}}, ms_risc32_mp_dmdata_in[7:0]};
		2'b01 : lu_output_out = {{24{b}}, ms_risc32_mp_dmdata_in[15:8]};
		2'b10 : lu_output_out = {{24{c}}, ms_risc32_mp_dmdata_in[23:16]};
		2'b11 : lu_output_out = {{24{d}}, ms_risc32_mp_dmdata_in[31:24]};
	    endcase
        end

	else if(load_size_in==2'b01)begin
	   case(iadder_out_1_to_0_in[1])
		1'b0 : lu_output_out = {{16{b}}, ms_risc32_mp_dmdata_in[15:0]};
		1'b1 : lu_output_out = {{16{d}}, ms_risc32_mp_dmdata_in[31:16]};
	    endcase
	end
  
 	else begin
               lu_output_out = ms_risc32_mp_dmdata_in;
        end
end
end
endmodule

  
