// rx_global_ctrl_beh.v generated by Lattice IP Model Creator version 1
// created on Fri, Mar 16, 2018  2:27:57 PM
// Copyright(c) 2007 Lattice Semiconductor Corporation. All rights reserved
// obfuscator_exe version 1.mar0807

// top





































                
`timescale 1 ns / 100 ps
module tu6c7d8 
 (
     input  wire       reset_n_i,
     input  wire       gq1f61b,

     input wire         jcfb0d8,  
     input wire         dzd86c3,  
     output wire        qtc361f,  
     output wire        do1b0fd,    
     output wire [1:0]  nrd87ea      );
parameter [1:0]  shc3f57 = 3'd0,  ou1fabc = 3'd1,  alfd5e1 = 3'd2,  cmeaf0c = 3'd3;
reg [1:0] ps57861, cobc30b;
reg       tue1858, phc2c2;
reg       xj61616, xyb0b7, lq585bb, dzc2ddb;
reg bn16ede;
reg vkb76f7;
reg [1 : 0] qvbb7bb;
reg [1 : 0] eadbddd;
reg wwdeee9;
reg mrf7749;
reg wlbba4d;
reg zxdd26c;
reg lde9367;
reg ic49b3f;
reg [2047:0] vi4d9f9;
wire [9:0] vi6cfcb;

localparam go67e5a = 10,ri3f2d1 = 32'hfdffc68b;
localparam [31:0] pff968b = ri3f2d1;
localparam zx5a2f1 = ri3f2d1 & 4'hf;
localparam [11:0] vx8bc71 = 'h7ff;
wire [(1 << zx5a2f1) -1:0] byf1c74;
reg [go67e5a-1:0] ld71d1f;
reg [zx5a2f1-1:0] xj747fe [0:1];
reg [zx5a2f1-1:0] uk1ffb1;
reg uiffd89;
integer hofec48;
integer jpf6242;

 always @(posedge gq1f61b or negedge reset_n_i)  begin   if (~reset_n_i) begin     xj61616 <= 0;     xyb0b7    <= 0;     lq585bb    <= 0;     dzc2ddb    <= 0;   end   else begin     xj61616 <= ~bn16ede & (~vkb76f7);     xyb0b7    <= bn16ede & vkb76f7;     lq585bb    <= ~bn16ede & vkb76f7;     dzc2ddb    <= ~bn16ede & (~vkb76f7);   end
end

 assign    do1b0fd = wwdeee9; assign    qtc361f = wwdeee9 | ((qvbb7bb == alfd5e1) & wlbba4d); assign    nrd87ea = qvbb7bb; always @(*) begin     case (qvbb7bb) shc3f57 :     begin                phc2c2 = 0;                if (zxdd26c)                    cobc30b = ou1fabc;                else                    cobc30b = shc3f57;            end        ou1fabc :            begin                phc2c2 = 0;                if (lde9367)                    cobc30b = alfd5e1;                                                else                    cobc30b = ou1fabc;            end        alfd5e1 :            begin                if (ic49b3f)                begin                    phc2c2 = 1;                    cobc30b = cmeaf0c;                end                else if (zxdd26c)                begin                    phc2c2 = 0;                    cobc30b = ou1fabc;                end                                                                                                else                begin                    phc2c2 = 0;                    cobc30b = alfd5e1;                end            end        cmeaf0c :            begin              if (zxdd26c)                begin                    phc2c2 = 0;                    cobc30b = shc3f57;                end                else                begin                    phc2c2 = 1;                    cobc30b = cmeaf0c;                end            end    endcase
end
always @(posedge gq1f61b or negedge reset_n_i)
begin    if (~reset_n_i)    begin        ps57861 <= 0;        tue1858 <= 0;    end    else    begin        ps57861 <= eadbddd;        tue1858 <= mrf7749;    end
end

always@* begin bn16ede<=vi6cfcb[0];vkb76f7<=vi6cfcb[1];qvbb7bb<={ps57861>>1,vi6cfcb[2]};eadbddd<={cobc30b>>1,vi6cfcb[3]};wwdeee9<=vi6cfcb[4];mrf7749<=vi6cfcb[5];wlbba4d<=vi6cfcb[6];zxdd26c<=vi6cfcb[7];lde9367<=vi6cfcb[8];ic49b3f<=vi6cfcb[9];end
always@* begin vi4d9f9[2047]<=dzd86c3;vi4d9f9[2046]<=ps57861[0];vi4d9f9[2044]<=cobc30b[0];vi4d9f9[2040]<=tue1858;vi4d9f9[2032]<=phc2c2;vi4d9f9[2017]<=xj61616;vi4d9f9[1987]<=xyb0b7;vi4d9f9[1926]<=lq585bb;vi4d9f9[1805]<=dzc2ddb;vi4d9f9[1023]<=jcfb0d8;end         assign byf1c74 = vi4d9f9,vi6cfcb = ld71d1f; initial begin hofec48 = $fopen(".fred"); $fdisplay( hofec48, "%3h\n%3h", (pff968b >> 4) & vx8bc71, (pff968b >> (zx5a2f1+4)) & vx8bc71 ); $fclose(hofec48); $readmemh(".fred", xj747fe); end always @ (byf1c74) begin uk1ffb1 = xj747fe[1]; for (jpf6242=0; jpf6242<go67e5a; jpf6242=jpf6242+1) begin ld71d1f[jpf6242] = byf1c74[uk1ffb1]; uiffd89 = ^(uk1ffb1 & xj747fe[0]); uk1ffb1 = {uk1ffb1, uiffd89}; end end 
endmodule





















































`timescale 1 ns / 100 ps
module rx_global_ctrl #(
    parameter NUM_RX_LANE = 4,    parameter RX_GEAR = 16,    parameter RX_FIFO = "OFF",    parameter RX_CLK_MODE = "HS_LP"
)
(
    input  wire              reset_n_i,
    input  wire              reset_lp_n_i,
    input  wire              reset_byte_fr_n_i,
    input  wire               clk_lp_ctrl_i,
    input  wire              clk_byte_hs_i,      
    input  wire              clk_byte_i,
    input  wire              clk_byte_fr_i,
    input  wire              pll_lock_i,         

    input wire [RX_GEAR-1:0]  bd0_i,
    input wire [RX_GEAR-1:0]  bd1_i,
    input wire [RX_GEAR-1:0]  bd2_i,
    input wire [RX_GEAR-1:0]  bd3_i,
    input wire                lp_clk_p_i,         
    input wire                lp_clk_n_i,         
    input wire                lp_d0_p_i,          
    input wire                lp_d0_n_i,          
    input wire                lp_d1_p_i,          
    input wire                lp_d1_n_i,          
    input wire                lp_d2_p_i,          
    input wire                lp_d2_n_i,          
    input wire                lp_d3_p_i,          
    input wire                lp_d3_n_i,          
    input wire                hs_sync_i,          
    output wire [RX_GEAR-1:0] bd0_o,
    output wire [RX_GEAR-1:0] bd1_o,
    output wire [RX_GEAR-1:0] bd2_o,
    output wire [RX_GEAR-1:0] bd3_o,
    output wire               term_clk_en_o,      
    output wire               term_d0_en_o,       
    output wire               hs_d0_en_o,   	  
    output wire               term_d1_en_o,       
    output wire               hs_d1_en_o,         
    output wire               term_d2_en_o,       
    output wire               hs_d2_en_o,         
    output wire               term_d3_en_o,       
    output wire               hs_d3_en_o,         
    output wire               hs_sync_o,          
    output wire [1:0]         lp_hs_state_clk_o,  
    output wire [1:0]         lp_hs_state_d_o     
);
reg  pll_lock_meta, pll_lock_sync;
reg  mta1cf5, jee7ac;
reg  dm73d63;
wire zz9eb1a;
wire [NUM_RX_LANE*RX_GEAR-1:0] ho635c9, uk1ae4a;
wire       xjd7251;
reg ksb928e;
reg gbc9470;
reg dz4a384;
reg ip51c27;
reg xl8e13c;
reg mr709e7;
reg [RX_GEAR - 1 : 0] jr279ef;
reg [RX_GEAR - 1 : 0] gbe7bfd;
reg [RX_GEAR - 1 : 0] cmeff6f;
reg [RX_GEAR - 1 : 0] czfdbcc;
reg yxede65;
reg gb6f32c;
reg rg79964;
reg ofccb23;
reg sh6591d;
reg gd2c8ec;
reg th64764;
reg sj23b27;
reg kf1d93d;
reg rtec9ec;
reg dz64f66;
reg rv27b36;
reg db3d9b7;
reg hbecdbf;
reg zk66dfe;
reg [NUM_RX_LANE * RX_GEAR - 1 : 0] fpbfce2;
reg [NUM_RX_LANE * RX_GEAR - 1 : 0] pu9c59e;
reg ipe2cf3;
reg [2047:0] vi4d9f9;
wire [27:0] vi6cfcb;







localparam go67e5a = 28,ri3f2d1 = 32'hfdffc68b;
localparam [31:0] pff968b = ri3f2d1;
localparam zx5a2f1 = ri3f2d1 & 4'hf;
localparam [11:0] vx8bc71 = 'h7ff;
wire [(1 << zx5a2f1) -1:0] byf1c74;
reg [go67e5a-1:0] ld71d1f;
reg [zx5a2f1-1:0] xj747fe [0:1];
reg [zx5a2f1-1:0] uk1ffb1;
reg uiffd89;
integer hofec48;
integer jpf6242;

assign zz9eb1a = ksb928e & term_clk_en_o;
generate
if (RX_CLK_MODE == "HS_ONLY") begin  assign term_clk_en_o = 1'b1;
end
else begin  assign term_clk_en_o = ipe2cf3;  tu6c7d8 twbd8be (      .reset_n_i      (gbc9470),      .gq1f61b          (dz4a384),      .jcfb0d8      (yxede65),      .dzd86c3      (gb6f32c),      .qtc361f      (xjd7251),      .do1b0fd        (),      .nrd87ea        (lp_hs_state_clk_o)  );
end
endgenerate
tu6c7d8 pfc7edd (    .reset_n_i      (zk66dfe),    .gq1f61b          (clk_byte_fr_i),    .jcfb0d8      (rg79964),    .dzd86c3      (ofccb23),    .qtc361f      (term_d0_en_o),    .do1b0fd        (hs_d0_en_o),    .nrd87ea        (lp_hs_state_d_o)
);
generate
if (NUM_RX_LANE > 1) begin
tu6c7d8 rt5f574 (    .reset_n_i      (zk66dfe),    .gq1f61b          (clk_byte_fr_i),    .jcfb0d8      (sh6591d),    .dzd86c3      (gd2c8ec),    .qtc361f      (term_d1_en_o),    .do1b0fd        (hs_d1_en_o),    .nrd87ea        ()
);
end
else begin  assign term_d1_en_o = 1'b0;  assign hs_d1_en_o   = 1'b0;
end
if (NUM_RX_LANE > 2) begin
tu6c7d8 blcdecd (    .reset_n_i      (zk66dfe),    .gq1f61b          (clk_byte_fr_i),    .jcfb0d8      (th64764),    .dzd86c3      (sj23b27),    .qtc361f      (term_d2_en_o),    .do1b0fd        (hs_d2_en_o),    .nrd87ea        ()
);
end
else begin  assign term_d2_en_o = 1'b0;  assign hs_d2_en_o   = 1'b0;
end
if (NUM_RX_LANE > 3) begin
tu6c7d8 qgd419d (    .reset_n_i      (zk66dfe),    .gq1f61b          (clk_byte_fr_i),    .jcfb0d8      (kf1d93d),    .dzd86c3      (rtec9ec),    .qtc361f      (term_d3_en_o),    .do1b0fd        (hs_d3_en_o),    .nrd87ea        ()
);
end
else begin  assign term_d3_en_o = 1'b0;  assign hs_d3_en_o   = 1'b0;
end
endgenerate
generate    if (NUM_RX_LANE == 1)      assign ho635c9 = jr279ef[RX_GEAR-1:0];    else if (NUM_RX_LANE == 2) assign ho635c9 = {gbe7bfd[RX_GEAR-1:0], jr279ef[RX_GEAR-1:0]};    else if (NUM_RX_LANE == 3) assign ho635c9 = {cmeff6f[RX_GEAR-1:0], gbe7bfd[RX_GEAR-1:0], jr279ef[RX_GEAR-1:0]};    else if (NUM_RX_LANE == 4) assign ho635c9 = {czfdbcc[RX_GEAR-1:0], cmeff6f[RX_GEAR-1:0], gbe7bfd[RX_GEAR-1:0], jr279ef[RX_GEAR-1:0]};
endgenerate

always @(posedge clk_byte_fr_i or negedge reset_byte_fr_n_i)
begin    if (~reset_byte_fr_n_i)    begin        pll_lock_meta <= 0;        pll_lock_sync <= 0;    end    else    begin        pll_lock_meta <= mr709e7;        pll_lock_sync <= pll_lock_meta;    end
end
always @(posedge clk_byte_fr_i or negedge reset_byte_fr_n_i)
begin    if (~reset_byte_fr_n_i) begin        jee7ac    <= 0;        mta1cf5 <= 0;    end    else begin        jee7ac    <= hs_sync_o;        mta1cf5 <= db3d9b7;    end
end
always @(posedge clk_byte_fr_i or negedge reset_byte_fr_n_i)
begin    if (~reset_byte_fr_n_i)        dm73d63 <= 1;    else if (!db3d9b7 & rv27b36)        dm73d63 <= 1;    else        dm73d63 <= ~pll_lock_sync;


end
generate    if (RX_FIFO == "OFF")      begin : tudf31f        assign hs_sync_o = dz64f66;        assign bd0_o = jr279ef;        assign bd1_o = (NUM_RX_LANE > 1) ? gbe7bfd : 0;        assign bd2_o = (NUM_RX_LANE > 2) ? cmeff6f : 0;        assign bd3_o = (NUM_RX_LANE > 3) ? czfdbcc : 0;	end    else if (RX_FIFO == "ON")    begin : sjabbe2        ne5df15 #(            .NUM_RX_LANE       (NUM_RX_LANE),            .RX_GEAR           (RX_GEAR)        )        ne5df15 (            .qt5154e   (hbecdbf),            .clk_byte_i        (xl8e13c),            .clk_byte_fr_i     (clk_byte_fr_i),            .hs_sync_i         (dz64f66),            .bn38940              (fpbfce2),            .hs_sync_o         (hs_sync_o),            .dz40e5f              (uk1ae4a)        );        assign bd0_o = pu9c59e[RX_GEAR-1:0];


        if (NUM_RX_LANE > 1)            assign bd1_o = pu9c59e[RX_GEAR*2-1:RX_GEAR];        else            assign bd1_o = 0;        if (NUM_RX_LANE > 2)            assign bd2_o = pu9c59e[RX_GEAR*3-1:RX_GEAR*2];        else            assign bd2_o = 0;        if (NUM_RX_LANE > 3)            assign bd3_o = pu9c59e[RX_GEAR*4-1:RX_GEAR*3];        else            assign bd3_o = 0;    end
endgenerate

always@* begin ksb928e<=vi6cfcb[0];gbc9470<=vi6cfcb[1];dz4a384<=vi6cfcb[2];ip51c27<=vi6cfcb[3];xl8e13c<=vi6cfcb[4];mr709e7<=vi6cfcb[5];jr279ef<={bd0_i>>1,vi6cfcb[6]};gbe7bfd<={bd1_i>>1,vi6cfcb[7]};cmeff6f<={bd2_i>>1,vi6cfcb[8]};czfdbcc<={bd3_i>>1,vi6cfcb[9]};yxede65<=vi6cfcb[10];gb6f32c<=vi6cfcb[11];rg79964<=vi6cfcb[12];ofccb23<=vi6cfcb[13];sh6591d<=vi6cfcb[14];gd2c8ec<=vi6cfcb[15];th64764<=vi6cfcb[16];sj23b27<=vi6cfcb[17];kf1d93d<=vi6cfcb[18];rtec9ec<=vi6cfcb[19];dz64f66<=vi6cfcb[20];rv27b36<=vi6cfcb[21];db3d9b7<=vi6cfcb[22];hbecdbf<=vi6cfcb[23];zk66dfe<=vi6cfcb[24];fpbfce2<={ho635c9>>1,vi6cfcb[25]};pu9c59e<={uk1ae4a>>1,vi6cfcb[26]};ipe2cf3<=vi6cfcb[27];end
always@* begin vi4d9f9[2047]<=reset_lp_n_i;vi4d9f9[2046]<=clk_lp_ctrl_i;vi4d9f9[2044]<=clk_byte_hs_i;vi4d9f9[2040]<=clk_byte_i;vi4d9f9[2032]<=pll_lock_i;vi4d9f9[2017]<=bd0_i[0];vi4d9f9[1987]<=bd1_i[0];vi4d9f9[1926]<=bd2_i[0];vi4d9f9[1921]<=dm73d63;vi4d9f9[1805]<=bd3_i[0];vi4d9f9[1795]<=zz9eb1a;vi4d9f9[1679]<=lp_d2_p_i;vi4d9f9[1562]<=lp_clk_p_i;vi4d9f9[1543]<=ho635c9[0];vi4d9f9[1310]<=lp_d2_n_i;vi4d9f9[1144]<=lp_d3_n_i;vi4d9f9[1076]<=lp_clk_n_i;vi4d9f9[1039]<=uk1ae4a[0];vi4d9f9[1023]<=reset_n_i;vi4d9f9[960]<=jee7ac;vi4d9f9[839]<=lp_d1_n_i;vi4d9f9[572]<=lp_d3_p_i;vi4d9f9[480]<=mta1cf5;vi4d9f9[419]<=lp_d1_p_i;vi4d9f9[240]<=hs_sync_i;vi4d9f9[209]<=lp_d0_n_i;vi4d9f9[104]<=lp_d0_p_i;vi4d9f9[30]<=xjd7251;end         assign byf1c74 = vi4d9f9,vi6cfcb = ld71d1f; initial begin hofec48 = $fopen(".fred"); $fdisplay( hofec48, "%3h\n%3h", (pff968b >> 4) & vx8bc71, (pff968b >> (zx5a2f1+4)) & vx8bc71 ); $fclose(hofec48); $readmemh(".fred", xj747fe); end always @ (byf1c74) begin uk1ffb1 = xj747fe[1]; for (jpf6242=0; jpf6242<go67e5a; jpf6242=jpf6242+1) begin ld71d1f[jpf6242] = byf1c74[uk1ffb1]; uiffd89 = ^(uk1ffb1 & xj747fe[0]); uk1ffb1 = {uk1ffb1, uiffd89}; end end 
endmodule

















































`timescale 1 ns / 100 ps
module ne5df15 #(
	parameter NUM_RX_LANE = 4,	parameter RX_GEAR = 16
)
(
    input  wire                          qt5154e,
    input  wire                          clk_byte_i,
    input  wire                          hs_sync_i,
    input  wire [NUM_RX_LANE*RX_GEAR-1:0] bn38940,

    input  wire                          clk_byte_fr_i,
    output wire                           hs_sync_o,
    output wire [NUM_RX_LANE*RX_GEAR-1:0] dz40e5f
);
localparam  ble9754 = 8;
wire  ip4baa7;
reg   rg5d53c, wwea9e3;
reg xl8e13c;
reg dz64f66;
reg [NUM_RX_LANE * RX_GEAR - 1 : 0] lf198e6;
reg yxcc736;
reg ps639b4;
reg nt1cda3;
reg [2047:0] vi4d9f9;
wire [5:0] vi6cfcb;


localparam go67e5a = 6,ri3f2d1 = 32'hfdffca8b;
localparam [31:0] pff968b = ri3f2d1;
localparam zx5a2f1 = ri3f2d1 & 4'hf;
localparam [11:0] vx8bc71 = 'h7ff;
wire [(1 << zx5a2f1) -1:0] byf1c74;
reg [go67e5a-1:0] ld71d1f;
reg [zx5a2f1-1:0] xj747fe [0:1];
reg [zx5a2f1-1:0] uk1ffb1;
reg uiffd89;
integer hofec48;
integer jpf6242;

assign  hs_sync_o = nt1cda3;

always @(posedge clk_byte_fr_i or posedge qt5154e)
begin    if (qt5154e)    begin        rg5d53c <= 0;        wwea9e3 <= 0;    end    else    begin        rg5d53c <= ~yxcc736;        wwea9e3 <= ps639b4;    end
end

pmi_fifo_dc #(    .pmi_data_width_w       (NUM_RX_LANE*RX_GEAR),    .pmi_data_width_r       (NUM_RX_LANE*RX_GEAR),    .pmi_data_depth_w       (ble9754),    .pmi_data_depth_r       (ble9754),    .pmi_full_flag          (ble9754),    .pmi_empty_flag         (0),    .pmi_almost_full_flag   (ble9754-1),    .pmi_almost_empty_flag  (1),    .pmi_regmode            ("reg"),    .pmi_resetmode          ("async"),    .pmi_family             ("LIFDB1"),    .module_type            ("pmi_fifo_dc"),    .pmi_implementation     ("EBR")
)
uxa4194 (    .Data         (bn38940),    .WrClock      (clk_byte_i),    .RdClock      (clk_byte_fr_i),    .WrEn         (hs_sync_i),    .RdEn         (~ip4baa7),    .Reset        (qt5154e),    .RPReset      (1'b0),    .Q            (dz40e5f),    .Empty        (ip4baa7),    .Full         (),    .AlmostEmpty  (),    .AlmostFull   ()
);

always@* begin xl8e13c<=vi6cfcb[0];dz64f66<=vi6cfcb[1];lf198e6<={bn38940>>1,vi6cfcb[2]};yxcc736<=vi6cfcb[3];ps639b4<=vi6cfcb[4];nt1cda3<=vi6cfcb[5];end
always@* begin vi4d9f9[2047]<=hs_sync_i;vi4d9f9[2046]<=bn38940[0];vi4d9f9[2044]<=ip4baa7;vi4d9f9[2040]<=rg5d53c;vi4d9f9[2032]<=wwea9e3;vi4d9f9[1023]<=clk_byte_i;end         assign byf1c74 = vi4d9f9,vi6cfcb = ld71d1f; initial begin hofec48 = $fopen(".fred"); $fdisplay( hofec48, "%3h\n%3h", (pff968b >> 4) & vx8bc71, (pff968b >> (zx5a2f1+4)) & vx8bc71 ); $fclose(hofec48); $readmemh(".fred", xj747fe); end always @ (byf1c74) begin uk1ffb1 = xj747fe[1]; for (jpf6242=0; jpf6242<go67e5a; jpf6242=jpf6242+1) begin ld71d1f[jpf6242] = byf1c74[uk1ffb1]; uiffd89 = ^(uk1ffb1 & xj747fe[0]); uk1ffb1 = {uk1ffb1, uiffd89}; end end 
endmodule
