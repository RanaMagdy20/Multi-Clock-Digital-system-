module Pulse_GEN 
(
    input wire SYNC_En,
    input wire D_CLK, D_RST, //Destination CLK and RST
    output wire En_pulse

);
reg EN;

always @(posedge D_CLK or negedge D_RST)
begin
    if(!D_RST)
    EN<=0;
    else
    EN<=SYNC_En;
end

assign En_pulse = !EN && SYNC_En;
endmodule
