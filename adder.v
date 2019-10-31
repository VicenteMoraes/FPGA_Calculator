module somador (
		input subtract,
		input 	[7:0] A,
		input  	[7:0] B,
		output 	[7:0] S,
		output Overflow);

logic Cout; 
logic [7:0] C;
assign C = (subtract ? ~B+1 : B);
assign {Cout, S} = A + C;
assign Overflow = ((C[7] == 1 && A[7] == 1) ? !S[7] : ((C[7] == 0 && A[7] == 0) ? S[7] : 0));

endmodule
