module positive_conv (

	input 	[7:0] A,
 	output 	[7:0] S
);

assign S = ~A+1;

endmodule
