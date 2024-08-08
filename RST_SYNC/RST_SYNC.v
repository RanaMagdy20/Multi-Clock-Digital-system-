module RST_SYNC #(parameter N_STAGES =2)
(
    input wire CLK, RST,
    output reg SYNC_RST
);

wire one;
assign one = 1'b1;
reg [N_STAGES-1:0] stages;

always @(posedge CLK or negedge RST)
begin
    if(!RST) 
        stages<='d0;
    else
        stages <= {stages[N_STAGES-2:0] ,one};
end

assign SYNC_RST=stages[N_STAGES-1];
endmodule
