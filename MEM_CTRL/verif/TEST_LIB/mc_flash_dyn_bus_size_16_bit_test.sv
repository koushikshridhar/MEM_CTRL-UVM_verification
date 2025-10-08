 // ----------------------------------------------------
 // UVM Test: mc_flash_dyn_bus_size_16_bit_test
 // ----------------------------------------------------
 class mc_flash_dyn_bus_size_16_bit_test extends mc_base_test;
   `uvm_component_utils(mc_flash_dyn_bus_size_16_bit_test)

   function new(string name = "mc_flash_dyn_bus_size_16_bit_test", uvm_component parent = null);
     super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
   endfunction

   virtual task run_phase(uvm_phase phase);
     mc_flash_dyn_bus_size_16_bit_seq seq = mc_flash_dyn_bus_size_16_bit_seq::type_id::create("seq");

	  //back_door memory load
	  load_mem();

	  `uvm_info(get_full_name(),"Run_phase started", UVM_NONE)

     phase.raise_objection(this);

	  //Wb sqr PATH : mc_env_h.wb_agent_h.wb_sqr_h
     seq.start(mc_env_h.wb_agent_h.wb_sqr_h);

  	phase.phase_done.set_drain_time(this,1000);
  	phase.drop_objection(this);

  	`uvm_info(get_full_name(),"Run_phase End", UVM_NONE)

   endtask


 endclass : mc_flash_dyn_bus_size_16_bit_test



