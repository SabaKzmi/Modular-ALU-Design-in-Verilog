//arithmetic unit
module arUnit(A, B, s1, s0, F, c, z, v);
	input signed	[7:0] A, B;
	input 			s1, s0;
	output signed	[7:0] F;
	output 			c, z, v;
	wire 	cin1, cin2, cin3, cin4, cin5, cin6, cin7;
	
	arCell	u0(F[0], cin1, A[0], B[0], 1'b0, s1, s0);
	arCell	u1(F[1], cin2, A[1], B[1], cin1, s1, s0);
	arCell	u2(F[2], cin3, A[2], B[2], cin2, s1, s0);
	arCell	u3(F[3], cin4, A[3], B[3], cin3, s1, s0);
	arCell	u4(F[4], cin5, A[4], B[4], cin4, s1, s0);
	arCell	u5(F[5], cin6, A[5], B[5], cin5, s1, s0);
	arCell	u6(F[6], cin7, A[6], B[6], cin6, s1, s0);
	arCell	u7(F[7], c, A[7], B[7], cin7, s1, s0);
	
	nor(z, F[0], F[1], F[2], F[3], F[4], F[5], F[6], F[7]);
	
	assign plus_V  = (A[7] == B[7]) & (A[7] != F[7]);
	assign minus_V = (A[7] != B[7]) & (B[7] == F[7]);
	assign v = ({s1,s0} == 2'b00) ? plus_V :
			   ({s1,s0} == 2'b01) ? minus_V:
			   1'b0;
endmodule
//-------------------------------------------------------------
//arithnetic cell
module arCell(out, cout, a, b, cin, s1, s0);
	output out, cout;
	input  a, b, cin, s1, s0;
	wire   m, bNot;
	
	not (bNot, b);
	
	fullAdder u0(out, cout, a, m, cin);
	mux4to1   u1(m, b, bNot, 1'b0, 1'b1, s1, s0);

endmodule
//-------------------------------------------------------------
//full adder 1-bit (gate level)
module fullAdder(sum, cout, a, b, cin);
	output sum, cout;
	input  a, b, cin;
	
	wire   s1, c1, c2;
	
	xor(s1, a, b);
	and(c1, a, b);
	xor(sum, s1, cin);
	and(c2, s1, cin);
	or(cout, c2, c1);
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
