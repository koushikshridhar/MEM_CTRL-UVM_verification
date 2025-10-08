// ----------------------------------------------------
//UVM mon: mc_mem_mon
//----------------------------------------------------
class mc_mem_mon extends uvm_monitor;
`uvm_component_utils(mc_mem_mon)

virtual mc_mem_intf mc_mem_vif;

uvm_analysis_port#(mc_mem_tx) mc_mem_ap_h;

mc_mem_tx tx;

function new(string name = "mc_mem_mon", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  tx = mc_mem_tx::type_id::create("tx");
  mc_mem_ap_h = new("mc_mem_ap_h",this);
  if(!uvm_config_db#(virtual mc_mem_intf)::get(this,"","vif",mc_mem_vif))
     `uvm_error(get_full_name(),"FAILED TO RETRIVE VIF HANDLE FROM CONFIG_DB")
endfunction : build_phase

virtual task run_phase(uvm_phase phase);
`uvm_info(get_full_name(),"run_phase START",UVM_NONE)
  //forever begin
  //  //TODO: Implement mc_mem specific mon logic functionality
  //  mc_mem_ap_h.write(tx);
  //end
endtask : run_phase

endclass : mc_mem_mon
