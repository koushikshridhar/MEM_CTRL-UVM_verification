// ----------------------------------------------------
//UVM sequence: mc_reset_seq
//----------------------------------------------------
class mc_reset_seq extends mc_base_seq; 
`uvm_object_utils(mc_reset_seq)

function new(string name = "mc_reset_seq");
  super.new(name);
endfunction

virtual task body();
  `uvm_info(get_type_name(), "Starting mc_reset_seq", UVM_NONE)

  //RD registers after reset
  
  //CSR Reg
  mc_reg_wr_rd("RD",`CSR_ADDR , );
  
  //POC Reg
  mc_reg_wr_rd("RD",`POC_ADDR , );
  
  //BA_MASK Reg
  mc_reg_wr_rd("RD",`BA_MASK_ADDR , );
  
  //CSCn Reg and TMSn Reg
  for(int i = 0; i < 16; i++) begin
  	if ((i % 2) == 0) begin // selects CSCn address
  		//CSCn Reg 
  		mc_reg_wr_rd("RD", reg_addr[i] , );
  	end
  	else begin // selects TMSn address 
  		//TMSn Reg
  		mc_reg_wr_rd("RD", reg_addr[i] , );
  	end
  end
endtask

endclass : mc_reset_seq

