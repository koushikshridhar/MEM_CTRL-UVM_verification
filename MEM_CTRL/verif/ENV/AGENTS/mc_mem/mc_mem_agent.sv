// ----------------------------------------------------
//UVM agent: mc_mem_agent
//----------------------------------------------------
class mc_mem_agent extends uvm_agent;
`uvm_component_utils(mc_mem_agent)

//Sub-Component Instantiation
mc_mem_mon mc_mem_mon_h;
mc_mem_cov mc_mem_cov_h;

function new(string name = "mc_mem_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  mc_mem_mon_h = mc_mem_mon::type_id::create("mc_mem_mon_h", this);
  mc_mem_cov_h = mc_mem_cov::type_id::create("mc_mem_cov_h", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  mc_mem_mon_h.mc_mem_ap_h.connect(mc_mem_cov_h.analysis_export);
endfunction

endclass : mc_mem_agent
