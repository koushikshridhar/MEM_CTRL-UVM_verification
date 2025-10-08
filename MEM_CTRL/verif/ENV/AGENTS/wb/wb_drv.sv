// ----------------------------------------------------
//UVM drv: wb_drv
//----------------------------------------------------
class wb_drv extends uvm_driver#(wb_tx);
`uvm_component_utils(wb_drv)

virtual wb_if wb_vif;

function new(string name = "wb_drv", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(virtual wb_if)::get(this,"","vif",wb_vif))
     `uvm_error(get_full_name(),"FAILED TO RETRIVE VIF HANDLE FROM CONFIG_DB")
endfunction : build_phase

virtual task run_phase(uvm_phase phase);
wait(wb_vif.rst_i == 0);
`uvm_info(get_full_name(),"run_phase START",UVM_NONE)
  forever begin
    seq_item_port.get_next_item(req);
    //req.print();
    drive_tx(req);
    seq_item_port.item_done();
  end
endtask : run_phase

task drive_tx(wb_tx tx);
  @(wb_vif.wb_drv_cb);
  wb_vif.wb_drv_cb.wb_addr_i <= tx.addr;
  wb_vif.wb_drv_cb.wb_we_i <= tx.wr_rd;
  if(tx.wr_rd) wb_vif.wb_drv_cb.wb_data_i <= tx.data; 
  wb_vif.wb_drv_cb.wb_sel_i <= 4'hF;
  wb_vif.wb_drv_cb.wb_cyc_i <= 1;
  wb_vif.wb_drv_cb.wb_stb_i <= 1;
  wait(wb_vif.wb_drv_cb.wb_ack_o);
  if(tx.wr_rd == 0) tx.data = wb_vif.wb_data_o; 
  `uvm_info(get_name(), $sformatf("WB_DRV : access_type = %s cs = %b addr = %h  wr_rd = %s  data = %h",tx.reg_mem_f ? "REG" : "MEM", tx.cs, tx.addr, tx.wr_rd ? "WR" : "RD", tx.data), UVM_HIGH)
  wb_vif.wb_drv_cb.wb_sel_i <= 4'h0;
  wb_vif.wb_drv_cb.wb_cyc_i <= 0;
  wb_vif.wb_drv_cb.wb_stb_i <= 0;
endtask : drive_tx

endclass : wb_drv
