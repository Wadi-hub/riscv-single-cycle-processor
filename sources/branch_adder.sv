module addershifted 
  (
  input [31:0] pc_out, imm_out,
  output wire [31:0] addsh_out
);
  
  
   assign addsh_out=pc_out+imm_out;

  
endmodule