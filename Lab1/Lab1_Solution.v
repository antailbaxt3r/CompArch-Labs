//ShifterAndALU.v

// select 0 = in0 1 = in1
module mux2to1_3bit(input [2:0] in0, input [2:0] in1, input select, output reg [2:0] muxOut);
  //WRITE CODE HERE	
    always @ *
	begin
		if(select) muxOut = in1;
		else if (~select) muxOut = in0;
	end
endmodule

// select 0 = in0 1 = in1
module mux2to1_8bit(input [7:0] in0, input [7:0] in1, input select, output reg [7:0] muxOut);
   //WRITE CODE HERE
    always @ *
	begin
		if(select) muxOut = in1;
		else if (~select) muxOut = in0;
	end
endmodule


module mux8to1_1bit(input in0, input in1, input in2, input in3, input in4, input in5, input in6, input in7, input[2:0] select,output reg muxOut);
   //WRITE CODE HERE
    always @ *
	    begin
		    case (select)
		    3'b000: muxOut = in0;
		    3'b001: muxOut = in1;
		    3'b010: muxOut = in2;
		    3'b011: muxOut = in3;
		    3'b100: muxOut = in4;
		    3'b101: muxOut = in5;
		    3'b110: muxOut = in6;
		    3'b111: muxOut = in7;
	   	    endcase
	   end
   
endmodule

module barrelshifter(input[2:0] shiftAmt, input[7:0] b, input[2:0] oper, output[7:0] shiftOut);
	   //WRITE CODE HERE
		wire[2:0] mAout, mBout, mCout;
		wire[7:0] s, r;
			
		//2 to 1 multiplexers for select
		mux2to1_3bit ma(3'b000, oper, shiftAmt[0], mAout);
		mux2to1_3bit mb(3'b000, oper, shiftAmt[1], mBout);
		mux2to1_3bit mc(3'b000, oper, shiftAmt[2], mCout);

		//8 to 1 mux b to s
		mux8to1_1bit ma0(b[0], b[1], b[1], b[1], 1'b0, b[7], 1'b0, 1'b0, mAout, s[0]);
		mux8to1_1bit ma1(b[1], b[2], b[2], b[2], b[0], b[0], 1'b0, 1'b0, mAout, s[1]);
		mux8to1_1bit ma2(b[2], b[3], b[3], b[3], b[1], b[1], 1'b0, 1'b0, mAout, s[2]);
		mux8to1_1bit ma3(b[3], b[4], b[4], b[4], b[2], b[2], 1'b0, 1'b0, mAout, s[3]);
		mux8to1_1bit ma4(b[4], b[5], b[5], b[5], b[3], b[3], 1'b0, 1'b0, mAout, s[4]);
		mux8to1_1bit ma5(b[5], b[6], b[6], b[6], b[4], b[4], 1'b0, 1'b0, mAout, s[5]);
		mux8to1_1bit ma6(b[6], b[7], b[7], b[7], b[5], b[5], 1'b0, 1'b0, mAout, s[6]);
		mux8to1_1bit ma7(b[7], b[7], 1'b0, b[0], b[6], b[6], 1'b0, 1'b0, mAout, s[7]);

		//8 to 1 mux s to r
		mux8to1_1bit mb0(s[0], s[2], s[2], s[2], 1'b0, s[6], 1'b0, 1'b0, mBout, r[0]);
		mux8to1_1bit mb1(s[1], s[3], s[3], s[3], 1'b0, s[7], 1'b0, 1'b0, mBout, r[1]);
		mux8to1_1bit mb2(s[2], s[4], s[4], s[4], s[0], s[0], 1'b0, 1'b0, mBout, r[2]);
		mux8to1_1bit mb3(s[3], s[5], s[5], s[5], s[1], s[1], 1'b0, 1'b0, mBout, r[3]);
		mux8to1_1bit mb4(s[4], s[6], s[6], s[6], s[2], s[2], 1'b0, 1'b0, mBout, r[4]);
		mux8to1_1bit mb5(s[5], s[7], s[7], s[7], s[3], s[3], 1'b0, 1'b0, mBout, r[5]);
		mux8to1_1bit mb6(s[6], s[7], 1'b0, s[0], s[4], s[4], 1'b0, 1'b0, mBout, r[6]);
		mux8to1_1bit mb7(s[7], s[7], 1'b0, s[1], s[5], s[5], 1'b0, 1'b0, mBout, r[7]);

		//8 to 1 mux r to out
		mux8to1_1bit mc0(r[0], r[4], r[4], r[4], 1'b0, r[4], 1'b0, 1'b0, mCout, shiftOut[0]);
		mux8to1_1bit mc1(r[1], r[5], r[5], r[5], 1'b0, r[5], 1'b0, 1'b0, mCout, shiftOut[1]);
		mux8to1_1bit mc2(r[2], r[6], r[6], r[6], 1'b0, r[6], 1'b0, 1'b0, mCout, shiftOut[2]);
		mux8to1_1bit mc3(r[3], r[7], r[7], r[7], 1'b0, r[7], 1'b0, 1'b0, mCout, shiftOut[3]);
		mux8to1_1bit mc4(r[4], r[7], 1'b0, r[0], r[0], r[0], 1'b0, 1'b0, mCout, shiftOut[4]);
		mux8to1_1bit mc5(r[5], r[7], 1'b0, r[1], r[1], r[1], 1'b0, 1'b0, mCout, shiftOut[5]);
		mux8to1_1bit mc6(r[6], r[7], 1'b0, r[2], r[2], r[2], 1'b0, 1'b0, mCout, shiftOut[6]);
		mux8to1_1bit mc7(r[7], r[7], 1'b0, r[3], r[3], r[3], 1'b0, 1'b0, mCout, shiftOut[7]);

		
endmodule

// Alu operations are: 00 for alu1, 01 for add, 10 for sub(alu1-alu2) , 11 for AND, 100 for OR and 101 for NOT(alu1)
module alu(input [7:0] aluIn1, input [7:0] aluIn2, input [2:0]aluOp, output reg [7:0] aluOut);
       //WRITE CODE HERE
	   always @ *
	   begin
		   case (aluOp)
		   3'b000: aluOut = aluIn1;
		   3'b001: aluOut = aluIn1 + aluIn2;
		   3'b010: aluOut = aluIn1 - aluIn2;
		   3'b011: aluOut = aluIn1 & aluIn2;
		   3'b100: aluOut = aluIn1 | aluIn2;
		   3'b101: aluOut = ~(aluIn1);
	   	  endcase
	   end
endmodule


module shifterAndALU(input [7:0]inp1, input [7:0] inp2, input [2:0]shiftlmm, input selShiftAmt, input [2:0]oper, input selOut, output [7:0] out);
	   //WRITE CODE HERE
	    wire[2:0] shiftAmt;
	    wire[7:0] aluOut, shiftOut;

		alu alu1(inp1, inp2, oper, aluOut);
	    mux2to1_3bit m(inp2[2:0], shiftlmm, selShiftAmt, shiftAmt);
		barrelshifter shifter(shiftAmt, inp1, oper, shiftOut);
		mux2to1_8bit m8(aluOut, shiftOut, selOut, out);

endmodule

//TestBench ALU
module testbenchALU();
	// Input
	reg [7:0] inp1, inp2;
	reg [2:0] aluOp;
	reg [2:0] shiftlmm;
	reg selShiftAmt, selOut;
	// Output
	wire [7:0] aluOut;

	shifterAndALU shifterAndALU_Test (inp1, inp2, shiftlmm, selShiftAmt, aluOp, selOut, aluOut);

	initial
		begin
			$dumpfile("testALU.vcd");
     	$dumpvars(0,testbenchALU);
			inp1 = 8'd80; //80 in binary is 1010000
			inp2 = 8'd20; //20 in binary is 10100
			shiftlmm = 3'b010;

			aluOp=3'd0; selOut = 1'b0;// normal output = 80

			#10 aluOp = 3'd0; selOut = 1'b1; selShiftAmt = 1'b1; //No shift output = 80

			#10 aluOp=3'd1; selOut = 1'b0;// normal add	output => 20 + 80 = 100

			#10 aluOp = 3'd1; selOut = 1'b1; selShiftAmt = 1'b1; // arithmetic shift right of 80 by 2 places = 20

			#10 aluOp=3'd2; selOut = 1'b0; // normal sub output => 80 - 20 = 60

			#10 aluOp = 3'd2; selOut = 1'b1; selShiftAmt = 1'b0; // logical shift right of 80 by 4 places = 0

			#10 aluOp=3'd3; selOut = 1'b0;// normal and output => 80 & 20 = 16

			#10 aluOp = 3'd3; selOut = 1'b1; selShiftAmt = 1'b0; // Circular Shift Right of 80 by 4 places = 5

			#10 aluOp=3'd4; selOut = 1'b0;// normal or output => 80 | 20 = 84

			#10 aluOp = 3'd4; selOut = 1'b1; selShiftAmt = 1'b1; // Logical Shift Left of 80 by 2 bits = 64

			#10 aluOp=3'd5; selOut = 1'b0; // normal not of 80 = 175

			#10 aluOp = 3'd5; selOut = 1'b1; selShiftAmt = 1'b0; // Circular left shift of 80 by 4 bits = 5

			#10 inp1=8'd15; inp2=8'd26; aluOp=3'd2; selOut = 1'b0;//sub overflow
			// (15 - 26) = -11 and its a 8 bit number so, 256-11 = 245 output => 245 (since it is unsigned decimal)

			#10 inp1=8'd150; inp2=8'd150; aluOp=3'd1; selOut = 1'b0;// add overflow
			//(150+150) = 300 and its a 8 bit number so, 300-256 = 44 output=> 44.

			#10 inp1=8'b0000_0000; aluOp=3'd5; selOut = 1'b0;//not overflow
			// not(0) = all 1. Since its a 8 bit number output=>255

			#10 $finish;
		end

endmodule
