// ----------------------------------------------------
//UVM cov: mc_mem_cov
//----------------------------------------------------
class mc_mem_cov extends uvm_subscriber#(mc_mem_tx);
`uvm_component_utils(mc_mem_cov)

mc_mem_tx tx;

//covergroup cg;
//  //TODO - Implement protocol specific FC
//
//endgroup

function new(string name = "mc_mem_cov", uvm_component parent = null);
  super.new(name, parent);
  //cg = new();
endfunction : new

virtual function void write(T t);
  $cast(tx,t);
  //cg.sample();
endfunction : write

endclass : mc_mem_cov
