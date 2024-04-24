--VHDL instantiation template

component dsi is
    port (dsi_to_cmos_pd_blue_o: out std_logic_vector(7 downto 0);
        dsi_to_cmos_pd_green_o: out std_logic_vector(7 downto 0);
        dsi_to_cmos_pd_red_o: out std_logic_vector(7 downto 0);
        dsi_to_cmos_clk_n_i: inout std_logic;
        dsi_to_cmos_clk_p_i: inout std_logic;
        dsi_to_cmos_clk_pixel_o: out std_logic;
        dsi_to_cmos_d0_n_io: inout std_logic;
        dsi_to_cmos_d0_p_io: inout std_logic;
        dsi_to_cmos_d1_n_i: inout std_logic;
        dsi_to_cmos_d1_p_i: inout std_logic;
        dsi_to_cmos_d2_n_i: inout std_logic;
        dsi_to_cmos_d2_p_i: inout std_logic;
        dsi_to_cmos_d3_n_i: inout std_logic;
        dsi_to_cmos_d3_p_i: inout std_logic;
        dsi_to_cmos_de_o: out std_logic;
        dsi_to_cmos_hsync_o: out std_logic;
        dsi_to_cmos_reset_n_i: in std_logic;
        dsi_to_cmos_vsync_o: out std_logic
    );
    
end component dsi; -- sbp_module=true 
_inst: dsi port map (dsi_to_cmos_pd_blue_o => __,dsi_to_cmos_pd_green_o => __,
          dsi_to_cmos_pd_red_o => __,dsi_to_cmos_clk_n_i => __,dsi_to_cmos_clk_p_i => __,
          dsi_to_cmos_clk_pixel_o => __,dsi_to_cmos_d0_n_io => __,dsi_to_cmos_d0_p_io => __,
          dsi_to_cmos_d1_n_i => __,dsi_to_cmos_d1_p_i => __,dsi_to_cmos_d2_n_i => __,
          dsi_to_cmos_d2_p_i => __,dsi_to_cmos_d3_n_i => __,dsi_to_cmos_d3_p_i => __,
          dsi_to_cmos_de_o => __,dsi_to_cmos_hsync_o => __,dsi_to_cmos_reset_n_i => __,
          dsi_to_cmos_vsync_o => __);
