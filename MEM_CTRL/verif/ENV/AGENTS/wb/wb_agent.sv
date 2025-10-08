// ----------------------------------------------------
//UVM agent: wb_agent
//----------------------------------------------------
class wb_agent extends uvm_agent;
`uvm_component_utils(wb_agent)

//Sub-Component Instantiation
wb_drv wb_drv_h;
wb_sqr wb_sqr_h;
wb_mon wb_mon_h;
wb_cov wb_cov_h;

function new(string name = "wb_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  wb_mon_h = wb_mon::type_id::create("wb_mon_h", this);
  wb_cov_h = wb_cov::type_id::create("wb_cov_h", this);
  wb_drv_h = wb_drv::type_id::create("wb_drv_h", this);
  wb_sqr_h = wb_sqr::type_id::create("wb_sqr_h", this);
endfunction

virtual function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  wb_drv_h.seq_item_port.connect(wb_sqr_h.seq_item_export);
  wb_mon_h.wb_ap_h.connect(wb_cov_h.analysis_export);
endfunction

endclass : wb_agent
