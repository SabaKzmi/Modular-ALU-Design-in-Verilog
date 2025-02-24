module tbALU;
	reg 	[7:0]A, B;
	reg		s2, s1, s0;
	wire	[7:0]F;
	wire	c, v, z;
	
	ALU u0(A, B, s2, s1, s0, F, c, v, z);
	initial
	begin
		$monitor("A = %d  B = %d  s = %b%b%b F = %d  c = %b  v = %b  z = %b",
				A, B, s2, s1, s0, F, c, v, z);
	end
	initial 
	begin
		A = 8'd33;
		B = 8'd18;
		
		#0	s2 = 0; s1 = 0; s0 = 0;
		#20 s2 = 0; s1 = 0; s0 = 1;
		#20 s2 = 0; s1 = 1; s0 = 0;
		#20 s2 = 0; s1 = 1; s0 = 1;
		#20 s2 = 1; s1 = 0; s0 = 0;
		#20 s2 = 1; s1 = 0; s0 = 1;
		#20 s2 = 1; s1 = 1; s0 = 0;
		#20 s2 = 1; s1 = 1; s0 = 1;
		#20 s2 = 0; s1 = 0; s0 = 1;
			A = 8'b10000000; B = 8'b00000001;
		#20 $stop;
	end
endmodule
