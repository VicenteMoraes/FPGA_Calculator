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



always @(negedge ready) 
begin
	subtract = 0;
	key = 0;
	ok = 1;
	regwrite = 0;
	if (!reset)
	begin
		A = 0;
		B = 0;
	end
	else if (overflow)
	begin
		ok = 0;
		key = 1;
	end
	else begin
			case (tecla)
				4'b0000 : B = 8'b00000000; 
				4'b0001 : B = 8'b00000001;
				4'b0010 : B = 8'b00000010; 
				4'b0011 : B = 8'b00000011; 
				4'b0100 : B = 8'b00000100; 
				4'b0101 : B = 8'b00000101; 
				4'b0110 : B = 8'b00000110; 
				4'b0111 : B = 8'b00000111; 
				4'b1000 : B = 8'b00001000; 
				4'b1001 : B = 8'b00001001;
				
				// Sum operation:
				4'b1010 : begin
					key = 1;
					B = calcresult;
					A = 0;
				end
				
				// Subtract operation
				4'b1011 : begin
					logic [7:0] S;
					logic [7:0] C;
					C = ~B + 1;
					S = A + C;
					if ((C[7] == 1 && A[7] == 1) ? !S[7] : ((C[7] == 0 && A[7] == 0) ? S[7] : 0)) begin
						A = 8'b01111111;
						B = 8'b01111111;
						key = 1;
					end
					else begin
						A = 0;
						B = S;
					end
				end
				
				// Store operation
				4'b1100 : begin
					if (B > 9 || B < 0) begin
						A = 8'b01111111;
						B = 8'b01111111;
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
					if (B > 9 || B < 0) begin
						A = 8'b01111111;
						B = 8'b01111111;
						key = 1;
					end
					else begin
						logic [7:0] oldreg;
						oldreg = regload;
						regadress = B;
						wait(oldreg != regload);
						B = regload;
					end
				end
				
				// Enter operation (copies queue[0] - B into queue[1] - A)
				4'b1110 : A = B;
				
				// Does nothing
				4'b1111 : ;
				default: ok = 0;
			endcase
		end
end
endmodule
