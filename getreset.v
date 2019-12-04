module getreset(
	input reset,
	output ready
);

always @(negedge reset) ready = 1;

endmodule
