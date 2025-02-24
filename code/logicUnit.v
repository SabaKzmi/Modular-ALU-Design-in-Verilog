//logic unit
module lgUnit(A, B, s1, s0, F, z);
	input 	[7:0]A, B;
	input	s1, s0;
	output	[7:0]F;
	output	z;
	
	lgCell u0(F[0], A[0], B[0], s1, s0);
	lgCell u1(F[1], A[1], B[1], s1, s0);
	lgCell u2(F[2], A[2], B[2], s1, s0);
	lgCell u3(F[3], A[3], B[3], s1, s0);
	lgCell u4(F[4], A[4], B[4], s1, s0);
	lgCell u5(F[5], A[5], B[5], s1, s0);
	lgCell u6(F[6], A[6], B[6], s1, s0);
	lgCell u7(F[7], A[7], B[7], s1, s0);
	
	nor (z, F[0], F[1], F[2], F[3], F[4], F[5], F[6], F[7]);

endmodule
//-------------------------------------------------------------
module lgCell (out, a, b, s1, s0);
	output out;
	input  a, b, s1, s0;
	
	wire   andOut, orOut, notA, xorOut;
	
	and (andOut, a, b);
	or	(orOut, a, b);
	not	(notA, a);
	xor (xorOut, a, b);
	
	mux4to1 u0(out, andOut, orOut, notA, xorOut, s1, s0);

endmodule
//-------------------------------------------------------------
//4 to 1 multiplexer (gate level)
module mux4to1(out, d0, d1, d2, d3, s1, s0);
	output out;
	input  d0, d1, d2, d3, s1, s0;
	
	wire   nots0, nots1, y0, y1, y2, y3;
	
	not (nots0, s0);
	not (nots1, s1);
	and (y0, d0, nots1, nots0);
	and (y1, d1, nots1, s0);
	and (y2, d2, s1, nots0);
	and (y3, d3, s1, s0);
	or  (out, y0, y1, y2, y3);
endmodule
