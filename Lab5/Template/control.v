module control_circuit (input clk, input reset, input [5:0] opcode, input [5:0] funct, 
                        output reg IorD, output reg memRead, output reg IRWrite, output reg regDest, output reg regWrite,
                        output reg aluSrcA, output reg [1:0] aluSrcB, output reg [1:0] aluOp, output reg hiWrite,
                        output reg loWrite, output reg [1:0] memToReg, output reg [1:0] pcSrc, output reg pcWrite,
                        output reg branch );

    reg [3:0] state;

    // Write your code here

    // state must update on every negedge of clk

    // the outputs have to be assigned as per the value of state

endmodule