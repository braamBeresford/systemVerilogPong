module enableMux(input logic [3:0] a,
input logic controlSig,
output logic [3:0] d);

assign d = controlSig ? a : 4'b0; 

endmodule