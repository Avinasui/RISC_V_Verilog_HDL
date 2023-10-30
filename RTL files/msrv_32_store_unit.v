module msrv_32_store_unit(
  input wire [1:0] funct3_in,
  input wire [31:0] iaddr_in,
  input wire [31:0] rs2_in,
  input wire ahb_ready_in,
  input wire mem_wr_req_in,


  
  output reg [31:0] ms_riscv32_mp_dmdata_out,
  output reg [31:0] ms_riscv32_mp_dmadder_out,
  output reg [3:0]  ms_riscv32_mp_dmwr_mask_out,
  output reg ms_riscv32_mp_dmwr_req_out,
  output reg [1:0] ahb_htrans_out
);

  // Data Placement in data_out
  always @(*) begin
    if (ahb_ready_in) begin
      case (funct3_in) 
        2'b00:begin
        	case(iaddr_in[1:0])
        	2'b00: ms_riscv32_mp_dmdata_out = {8'b0, 8'b0, 8'b0, rs2_in[7:0]};
        	2'b01: ms_riscv32_mp_dmdata_out = {8'b0, 8'b0,rs2_in[7:0] ,8'b0};
		2'b10: ms_riscv32_mp_dmdata_out = {8'b0, rs2_in[7:0],8'b0 ,8'b0};
		2'b11: ms_riscv32_mp_dmdata_out = {rs2_in[7:0],8'b0,8'b0 ,8'b0};
        	default: ms_riscv32_mp_dmdata_out = 32'b0;
      		endcase
		end
         2'b01:begin
		case(iaddr_in[1])

          1'b0: ms_riscv32_mp_dmdata_out = {16'b0,rs2_in[15:0]};
        	1'b1: ms_riscv32_mp_dmdata_out = {rs2_in[15:0],16'b0};
                default: ms_riscv32_mp_dmdata_out = 32'b0;
		endcase
		end
         2'b10: ms_riscv32_mp_dmdata_out <=rs2_in;
         2'b11: ms_riscv32_mp_dmdata_out <=rs2_in;
	 default: ms_riscv32_mp_dmdata_out <=32'b0;
endcase 
    end else begin
      ms_riscv32_mp_dmdata_out = 32'b0;
    end
  end

  // Setting wr_mask_out
 
always @(*) begin
  case (funct3_in)
    2'b00: begin
      case (iaddr_in[1:0])
        2'b01: ms_riscv32_mp_dmwr_mask_out = {2'b0, mem_wr_req_in, 1'b0};
        default: ms_riscv32_mp_dmwr_mask_out = 4'b0;
      endcase
    end
    2'b01: begin
      case (iaddr_in[1])
        1'b1: ms_riscv32_mp_dmwr_mask_out = {{2{mem_wr_req_in}}, 2'b0};
        default: ms_riscv32_mp_dmwr_mask_out = 4'b0;
      endcase
    end
    2'b10, 2'b11: ms_riscv32_mp_dmwr_mask_out = {4{mem_wr_req_in}};
    default: ms_riscv32_mp_dmwr_mask_out = 4'b0;
  endcase
end


  // Alignment of dm_adder_out
  always @(*) begin
    ms_riscv32_mp_dmadder_out = {iaddr_in[31:2], 2'b00};
  end

  // Alignment of wr_req_out
  always @(*) begin
    ms_riscv32_mp_dmwr_req_out= mem_wr_req_in; 
  end

  // ah_htrans_out setting
  always @(*) begin
    case(funct3_in)
      2'b00:ahb_htrans_out = 2'b10;
      2'b01:ahb_htrans_out = 2'b10;
      2'b10:ahb_htrans_out = 2'b10;
      default:ahb_htrans_out = 2'b00;
   endcase

  end

endmodule

