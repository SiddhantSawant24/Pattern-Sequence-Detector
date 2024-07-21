`include "mealey.v"
module tb;

parameter S_R=4'b0001;
parameter S_B=4'b0010;
parameter S_BC=4'b0100;
parameter S_BCB=4'b1000;

reg clk_i,clr_i,input_i,valid_i;
wire out;

wire[3:0] present_state;
wire[3:0] next_state;

integer count;

mealey dut (.*);

always #5 clk_i=~clk_i;

task reset();
	begin
	repeat(2)@(posedge clk_i);
	input_i=0;
	valid_i=0;
	end
endtask

task in();
	begin
		repeat(50) begin
		@(posedge clk_i);  //at every posedge clock send one bit as input
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


@(posedge clk_i);
reset();

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
	


