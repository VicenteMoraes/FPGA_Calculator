module mux (
	input [7:0] A,
	input [7:0] B,
	output [7:0] S
);

assign S = (B[7] ? A : B);
endmodule
