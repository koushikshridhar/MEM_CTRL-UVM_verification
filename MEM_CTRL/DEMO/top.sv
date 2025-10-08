module top;

initial begin
	mc_common::flag = 1;
	$display("flag = %0d", mc_common::flag);
end
endmodule
