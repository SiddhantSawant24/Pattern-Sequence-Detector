`include "moore.v"
module tb;
parameter S_R=5'b00001;
parameter S_B=5'b00010;
parameter S_BC=5'b00100;
parameter S_BCB=5'b01000;
parameter S_BCBB=5'b10000;

reg clk_i,clr_i,input_i,valid_i;
wire out;

wire[4:0] present_state;
wire[4:0] next_state;

integer count;

moore dut (.*);

always #5 clk_i=~clk_i;

task reset();
	begin
		repeat(2)begin
		@(posedge clk_i);
		input_i=0;
		valid_i=0;
		end
	end
endtask

task in();
	begin
		repeat(50)begin
		@(posedge clk_i)
		valid_i=1;
		input_i=$random();
		end
	end
endtask

initial begin
clk_i=0;
clr_i=1;
count=0;
reset();

clr_i=0;
in();

@(posedge clk_i)begin
valid_i=0;
input_i=0;
end

$display("The number of times the pattern is detected is %d",count);
end

initial begin
#1000;
$finish();
end

always @(posedge out)begin
count=count+1;
end
endmodule



	


