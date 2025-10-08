// ----------------------------------------------------
//UVM uvm_sequence_item: mc_mem_tx
//----------------------------------------------------
class mc_mem_tx extends uvm_sequence_item;

//wb tx fields
rand bit wr_rd;
rand bit [31:0] addr;
rand bit [31:0] data;// wr_data and rd_data

//factory + field registeration
`uvm_object_utils_begin(mc_mem_tx)
	`uvm_field_int(wr_rd, UVM_ALL_ON)	
	`uvm_field_int(addr, UVM_ALL_ON)	
	`uvm_field_int(data, UVM_ALL_ON)	
`uvm_object_utils_end

//constructor
function new(string name = "mc_mem_tx");
  super.new(name);
endfunction


endclass

