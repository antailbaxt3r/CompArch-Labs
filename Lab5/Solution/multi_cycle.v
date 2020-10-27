`include "alu.v"
`include "control.v"
`include "dff.v"
`include "memory.v"
`include "mux.v"
`include "register_file.v"
`include "registers.v"
`include "sign_ext.v"

module multi_cycle (input clk, input reset, output [31:0] result);
    
    // Write your code here

    // make sure that the im module is instantiated as "instruction memory"    

    //wires
    wire IorD, memRead, IRWrite, regDest, regWrite, aluSrcA, hiWrite, loWrite, pcWrite, branch, zero;
    wire [1:0]  aluSrcB, aluOp, memToReg, pcSrc;
    wire [31:0] inPC, outPC, data_out, IR, MDR, writeData, regOut1, regOut0, A, B, extended, aluIn0, aluIn1, aluOut0, aluOut1, Out1, hi, lo;
    wire [4:0] inIM, rd;

    //PC
    intermediate_reg pc(clk, reset, (pcWrite | (branch & zero)), inPC, outPC);
    //ALU
    mux2to1 #(32) ain0(outPC, A, aluSrcA, aluIn0);
    mux4to1 #(32) ain1(B, 32'd4, extended, {extended[29:0], 2'b00}, aluSrcB, aluIn1);
    alu alu_(aluIn0, aluIn1, aluOp, aluOut0, aluOut1, zero);
    intermediate_reg Out0_(clk, reset, 1'b1, aluOut0, result);
    intermediate_reg Out1_(clk, reset, 1'b1, aluOut1, Out1);
    intermediate_reg Hi_(clk, reset, hiWrite, Out1, hi);
    intermediate_reg Lo_(clk, reset, loWrite, result, lo);
    //control circuit
    control_circuit circuit(clk, reset, IR[31:26], IR[5:0], IorD, memRead, IRWrite, regDest, regWrite, aluSrcA, aluSrcB, aluOp, hiWrite, loWrite, memToReg, pcSrc, pcWrite, branch);

    //coming full circle
    mux4to1 #(32) forWData(MDR, hi, result, 32'd0, memToReg, writeData);
    mux4to1 #(32) forInPC(result, { outPC[31:28], IR[25:0], 2'b00 }, aluOut0, 32'dX, pcSrc, inPC);
    mux2to1 #(5) forInIM(outPC[6:2], result[6:2], IorD, inIM);

    //IM
    im #(32, 5) instruction_memory(clk, reset, inIM, memRead, data_out);
    intermediate_reg IR_(clk, reset, IRWrite, data_out, IR);
    intermediate_reg MDR_(clk, reset, 1'b1, data_out, MDR);
    sign_ext signExt(IR[15:0], extended);

    //register file
    mux2to1 #(5) rd_(IR[20:16], IR[15:11], regDest, rd);
    register_file regfile(clk, reset, regWrite, IR[25:21], IR[20:16], rd, writeData, regOut0, regOut1);
    intermediate_reg A_(clk, reset, 1'b1, regOut0, A);
    intermediate_reg B_(clk, reset, 1'b1, regOut1, B);

endmodule