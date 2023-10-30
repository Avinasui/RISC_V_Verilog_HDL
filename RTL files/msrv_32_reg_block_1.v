module msrv_32_reg_block_1( 
input wire  ms_risc32_mp_clk_in,
input wire  ms_risc32_mp_rst_in,
input wire [31:0] pc_mux_in,
output reg [31:0] pc_out);
 



//msrv_32_pc_mux M1(.rst_in(ms_risc32_mp_rst_in),.pc_in(pc_out),.pc_mux_out(pc_mux_in));

  always @(posedge ms_risc32_mp_clk_in or posedge ms_risc32_mp_rst_in) begin
  
    if (ms_risc32_mp_rst_in) begin
      pc_out <= 32'h00000000;  // Reset pc_out to 32'h00000000 when reset is asserted
    end else begin
      pc_out <= pc_mux_in;     
    end
  end


endmodule
