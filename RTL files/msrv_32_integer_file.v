module msrv_32_integer_file (
  input wire  ms_risc32_mp_clk_in,
  input wire  ms_risc32_mp_rst_in,
  input wire [4:0] rs_1_addr_in,
  input wire [4:0] rs_2_addr_in,
  input wire [4:0] rd_addr_in,
  input wire [31:0] rd_in,
  input wire wr_en_in,
  output wire [31:0] rs_1_out,
  output wire [31:0] rs_2_out
);
  reg signed [31:0] reg_file [31:0]; 
  integer i;
  always @(posedge ms_risc32_mp_clk_in or posedge ms_risc32_mp_rst_in) begin
    
    if (ms_risc32_mp_rst_in) begin
     reg_file[0] <= 32'h00000000;
      // Initialize registers with 0
      for (i = 1; i < 32; i = i + 1) begin
        reg_file[i] <= 32'h00000000;
      end
    end 
    else begin
      // Write operation
      if ((wr_en_in==1)&&(rd_addr_in!=0)) begin
          reg_file[rd_addr_in] <= rd_in;
        end
    end
end
      // Read operation
      assign rs_1_out=((rs_1_addr_in==rd_addr_in)&&(wr_en_in==1)) ? rd_in: reg_file[rs_1_addr_in];
      assign rs_2_out=((rs_2_addr_in==rd_addr_in)&&(wr_en_in==1)) ? rd_in: reg_file[rs_2_addr_in];
endmodule
