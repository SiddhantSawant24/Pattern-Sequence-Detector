module moore(clk_i,clr_i,input_i,valid_i,out);
parameter S_R=5'b00001;
parameter S_B=5'b00010;
parameter S_BC=5'b00100;
parameter S_BCB=5'b01000;
parameter S_BCBB=5'b10000;

input clk_i,clr_i,input_i,valid_i;
output reg out;

reg[4:0] present_state;
reg[4:0] next_state;

always @(posedge clk_i)begin
	if (clr_i)begin
		out=0;
		present_state=S_R;
		next_state=S_R;
	end

	else begin
		if (valid_i)begin
			case (present_state)
				S_R:begin
				out=0;
					if (input_i) begin
						next_state=S_B;
					end
					
					else begin
						next_state=S_R;
					end
				end

				S_B:begin
				out=0;
					if(input_i) begin
						next_state=S_B;
					end

					else begin
						next_state=S_BC;
					end
				end

				S_BC:begin
				out=0;
					if(input_i) begin
						next_state=S_BCB;
					end

					else begin
						next_state=S_R;
					end
				end

				S_BCB:begin
				out=0;
					if(input_i) begin
						next_state=S_BCBB;
					end

					else begin
						next_state=S_R;
					end
				end

				S_BCBB:begin
				out=1;
					if(input_i) begin
						next_state=S_B;
					end

					else begin
						next_state=S_R;
					end
				end
			endcase
		end
	end
end

always @(next_state)begin
present_state=next_state;
end
endmodule



						


