module concat(
	input [7:0] A,
	input [7:0] B,
	output [15:0] S
);

assign S = {A, B};
endmodule
