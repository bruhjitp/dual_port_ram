module dpr_tb;
parameter width =32;
parameter depth = 1024*8;

reg clk,wr;
reg [7:0] addr0, addr1;
reg [width-1:0] w_in0, w_in1;
wire [width-1:0] r_out0, r_out1;
  
ram_controller rc0(
    .addr0(addr0),
    .addr1(addr1),
    .wr(wr),
    .clk(clk),
    .w_in0(w_in0),
    .w_in1(w_in1),
    .r_out0(r_out0),
    .r_out1(r_out1)
);
  
initial
begin
    clk=1'b0;
    forever #5 clk = ~clk;
end

initial
begin

//add trigger here and use $display to printout ram data

end
  
endmodule
