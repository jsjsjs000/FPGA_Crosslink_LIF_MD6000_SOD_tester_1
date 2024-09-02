/* synthesis translate_off*/
`define SBP_SIMULATION
/* synthesis translate_on*/
`ifndef SBP_SIMULATION
`define SBP_SYNTHESIS
`endif

//
// Verific Verilog Description of module pll
//
module pll (pll1_CLKI, pll1_CLKOS2, pll1_RST) /* synthesis sbp_module=true */ ;
    input pll1_CLKI;
    output pll1_CLKOS2;
    input pll1_RST;
    
    
    pll1 pll1_inst (.CLKI(pll1_CLKI), .CLKOS2(pll1_CLKOS2), .RST(pll1_RST));
    
endmodule

