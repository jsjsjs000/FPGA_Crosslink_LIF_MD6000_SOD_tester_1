/* synthesis translate_off*/
`define SBP_SIMULATION
/* synthesis translate_on*/
`ifndef SBP_SIMULATION
`define SBP_SYNTHESIS
`endif

//
// Verific Verilog Description of module pll
//
module pll (pll1_CLKI, pll1_CLKOS, pll1_CLKOS3) /* synthesis sbp_module=true */ ;
    input pll1_CLKI;
    output pll1_CLKOS;
    output pll1_CLKOS3;
    
    
    pll1 pll1_inst (.CLKI(pll1_CLKI), .CLKOS(pll1_CLKOS), .CLKOS3(pll1_CLKOS3));
    
endmodule

