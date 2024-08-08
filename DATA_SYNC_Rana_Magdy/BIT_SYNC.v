module BIT_SYNC #(parameter N_STAGES=2, BUS_WIDTH=1)
(
    input wire D_CLK, D_RST,
    input wire [BUS_WIDTH-1:0] ASYNC_IN,
    output reg [BUS_WIDTH-1:0] SYNC_OUT

);
reg  [N_STAGES-1:0] sync [BUS_WIDTH-1:0];
integer i;

always @(posedge D_CLK or negedge D_RST)
begin
    if(!D_RST)
    begin
    for (i=0; i<BUS_WIDTH; i=i+1)
        sync[i]<=0;
    end
    else begin
    for (i=0; i<BUS_WIDTH; i=i+1)
        sync[i]<={sync[i][N_STAGES-2:0],ASYNC_IN[i]};
end
end
//assigning SYNC_OUT=sync

always @(*) begin
    for (i=0; i<BUS_WIDTH; i=i+1)
    SYNC_OUT[i]=sync[i][N_STAGES-1];
end
    










endmodule