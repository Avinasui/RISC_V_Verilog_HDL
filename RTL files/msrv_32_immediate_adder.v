module msrv_32_immediate_adder(input wire [31:0] rs_1_in,
        		       input wire iadder_src_in,
                               input wire [31:0] imm_in,
			       input wire [31:0]pc_in,
			       output reg [31:0] iadder_out);


reg [31:0] sel;

always @(*) begin

if(iadder_src_in==1) begin
    sel=rs_1_in ;
end
else if (iadder_src_in==0)begin
    sel=pc_in;
end
iadder_out<=sel+imm_in;
end
endmodule 