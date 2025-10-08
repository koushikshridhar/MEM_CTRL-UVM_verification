// ----------------------------------------------------
//UVM sequence: mc_flash_dyn_bus_size_16_bit_seq
//----------------------------------------------------
class mc_flash_dyn_bus_size_16_bit_seq extends mc_base_seq; 
`uvm_object_utils(mc_flash_dyn_bus_size_16_bit_seq)


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

// Memor is a 16 bit addressed
// each tx MC reads 16 bit data
// Ex - 0x100 will read lower 16 bites and 
//      0x101 will read upper 16 bites 
// Totally MC will internally issue 2 tx to capture 32 bit data in total 
constraint c_word_aligned {
  foreach (addr_list[i])
    addr_list[i] % 2 == 0;
}

// Unique addresses only
constraint c_unique {
  unique { addr_list };
}
function new(string name = "mc_flash_dyn_bus_size_16_bit_seq");
  super.new(name);
endfunction

virtual task body();
	bit [31:0] data;
  `uvm_info(get_type_name(), "Starting mc_flash_dyn_bus_size_16_bit_seq", UVM_NONE)

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

  //CSC0 and TMS0 - Flash with 8 bit BW 
  //TMS0 Reg
  data[31:24] = 8'h00;//RSVD
  data[25:20] = 6'd60;
  data[19:16] = 4'd10;
  data[15:12] = 4'd10;
  data[11:8]  = 4'd10;
  data[7:0]   = 8'd10;
  mc_prog("REG", "WR", `TMS0_ADDR, data, `TMSn_MASK, );

  //CSC0 Reg 
  data[23:16] = 8'b0000_0001;
  data[11]    = 1'b0;//Parity disabled - Invalid for FLASH
  data[10]    = 1'b0;//KRO - Invalid for FLASH
  data[9]     = 1'b0;//BAS - Invalid for FLASH
  data[8]     = 1'b0;//WP - Writes are enabled
  data[7:6]   = 2'b00;//MS - Invalid for FLASH
  data[5:4]   = 2'h1;//BW is 16 bit 
  data[3:1]   = 3'b010;//MEM_TYPE - Async CS (FLASH)
  data[0]     = 1'b1;//Chip enabled
  mc_prog("REG", "WR", `CSC0_ADDR , data, `CSCn_MASK, );


  //MEM addr randomization for so that addr value are word addressed
  this.randomize();
  `uvm_info("randomized_arr_dbg", $sformatf("arr = %p",this.addr_list), UVM_LOW)

  //MEM RD
  for(int i=0; i < 20; i++) begin
  	`uvm_do_with(req, { req.wr_rd     == 0;
  							  req.addr      == this.addr_list[i];
							  req.cs        == 8'b0000_0001;
							  req.reg_mem_f == 0;
  							  })
  end
endtask

endclass : mc_flash_dyn_bus_size_16_bit_seq



