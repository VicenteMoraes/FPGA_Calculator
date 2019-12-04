module process_led(
	input negativeA,
	input negativeB,
	input negativeD,
	input overflow,
	input [9:0] D,
	input [9:0] A,
	input [9:0] B,
	input key,
	output [6:0] led0,
	output [6:0] led1,
	output [6:0] led2,
	output [6:0] led3,
	output [6:0] led4,
	output [6:0] led5,
	output [6:0] led6,
	output [6:0] led7
);

function automatic [6:0] bcd_to_led;
	input A, B, C, D;
	case ({A, B, C, D})
		 4'b0000 : bcd_to_led = 7'b1000000;
		 4'b0001 : bcd_to_led = 7'b1111001;
		 4'b0010 : bcd_to_led = 7'b0100100;
		 4'b0011 : bcd_to_led = 7'b0110000;
		 4'b0100 : bcd_to_led = 7'b0011001;
		 4'b0101 : bcd_to_led = 7'b0010010;
		 4'b0110 : bcd_to_led = 7'b0000010;
		 4'b0111 : bcd_to_led = 7'b1111000;
		 4'b1000 : bcd_to_led = 7'b0000000;
		 4'b1001 : bcd_to_led = 7'b0011000;
		 default : bcd_to_led = {7'b1001111, 7'b0000101, 7'b0000101, 7'b0011101};
		endcase
endfunction

logic [27:0] entr0;
logic [27:0] entr1;
logic [27:0] error;
logic [27:0] bcd;
assign error = {7'b0000110, 7'b0101111, 7'b0101111, 7'b0100011};
assign bcd = {(negativeD ? 7'b0111111 : 7'b1111111),
					bcd_to_led(0, 0, D[9], D[8]),
					bcd_to_led(D[7], D[6], D[5], D[4]),
					bcd_to_led(D[3], D[2], D[1], D[0])};
assign entr0 = {(negativeA ? 7'b0111111 : 7'b1111111),
					bcd_to_led(0, 0, A[9], A[8]),
					bcd_to_led(A[7], A[6], A[5], A[4]),
					bcd_to_led(A[3], A[2], A[1], A[0])};
assign entr1 = {(negativeB ? 7'b0111111 : 7'b1111111),
					bcd_to_led(0, 0, B[9], B[8]),
					bcd_to_led(B[7], B[6], B[5], B[4]),
					bcd_to_led(B[3], B[2], B[1], B[0])};
assign {led3, led2, led1, led0} = {(key && overflow) ? error : (key ? bcd : entr1)};
assign {led7, led6, led5, led4} = {(key && overflow) ?  {7'b1111111, { 3{7'b1000000} } } : (key ? { 4{7'b1000000} } : entr0)};

endmodule
