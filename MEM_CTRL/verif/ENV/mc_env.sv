// ----------------------------------------------------
// UVM Environment: mc_env
// ----------------------------------------------------
class mc_env extends uvm_env;
	`uvm_component_utils(mc_env)

	//Agents instantiation
	wb_agent wb_agent_h;
	mc_mem_agent mc_mem_agent_h;

	//Scoreboard instantiation
	//mc_sbd mc_sbd_h;

	function new(string name = "mc_env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wb_agent_h = wb_agent::type_id::create("wb_agent_h", this);
		mc_mem_agent_h = mc_mem_agent::type_id::create("mc_mem_agent_h", this);
		//mc_sbd_h = mc_sbd::type_id::create("mc_sbd_h", this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
  		//TODO - Check the SBD connection
		//wb_agent_h.wb_h.wb_ap_h.connect(mc_sbd_h.analysis_export);
  		//TODO - Check the SBD connection
		//mc_mem_agent_h.mc_mem_h.mc_mem_ap_h.connect(mc_sbd_h.analysis_export);
	endfunction

endclass : mc_env
