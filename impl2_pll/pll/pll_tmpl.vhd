--VHDL instantiation template

component pll is
    port (pll1_CLKI: in std_logic;
        pll1_CLKOS: out std_logic;
        pll1_CLKOS3: out std_logic
    );
    
end component pll; -- sbp_module=true 
_inst: pll port map (pll1_CLKI => __,pll1_CLKOS => __,pll1_CLKOS3 => __);
