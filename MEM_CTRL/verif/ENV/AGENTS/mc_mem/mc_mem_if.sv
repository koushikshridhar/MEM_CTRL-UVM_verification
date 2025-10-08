interface mc_mem_intf(input bit mc_clk_i);
// Memory Bus Signals
logic				mc_br_pad_i;
logic				mc_bg_pad_o;
logic				mc_ack_pad_i;
logic [23:0]	mc_addr_pad_o;
logic	[31:0]	mc_data_pad_i;
logic [31:0]	mc_data_pad_o;
logic	[3:0]	mc_dp_pad_i;
logic [3:0]		mc_dp_pad_o;
logic				mc_doe_pad_doe_o;
logic [3:0]		mc_dqm_pad_o;
logic				mc_oe_pad_o_;
logic				mc_we_pad_o_;
logic				mc_cas_pad_o_;
logic				mc_ras_pad_o_;
logic				mc_cke_pad_o_;
logic [7:0]		mc_cs_pad_o_;
logic		   	mc_sts_pad_i;
logic				mc_rp_pad_o_;
logic				mc_vpen_pad_o;
logic				mc_adsc_pad_o_;
logic				mc_adv_pad_o_;
logic				mc_zz_pad_o;
logic				mc_coe_pad_coe_o;




endinterface
