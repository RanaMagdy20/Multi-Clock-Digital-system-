//////MUX-select sync Method///////////
module DATA_SYNC #(parameter DATA_WIDTH=8, N_STAGES=2, EN_WIDTH=1) 
(
    input wire [DATA_WIDTH-1 : 0] Unsync_bus, //Data from domain 1
    input wire Unsync_enable, //Enable from domain 1
    input wire D_CLK,D_RST, //Destination CLK and RST
    output reg [DATA_WIDTH-1:0] sync_bus, //sync input to domain 2
    output reg enable_pulse
);


wire x;

wire syn_enable;
//instintiate Pulse GEN block
Pulse_GEN P(
.D_CLK(D_CLK),
.D_RST(D_RST),
.SYNC_En(syn_enable), 
.En_pulse(x)
);

//instintiate Multi_ff block
BIT_SYNC #(.N_STAGES(N_STAGES), .BUS_WIDTH(EN_WIDTH)) B(
.D_CLK(D_CLK),
.D_RST(D_RST),
.ASYNC_IN(Unsync_enable),
.SYNC_OUT(syn_enable)
);

//output:
always @(posedge D_CLK or negedge D_RST)
begin
    if(!D_RST) 
        sync_bus<='d0;
    else 
        sync_bus<=Unsync_bus;
  
    
end

always @(posedge D_CLK or negedge D_RST)
begin
    if(!D_RST) 
        enable_pulse<=0;
    else 
        enable_pulse<=x;
end

endmodule




