module getkey(
	input [3:0] atual,
	input ready,
	output [3:0] tecla
);


logic [3:0] passado;

always @(*) begin
		if (ready) tecla = atual;
		else;
end

endmodule
