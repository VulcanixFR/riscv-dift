////////////////////////////////////////////////////////////////////////////////
// Engineer        Christian Palmiero - cp3025@columbia.edu                   //
//                                                                            //
// Design Name:    Enable tag                                                 //
// Project Name:   RI5CY                                                      //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    Enable decoder                                             //
//                 This unit reads the ENABLE field of the Tag Propagation    //
//                 Register and sends the proper signals to the EX stage      //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
// Decodeur spécial pour la partie ENABLE du TPR, qui vient s'ajouter en parallèle du décodeur déjà présent sur le processeur

import riscv_defines::*;

module riscv_enable_tag
(
  // From IF/ID pipeline
  input  logic [31:0] instr_rdata_i,

  // From CSRs
  input  logic [31:0] tpr_i,

  // To ID
  output logic        is_store_o,
  output logic        enable_a_o,
  output logic        enable_b_o
);

  always_comb
  begin
    enable_a_o = 1'b0;
    enable_b_o = 1'b0;
    is_store_o = 1'b0;

    unique case (instr_rdata_i[6:0])

      OPCODE_STORE,
      OPCODE_STORE_POST
      : begin
        enable_a_o  = tpr_i[LOADSTORE_EN_DEST_ADDR];
        enable_b_o  = tpr_i[LOADSTORE_EN_SOURCE];
        is_store_o  = 1'b1;
      end

      default: ;
    endcase
  end

endmodule
