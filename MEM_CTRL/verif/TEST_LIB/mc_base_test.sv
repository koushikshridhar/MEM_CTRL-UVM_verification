 // ----------------------------------------------------
 // UVM Test: mc_base_test
 // ----------------------------------------------------
 class mc_base_test extends uvm_test;
   `uvm_component_utils(mc_base_test)

   // Environment handle
   mc_env mc_env_h;

   function new(string name = "mc_base_test", uvm_component parent = null);
     super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
  	mc_env_h = mc_env::type_id::create("mc_env_h", this);
   endfunction

	virtual function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction

   virtual task run_phase(uvm_phase phase);
     mc_base_seq seq = mc_base_seq::type_id::create("seq");
	  `uvm_info(get_full_name(),"Run_phase started", UVM_NONE)

     phase.raise_objection(this);

	  //Wb sqr PATH : mc_env_h.wb_agent_h.wb_sqr_h
     seq.start(mc_env_h.wb_agent_h.wb_sqr_h);

  	phase.phase_done.set_drain_time(this,1000);
  	phase.drop_objection(this);

  	`uvm_info(get_full_name(),"Run_phase End", UVM_NONE)

   endtask

	task load_mem();
		`ifdef BD_FLASH_BW32
			//read from file & Write to mem	
			$readmemh("../SIM/image_0.hex", top.genblk1[0].flash_mem_inst_0.mem_array, 0, 8191);	
			$readmemh("../SIM/image_1.hex", top.genblk1[0].flash_mem_inst_1.mem_array, 0, 8191);	
			$readmemh("../SIM/image_2.hex", top.genblk1[0].flash_mem_inst_2.mem_array, 0, 8191);	
			$readmemh("../SIM/image_3.hex", top.genblk1[0].flash_mem_inst_3.mem_array, 0, 8191);	
			`uvm_info("Load_mem", "BackDoor Load to 4-FLASH Memory's (BW is 32) is Completed", UVM_NONE);
		`elsif BD_FLASH_BW8
			//read from file & Write to mem	
			$readmemh("../SIM/image_0.hex", top.flash_mem_bw8_inst.mem_array, 0, 8191);	
			`uvm_info("Load_mem", "BackDoor Load to FLASH Memory (BW is 8) is Completed", UVM_NONE);
		`elsif BD_FLASH_BW16
			$readmemh("../SIM/image_0.hex", top.flash_mem_bw16_inst_1.mem_array, 0, 8191);	
			$readmemh("../SIM/image_1.hex", top.flash_mem_bw16_inst_2.mem_array, 0, 8191);	
			`uvm_info("Load_mem", "BackDoor Load to 2-FLASH Memory (BW is 16) is Completed", UVM_NONE);
		`endif
	endtask


 endclass : mc_base_test
