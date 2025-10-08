// ----------------------------------------------------
//UVM sequence: mc_reg_access_seq
//----------------------------------------------------
class mc_reg_access_seq extends mc_base_seq; 
`uvm_object_utils(mc_reg_access_seq)

function new(string name = "mc_reg_access_seq");
  super.new(name);
endfunction

virtual task body();
	bit [31:0] data;
  `uvm_info(get_type_name(), "Starting mc_reg_access_seq", UVM_NONE)

	//WR
	//CSR Reg
	data = $random() & `CSR_MASK; 
	$display("ADDR = %h",`CSR_ADDR);
	mc_reg_wr_rd("WR",`CSR_ADDR , data);

	//POC Reg
	data = $random() & `POC_MASK; 
	mc_reg_wr_rd("WR",`POC_ADDR , data);

	//BA_MASK Reg
	data = $random() & `BA_MASK_MASK; 
	mc_reg_wr_rd("WR",`BA_MASK_ADDR , data);

	//CSCn Reg and TMSn Reg
	for(int i = 0; i < 16; i++) begin
		if ((i % 2) == 0) begin // selects CSCn address
			//CSCn Reg 
			data = $random() & `CSCn_MASK; 
			mc_reg_wr_rd("WR", reg_addr[i] , data);
		end
		else begin // selects TMSn address 
			//TMSn Reg
			data = $random() & `TMSn_MASK; 
			mc_reg_wr_rd("WR", reg_addr[i] , data);
		end
	end

	//RD
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
endclass : mc_reg_access_seq

