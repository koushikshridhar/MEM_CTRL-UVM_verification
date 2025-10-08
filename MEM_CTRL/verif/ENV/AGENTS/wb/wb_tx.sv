// ----------------------------------------------------
//UVM uvm_sequence_item: wb_tx
//----------------------------------------------------
class wb_tx extends uvm_sequence_item;

//wb tx fields
rand bit wr_rd;
rand bit [31:0] addr;
rand bit [31:0] data;// wr_data and rd_data
rand bit reg_mem_f;
rand bit [7:0] cs;


//factory + field registeration
`uvm_object_utils_begin(wb_tx)
	`uvm_field_int(wr_rd, UVM_ALL_ON)	
	`uvm_field_int(addr, UVM_ALL_ON)	
	`uvm_field_int(data, UVM_ALL_ON)	
`uvm_object_utils_end

//constructor
function new(string name = "wb_tx");
  super.new(name);
endfunction


constraint addr_c{
	if(reg_mem_f == 1) {
	 soft addr[31:29] == 3'h7;
	}
	else {
	 soft addr[31:29] == 3'h0;
	}
}

constraint aadr_range_c{
	(reg_mem_f == 0 && cs[0]) -> soft ( addr[28:0] inside {[`CS0_START_ADDR : `CS0_END_ADDR]} );
	(reg_mem_f == 0 && cs[1]) -> soft ( addr[28:0] inside {[`CS1_START_ADDR : `CS1_END_ADDR]} );
	(reg_mem_f == 0 && cs[2]) -> soft ( addr[28:0] inside {[`CS2_START_ADDR : `CS2_END_ADDR]} );
	(reg_mem_f == 0 && cs[3]) -> soft ( addr[28:0] inside {[`CS3_START_ADDR : `CS3_END_ADDR]} );
	(reg_mem_f == 0 && cs[4]) -> soft ( addr[28:0] inside {[`CS4_START_ADDR : `CS4_END_ADDR]} );
	(reg_mem_f == 0 && cs[5]) -> soft ( addr[28:0] inside {[`CS5_START_ADDR : `CS5_END_ADDR]} );
	(reg_mem_f == 0 && cs[6]) -> soft ( addr[28:0] inside {[`CS6_START_ADDR : `CS6_END_ADDR]} );
	(reg_mem_f == 0 && cs[7]) -> soft ( addr[28:0] inside {[`CS7_START_ADDR : `CS7_END_ADDR]} );
}
endclass
