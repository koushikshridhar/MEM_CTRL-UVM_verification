// ----------------------------------------------------
//UVM sequence: mc_flash_wr_protect_seq
//----------------------------------------------------
class mc_flash_wr_protect_seq extends mc_base_seq; 
`uvm_object_utils(mc_flash_wr_protect_seq)

rand bit [31:0] addr_list[];
int unsigned num_addrs = 20;

// --- Constraints ---
constraint c_size {
  addr_list.size() == num_addrs;
}

// Byte-addressed range
constraint c_range {
  foreach (addr_list[i])
    addr_list[i] inside {[`CS0_START_ADDR : `CS0_END_ADDR]};
}

// Word-aligned: each transfer stores 4 bytes, so LSBs must be 00
constraint c_word_aligned {
  foreach (addr_list[i])
    addr_list[i][1:0] == 2'b00;
}

// Unique addresses only
constraint c_unique {
  unique { addr_list };
}

function new(string name = "mc_flash_wr_protect_seq");
  super.new(name);
endfunction

virtual task body();
	bit [31:0] data;
  `uvm_info(get_type_name(), "Starting mc_flash_wr_protect_seq", UVM_NONE)

  //REG Programming
  //WR
  //CSR
  data[31:24] = 8'h00;
  data[10:8]  = 3'b000;
  data[2]     = 1'b0;// Flash Not in Power down 
  data[1]     = 1'b0;
  data[0]     = 1'b0;
  mc_prog("REG","WR", `CSR_ADDR, data, `CSR_MASK, );

  //BA_MASK
  data[7:0] = 8'b1111_1111;
  mc_prog("REG", "WR", `BA_MASK_ADDR, data, `BA_MASK_MASK, );

  //CSCn Reg and TMSn Reg
  //Only CS0 is for FLASH with write protect nature to mimic ROM	

  //TMSn Reg
  data[31:24] = 8'h00;//RSVD
  data[25:20] = 6'd60;
  data[19:16] = 4'd10;
  data[15:12] = 4'd10;
  data[11:8]  = 4'd10;
  data[7:0]   = 8'd10;
  mc_prog("REG", "WR", `TMS0_ADDR , data, `TMSn_MASK, );
  
  //CSCn Reg 
  data[23:16] = 8'b0000_0001;
  data[11]    = 1'b0;//Parity disabled - Invalid for FLASH
  data[10]    = 1'b0;//KRO - Invalid for FLASH
  data[9]     = 1'b0;//BAS - Invalid for FLASH
  data[8]     = 1'b1;//WP - Writes are enabled
  data[7:6]   = 2'b00;//MS - Invalid for FLASH
  data[5:4]   = 2'h2;//BW is 32 bit 
  data[3:1]   = 3'b010;//MEM_TYPE - Async CS (FLASH)
  data[0]     = 1'b1;//Chip enabled
  mc_prog("REG", "WR", `CSC0_ADDR , data, `CSCn_MASK, );

  //MEM Rd
  this.randomize();
  `uvm_info("randomized_arr_dbg", $sformatf("arr = %p",this.addr_list), UVM_LOW)

	for(int i=0; i < 20; i++) begin
		`uvm_do_with(req, { req.wr_rd == 0;
								  req.addr  == this.addr_list[i];
								  })
	end
endtask

endclass : mc_flash_wr_protect_seq



