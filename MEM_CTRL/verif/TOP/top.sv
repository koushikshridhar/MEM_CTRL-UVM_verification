module top;

  logic clk_i;
  logic mc_clk_i;
  logic rst;

  wire [31:0] mc_dq;

  `include "tb_checkers.sv"

  // Read : doe = 0 ; data comes from memory to memory_ctrl
  assign mc_mem_pif.mc_data_pad_i  = (mc_mem_pif.mc_doe_pad_doe_o == 0) ? mc_dq : 32'hZ;
  assign mc_dq = (mc_mem_pif.mc_doe_pad_doe_o == 1) ? mc_mem_pif.mc_data_pad_o  : 32'hZ;

  //Note : Goal to run WISHBONE bus at twice the speed of Memory Bus
  // clk_i clock generation at 200 MHz (~5.0ns)
  initial clk_i = 0;
  always #2.5 clk_i = ~clk_i;

  // mc_clk_i clock generation at 100 MHz (~10.0ns)
  initial mc_clk_i = 0;
  always #5.0 mc_clk_i = ~mc_clk_i;


  //rst logic to mc
  initial begin
  	rst = 1;
	repeat(5) @(posedge clk_i);
	rst = 0;
  end

  // Interface Instantiations
  wb_if wb_pif(clk_i, rst);  
  mc_mem_intf mc_mem_pif(mc_clk_i);  

  // DUT instantiation
  mc_top mc_top_dut(
		.clk_i(wb_pif.clk_i), 
		.rst_i(wb_pif.rst_i),

		// WISHBONE INTERFACE 
		.wb_data_i(wb_pif.wb_data_i), 
		.wb_data_o(wb_pif.wb_data_o), 
		.wb_addr_i(wb_pif.wb_addr_i), 
		.wb_sel_i(wb_pif.wb_sel_i), 
		.wb_we_i(wb_pif.wb_we_i), 
		.wb_cyc_i(wb_pif.wb_cyc_i),
		
		.wb_stb_i(wb_pif.wb_stb_i), 
		.wb_ack_o(wb_pif.wb_ack_o), 
		.wb_err_o(wb_pif.wb_err_o), 

		// Suspend Resume Interface
		.susp_req_i(wb_pif.susp_req_i), 
		.resume_req_i(wb_pif.resume_req_i), 
		.suspended_o(wb_pif.suspended_o), 

		//POC
		.poc_o(wb_pif.poc_o),

		// Memory Bus Signals
		.mc_clk_i(mc_mem_pif.mc_clk_i), 
		.mc_br_pad_i(mc_mem_pif.mc_br_pad_i), 
		.mc_bg_pad_o(mc_mem_pif.mc_bg_pad_o), 
		.mc_ack_pad_i(mc_mem_pif.mc_ack_pad_i),
		
		.mc_addr_pad_o(mc_mem_pif.mc_addr_pad_o), 
		.mc_data_pad_i(mc_mem_pif.mc_data_pad_i), 
		.mc_data_pad_o(mc_mem_pif.mc_data_pad_o), 
		.mc_dp_pad_i(mc_mem_pif.mc_dp_pad_i),
		
		.mc_dp_pad_o(mc_mem_pif.mc_dp_pad_o), 
		.mc_doe_pad_doe_o(mc_mem_pif.mc_doe_pad_doe_o), 
		.mc_dqm_pad_o(mc_mem_pif.mc_dqm_pad_o), 
		.mc_oe_pad_o_(mc_mem_pif.mc_oe_pad_o_),
		
		.mc_we_pad_o_(mc_mem_pif.mc_we_pad_o_), 
		.mc_cas_pad_o_(mc_mem_pif.mc_cas_pad_o_), 
		.mc_ras_pad_o_(mc_mem_pif.mc_ras_pad_o_), 
		.mc_cke_pad_o_(mc_mem_pif.mc_cke_pad_o_),
		
		.mc_cs_pad_o_(mc_mem_pif.mc_cs_pad_o_), 
		.mc_sts_pad_i(mc_mem_pif.mc_sts_pad_i), 
		.mc_rp_pad_o_(mc_mem_pif.mc_rp_pad_o_), 
		.mc_vpen_pad_o(mc_mem_pif.mc_vpen_pad_o),
		
		.mc_adsc_pad_o_(mc_mem_pif.mc_adsc_pad_o_), 
		.mc_adv_pad_o_(mc_mem_pif.mc_adv_pad_o_), 
		.mc_zz_pad_o(mc_mem_pif.mc_zz_pad_o), 
		.mc_coe_pad_coe_o(mc_mem_pif.mc_coe_pad_coe_o)
	);

	//Memory instance
	`ifdef FLASH
		`include "flash_mem_inst.sv"
	`elsif FLASH_BW8
		`include "flash_mem_bw8_inst.sv"
	`elsif FLASH_BW16
		`include "flash_mem_bw16_inst.sv"
	`endif

  // UVM run_test() call
  initial begin
    //run_test("mc_base_test");
    //run_test("mc_reset_test");
    //run_test("mc_reg_access_test");
	 //run_test("mc_flash_access_test");
	 //run_test("mc_flash_wr_protect_test");
	 //run_test("mc_flash_sleep_test");
	 //run_test("mc_flash_vpen_test");
	 //run_test("mc_flash_dyn_bus_size_8_bit_test");
	 run_test("mc_flash_dyn_bus_size_16_bit_test");
  end

  // Passing interfaces to UVM via uvm_config_db
  initial begin
    uvm_config_db#(virtual wb_if)::set(null, "*", "vif", wb_pif);
    uvm_config_db#(virtual mc_mem_intf)::set(null, "*", "vif", mc_mem_pif);
  end

	initial begin
		$fsdbDumpfile("mc_db.fsdb"); //filename under which fsdb will be saved. 
		$fsdbDumpvars(0,top); //from top hierarchy all the signals will be logged
	end

endmodule
