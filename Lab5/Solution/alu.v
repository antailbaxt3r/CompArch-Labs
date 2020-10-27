module alu(input [31:0] aluIn1, input [31:0] aluIn2, input [1:0] aluOp, output reg [31:0] aluOut0, output reg [31:0] aluOut1, output reg zero);
    
	// Write your code here
    // out0 corresponds to the lower 32 bits of the result
    // out1 corresponds to the higher 32 bits of the result
	always @ *
    begin
        case (aluOp)
            2'b00 : { aluOut1, aluOut0 } = { 32'h0, aluIn1 + aluIn2 };
            2'b01 : { aluOut1, aluOut0 } = { 32'h0, aluIn1 - aluIn2 };
            2'b10 : { aluOut1, aluOut0 } = (aluIn1 * aluIn2);
        endcase
        // $display("%d %d %d %d %d %d", aluOp, aluIn1, aluIn2, aluOut1, aluOut0, zero);
        if({aluOut1, aluOut0} == 64'b0) zero = 1'b1;
        else zero = 1'b0;
    end
endmodule