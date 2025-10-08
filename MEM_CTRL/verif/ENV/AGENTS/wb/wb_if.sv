interface wb_if(input bit clk_i, rst_i);

// WISHBONE SLAVE INTERFACE 
logic	[31:0]	wb_data_i;
logic	[31:0]	wb_data_o;
logic	[31:0]	wb_addr_i;
logic	[3:0]		wb_sel_i;
logic				wb_we_i;
logic				wb_cyc_i;
logic				wb_stb_i;
logic				wb_ack_o;
logic				wb_err_o;

// Suspend Resume Interface
logic				susp_req_i;
logic				resume_req_i;
logic				suspended_o;

// POC
logic	[31:0]	poc_o;

clocking wb_drv_cb@(posedge clk_i);
	default input #0 output #1;
   output wb_addr_i;
   output wb_data_i;
   input wb_data_o;
   output wb_we_i;
   output wb_stb_i;
   output wb_cyc_i;
   output wb_sel_i;
   input wb_ack_o;
   input wb_err_o;
endclocking

clocking wb_mon_cb@(posedge clk_i);
	default input #1 output #0;
   input wb_addr_i;
   input wb_data_i;
   input wb_data_o;
   input wb_we_i;
   input wb_stb_i;
   input wb_cyc_i;
   input wb_sel_i;
   input wb_ack_o;
   input wb_err_o;
endclocking


endinterface
