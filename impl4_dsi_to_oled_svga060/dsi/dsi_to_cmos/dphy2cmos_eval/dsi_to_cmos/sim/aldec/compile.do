set sim_working_folder "C:/my_designs/"
set workspace_name "dphy2cmos_space"
set design_name "dphy2cmos"
set design_path "C:/my_designs/CFG0"
set design_inst "CFG0_inst"
set diamond_dir "C:/lscc/diamond/3.9_x64"

######## Do not modify ########
cd $sim_working_folder
workspace create $workspace_name
design create $design_name .
design open $design_name
cd $design_path/${design_inst}/dphy2cmos_eval/testbench
runscript $design_path/${design_inst}/dphy2cmos_eval/${design_inst}/sim/aldec/update_tb.pl ${design_inst}
###############################

#compile the files
vlog \
-v2k5 \
###############################

#Update params as needed
+define+NUM_FRAMES=2 \
+define+NUM_LINES=5 \
+define+DPHY_CLK=3307 \
###############################

$diamond_dir/cae_library/simulation/blackbox/lifmd_black_boxes-aldec.vp \
$diamond_dir/cae_library/simulation/verilog/lifmd/*.v \
$diamond_dir/cae_library/simulation/verilog/pmi/*.v \
$design_path/${design_inst}/${design_inst}_params.v \
$design_path/${design_inst}/${design_inst}_byte2pixel.v \
$design_path/${design_inst}/dphy2cmos_eval/${design_inst}/src/beh_rtl/byte2pixel_beh.v \
$design_path/${design_inst}/${design_inst}_capture_ctrl.v \
$design_path/${design_inst}/dphy2cmos_eval/${design_inst}/src/beh_rtl/capture_ctrl_beh.v \
$design_path/${design_inst}/${design_inst}_rx_global_ctrl.v \
$design_path/${design_inst}/dphy2cmos_eval/${design_inst}/src/beh_rtl/rx_global_ctrl_beh.v \
$design_path/${design_inst}/${design_inst}_dphy_rx_wrap.v \
$design_path/${design_inst}/dphy2cmos_eval/${design_inst}/src/beh_rtl/dphy_rx_wrap_beh.v \
$design_path/${design_inst}/dphy2cmos_eval/models/lifmd/pll_wrapper.v \
$design_path/${design_inst}/${design_inst}_dphy_2_cmos_ip.v \
$design_path/${design_inst}/${design_inst}.v \
$design_path/${design_inst}/dphy2cmos_eval/testbench/dsi_model.v \
$design_path/${design_inst}/dphy2cmos_eval/testbench/csi2_model.v \
$design_path/${design_inst}/dphy2cmos_eval/testbench/dphy_2_cmos_tb.v

# Start the simulator #
vsim +access +r tb

# adding the signals to wave window #########
wave /tb/I_dphy_2_cmos/*

# run simulation cycles
run -all
