`include "ctrl_encode_def.v"
`define NPC_JR    2'b11
module NPC(PC, NPCOp, IMM, RS, NPC);  // next pc module
    
   input  [31:0] PC;        // pc
   input  [1:0]  NPCOp;     // next pc operation
   input  [25:0] IMM;       // immediate  
   input  [31:0] RS;         // JR/JALR
   output reg [31:0] NPC;   // next pc
   
   wire [31:0] PCPLUS4;
   
   assign PCPLUS4 = PC + 4; // pc + 4
   
   always @(*) begin
      case (NPCOp)
          `NPC_PLUS4:  NPC = PCPLUS4;
          `NPC_BRANCH: NPC = PCPLUS4 + {{14{IMM[15]}}, IMM[15:0], 2'b00};
          `NPC_JUMP:   NPC = {PCPLUS4[31:28], IMM[25:0], 2'b00};
          `NPC_JR:     NPC = RS;
          default:     NPC = PCPLUS4;
      endcase
   end // end always
   
endmodule
