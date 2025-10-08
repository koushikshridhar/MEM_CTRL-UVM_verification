// ----------------------------------------------------
//UVM sequence: mc_base_seq
//----------------------------------------------------
class mc_base_seq extends uvm_sequence#(wb_tx);
`uvm_object_utils(mc_base_seq)
bit [28:0] reg_addr[16] = '{`CSC0_ADDR, `TMS0_ADDR, 
								  	 `CSC1_ADDR, `TMS1_ADDR,
								  	 `CSC2_ADDR, `TMS2_ADDR,
								  	 `CSC3_ADDR, `TMS3_ADDR,
								  	 `CSC4_ADDR, `TMS4_ADDR,
								  	 `CSC5_ADDR, `TMS5_ADDR,
								  	 `CSC6_ADDR, `TMS6_ADDR,
								  	 `CSC7_ADDR, `TMS7_ADDR
								  };
bit [31:0] addr_q [$];

function new(string name = "mc_base_seq");
  super.new(name);
endfunction

virtual task body();
  `uvm_info(get_type_name(), "Starting mc_base_seq", UVM_NONE)
  //Randomizing req
  `uvm_do_with(req, {req.addr[28:0] == 0;
       					req.wr_rd == 1;})
endtask

virtual task mc_reg_wr_rd(string cmd_t = "RD", bit [28:0] addr_t, bit [31:0] data_t = 0);
  if(cmd_t == "WR") begin
	  `uvm_do_with(req, {req.addr[28:0] == addr_t;
	       					req.wr_rd == 1;
								req.data== data_t;
								req.reg_mem_f == 1;
								})
  end
  else begin // cmd_t == "RD"
	  `uvm_do_with(req, {req.addr[28:0] == addr_t;
	       					req.wr_rd == 0;
								req.reg_mem_f == 1;
								})
  end

endtask

//TODO - Use mc_prog task 
virtual task mc_prog(string access_type = "REG", 
							string cmd_t = "RD", 
							bit [28:0] addr_t = 'h0, 
							bit [31:0] data_t = 0, 
							bit [31:0] data_mask_t = 'hF, 
							bit [7:0] cs_t = 8'b0000_0000
							);
	bit [31:0] addr_temp;
	if(access_type == "REG") begin
		data_t = data_t & data_mask_t;
		if(cmd_t == "WR") begin
		  `uvm_do_with(req, {req.addr[28:0] == addr_t;
		       					req.wr_rd == 1;
									req.data== data_t;
									req.reg_mem_f == 1;
									})
		end
   	else begin // cmd_t == "RD"
   	   `uvm_do_with(req, {req.addr[28:0] == addr_t;
   	        					req.wr_rd == 0;
   	 							req.reg_mem_f == 1;
   	 							})
   	end
   end
	else begin // access_type = MEM
		if(cmd_t == "WR") begin
		  `uvm_do_with(req, {req.cs == cs_t;
		       					req.wr_rd == 1;
									req.reg_mem_f == 0;
									})
			addr_q.push_back(req.addr);
		end
   	else begin // cmd_t == "RD"
			$display("DEBUG : addr_q = %p", addr_q);
			addr_temp = addr_q.pop_front();
		  `uvm_do_with(req, {req.cs == cs_t;
		       					req.wr_rd == 0;
									req.reg_mem_f == 0;
									req.addr == addr_temp;
									})
   	end
	end
endtask

endclass : mc_base_seq
