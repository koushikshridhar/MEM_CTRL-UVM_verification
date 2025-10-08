// ----------------------------------------------------
//UVM mon: wb_mon
//----------------------------------------------------
class wb_mon extends uvm_monitor;
`uvm_component_utils(wb_mon)

virtual wb_if wb_vif;

uvm_analysis_port#(wb_tx) wb_ap_h;

wb_tx tx;

function new(string name = "wb_mon", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  tx = wb_tx::type_id::create("tx");
  wb_ap_h = new("wb_ap_h",this);
  if(!uvm_config_db#(virtual wb_if)::get(this,"","vif",wb_vif))
     `uvm_error(get_full_name(),"FAILED TO RETRIVE VIF HANDLE FROM CONFIG_DB")
endfunction : build_phase

virtual task run_phase(uvm_phase phase);
`uvm_info(get_full_name(),"run_phase START",UVM_NONE)
  forever begin
	 @(wb_vif.wb_mon_cb);
	 if(wb_vif.wb_mon_cb.wb_cyc_i && wb_vif.wb_mon_cb.wb_stb_i && wb_vif.wb_mon_cb.wb_ack_o) begin
		tx.addr = wb_vif.wb_mon_cb.wb_addr_i;
		tx.wr_rd = wb_vif.wb_mon_cb.wb_we_i;
		tx.data = tx.wr_rd ? wb_vif.wb_mon_cb.wb_data_i : wb_vif.wb_mon_cb.wb_data_o;
		//tx.print();
		`uvm_info(get_name(), $sformatf("WB_MON : addr = %h  wr_rd = %s  data = %h",tx.addr,tx.wr_rd ? "WR" : "RD", tx.data), UVM_HIGH);
    	wb_ap_h.write(tx);
	 end
  end
endtask : run_phase

endclass : wb_mon
