module control_circuit (input clk, input reset, input [5:0] opcode, input [5:0] funct,
                        output reg IorD, output reg memRead, output reg IRWrite, output reg regDest, output reg regWrite,
                        output reg aluSrcA, output reg [1:0] aluSrcB, output reg [1:0] aluOp, output reg hiWrite,
                        output reg loWrite, output reg [1:0] memToReg, output reg [1:0] pcSrc, output reg pcWrite,
                        output reg branch );

  reg [3:0] state;
  reg [17:0] value;
  always @ ( reset ) begin
      state = 0;
  end

  always @ ( state ) begin
      case (state)
          4'b0001: value = 18'b011000010000001010;
          4'b0010: value = 18'b000000110000000000;
          4'b0011: value = 18'b000001100000000000;
          4'b0100: value = 18'b000001001000000000;
          4'b0101: value = 18'b000110000000010000;
          4'b0110: value = 18'b000001100000000000;
          4'b0111: value = 18'b000000000000000110;
          4'b1000: value = 18'b000001000100000001;
          4'b1001: value = 18'b000010000000100000;
          4'b1010: value = 18'b000000000011000000;
          4'b1011: value = 18'b110000000000000000;
          4'b1100: value = 18'b000010000000000000;
          default: value = 19'b000000000000000000;
      endcase

      IorD = value[17]; memRead = value[16]; IRWrite = value[15]; regDest = value[14]; regWrite = value[13];
      aluSrcA = value[12]; aluSrcB = value[11:10]; aluOp = value[9:8]; hiWrite = value[7]; loWrite = value[6];
      memToReg = value[5:4]; pcSrc = value[3:2]; pcWrite = value[1]; branch = value[0];
  end
  always @ ( negedge clk ) begin
      case (state)
          4'b0000:begin state = 4'b0001; end
          4'b0001:begin state = 4'b0010; end
          4'b0010: begin
          case (opcode)
              6'b001000: state = 4'b0011;
              6'b011000: state = 4'b0100;
              6'b010000: state = 4'b0101;
              6'b100011: state = 4'b0110;
              6'b000010: state = 4'b0111;
              6'b000100: state = 4'b1000;
              default: state = 4'b1000;
          endcase
          end
          4'b0011:begin state = 4'b1001;end
          4'b0100:begin state = 4'b1010;end
          4'b0101:begin state = 4'b0001;end
          4'b0110:begin state = 4'b1011;end
          4'b0111:begin state = 4'b0001;end
          4'b1000:begin state = 4'b0001;end
          4'b1001:begin state = 4'b0001;end
          4'b1010:begin state = 4'b0001;end
          4'b1011:begin state = 4'b1100;end
          4'b1100:begin state = 4'b0001;end
          default:begin state = 4'b0000;end
      endcase
  end
endmodule
