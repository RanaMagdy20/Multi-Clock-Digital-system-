`timescale 1ns/1ps
module RST_SYNC_TB();

parameter N_STAGES =2, TCLK=10;

reg CLK,RST;
wire SYNC_RST;

always #(TCLK/2) CLK=~CLK;

RST_SYNC #(.N_STAGES(N_STAGES)) DUT
(
.CLK(CLK),
.RST(RST),
.SYNC_RST(SYNC_RST)
);

initial
begin
    intialize();
    reset();
   
   #(N_STAGES*TCLK);
    if(SYNC_RST)
    $display ("PASS");
    else 
    $display ("F");
    #100 $stop;


end

task intialize;
begin
    CLK=0;
    RST=1;
end
endtask

task reset;
begin
    #TCLK
    RST=0;
    #(2*TCLK) //Trecov*
    RST=1;
end
endtask
endmodule


