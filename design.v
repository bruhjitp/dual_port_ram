module ram_controller#(parameter width = 32, parameter depth=1024*8)(
input clk,wr,//wr=0->w, wr=1->r
input [2:0] addr0, addr1,
input [width-1:0] w_in0, w_in1,
output reg [width-1:0] r_out0, r_out1
);
wire [7:0]temp0,temp1;
decoder3_to_8 d0(addr0,temp0);
decoder3_to_8 d1(addr1,temp1);
dual_port_ram dpr(clk,wr,temp0,temp1,w_in0,w_in1,r_out0,r_out1);
endmodule

module dual_port_ram #(parameter width = 32, parameter depth=1024*8)//1kB RAM
(
  input clk,wr,//wr=0->w, wr=1->r
  input [7:0] addr0, addr1,
  input [width-1:0] w_in0, w_in1,
  output reg [width-1:0] r_out0, r_out1
);
  
  reg [31:0] ram [(depth/width)-1:0];
  
  always@(posedge clk)
  begin
      if(wr==1'b1)
      begin
        ram[addr0]=w_in0;
        ram[addr1]=w_in1;
      end
      else if(wr==1'b0)
      begin
        r_out0=ram[addr0];
        r_out1=ram[addr1];
      end
  end
endmodule

module decoder3_to_8(in,out);
input [2:0]  in;
output reg [7:0] out;

always @(in)
begin
out=8'd0;
case (in)
3'b000: out[0]=1'b1;
3'b001: out[1]=1'b1;
3'b010: out[2]=1'b1;
3'b011: out[3]=1'b1;
3'b100: out[4]=1'b1;
3'b101: out[5]=1'b1;
3'b110: out[6]=1'b1;
3'b111: out[7]=1'b1;
//default: out=8'd0;
endcase
end
endmodule
