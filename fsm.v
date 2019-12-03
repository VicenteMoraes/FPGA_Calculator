module fsm(
	input [3:0] tecla,
	input [7:0] regload,
	input [7:0] calcresult,
	input reset,
	input overflow,
	input ready,
	output [3:0] regadress,
	output [7:0] A,
	output [7:0] B,
	output regwrite,
	output ok,
	output key,
	output subtract,
	output [7:0] regstore
);

always @(*) 
begin
	if (reset)
	begin
		A = {7{1'b0}};
		B = {7{1'b0}};
		key = 1;
	end
	else if (overflow)
	begin
		ok = 0;
		key = 1;
	end
	else
	begin
		key = 0;
		ok = 1;
		regwrite = 0;
		case (tecla)
			4'b0000 : B = 7'b0000000; 
			4'b0001 : B = 7'b0000001;
			4'b0010 : B = 7'b0000010; 
			4'b0011 : B = 7'b0000011; 
			4'b0100 : B = 7'b0000100; 
			4'b0101 : B = 7'b0000101; 
			4'b0110 : B = 7'b0010110; 
			4'b0111 : B = 7'b0000111; 
			4'b1000 : B = 7'b0011000; 
			4'b1001 : B = 7'b0001001;
			
			// Sum operation:
			4'b1010 : begin
				key = 1;
				B = calcresult;
				A = {7{1'b0}};
			end
			
			// Subtract operation
			4'b1011 : begin
				subtract = 1;
				key = 1;
				B = calcresult;
				A = {7{1'b0}};
			end
			
			// Store operation
			4'b1100 : begin
				if (B > 9) begin
					A = 7'b0111111;
					B = 7'b0111111;
					key = 1;
				end
				else begin
					regadress = B;
					regstore = A;
					regwrite = 1;
				end
			end
			
			// Load operation
			4'b1101 : begin
				if (B > 9) begin
					A = 7'b0111111;
					B = 7'b0111111;
					key = 1;
				end
				else begin
					regadress = B;
					B = regload;
				end
			end
			
			// Enter operation (copies queue[0] - B into queue[1] - A)
			4'b1110 : begin
				A = B;
			end
			4'b1111 : ok = 1; 
			default: ok = 0;
		endcase
	end
end
endmodule
