// ----------------------------------------------------
//UVM cov: wb_cov
//----------------------------------------------------
class wb_cov extends uvm_subscriber#(wb_tx);
`uvm_component_utils(wb_cov)

wb_tx tx;

covergroup cg;
  ADDR_CP : coverpoint tx.addr;
  WR_RD_CP : coverpoint tx.wr_rd;
  //ADDR_CP_X_WR_RD_CP : coverpoint ADDR_CP,WR_RD_CP;
endgroup

function new(string name = "wb_cov", uvm_component parent = null);
  super.new(name, parent);
  cg = new();
endfunction : new

virtual function void write(T t);
  $cast(tx,t);
  cg.sample();
endfunction : write

endclass : wb_cov
