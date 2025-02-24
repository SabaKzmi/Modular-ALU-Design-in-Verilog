//ALU
module ALU (A, B, s2, s1, s0, F, c, v, z);
	input 	[7:0]A, B;
	input	s2, s1, s0;
	output	[7:0]F;
	output	c, v, z;
	
	wire 	lgZ, arZ;
	wire 	[7:0]lgF, arF;
	
	lgUnit		u0(A, B, s1, s0, lgF, lgZ);
	arUnit		u1(A, B, s1, s0, arF, c, arZ, v);
	
	mux2to1_8bit	u2(F, arF, lgF, s2);
	or (z, lgZ, arZ);

endmodule
//-------------------------------------------------------------
//2 to 1 multiplexer, 8bits (data flow)
module mux2to1_8bit (out, d0, d1, s);
	input 	[7:0]d0, d1;
	input 	s;
	output	[7:0]out;
	
	assign 	out = (s == 1'b0) ? d0 : d1;
endmodule
