`timescale 1ns/1ns
module DATA_SYNC_TB();
parameter N_STAGES =2 ,DATA_WIDTH=8, EN_WIDTH=1, TCLK=10;
reg D_CLK,D_RST;
reg [DATA_WIDTH-1:0] Unsync_bus;
reg Unsync_enable;
wire [DATA_WIDTH-1:0] sync_bus;
wire enable_pulse;

always #(TCLK/2) D_CLK=~D_CLK;

DATA_SYNC #(. N_STAGES( N_STAGES), .DATA_WIDTH(DATA_WIDTH), .EN_WIDTH(EN_WIDTH)) DUT
(
.D_CLK(D_CLK),
.D_RST(D_RST),
.Unsync_bus(Unsync_bus),
.Unsync_enable(Unsync_enable),
.sync_bus(sync_bus),
.enable_pulse(enable_pulse)
);

initial
begin
    intialize();
    reset();
    Configuration(8'b10101010,1'b1);
    //#(20*TCLK);
   // Configuration(8'b11111110,1'b1);
    #100 $stop;




end



task intialize;
begin
    D_CLK=0;
    D_RST=1;
    Unsync_bus='d0;
    Unsync_enable=0;
end
endtask

task reset;
begin
    #TCLK
    D_RST=0;
    #(2*TCLK) //Trecov*
    D_RST=1;
    #TCLK;
end
endtask

task Configuration(input [DATA_WIDTH-1:0] in, input En);
begin
    Unsync_bus=in;
    Unsync_enable=En;

end
endtask
endmodule