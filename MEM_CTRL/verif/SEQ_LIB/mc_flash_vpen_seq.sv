// ----------------------------------------------------
//UVM sequence: mc_flash_vpen_seq
//----------------------------------------------------
class mc_flash_vpen_seq extends mc_base_seq; 
`uvm_object_utils(mc_flash_vpen_seq)

function new(string name = "mc_flash_vpen_seq");
  super.new(name);
endfunction

virtual task body();
	bit [31:0] data;
  `uvm_info(get_type_name(), "Starting mc_flash_vpen_seq", UVM_NONE)

  //REG Programming
  //WR
  //CSR
  data[31:24] = 8'h00;
  data[10:8]  = 3'b000;
  data[2]     = 1'b0;// Flash in Power down 
  data[1]     = 1'b1;// F_VPEN - Flash Erase / Program enable
  data[0]     = 1'b0;//RO bit  - value of mc_sts pin
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
  data[8]     = 1'b0;//WP - Writes are enabled
  data[7:6]   = 2'b00;//MS - Invalid for FLASH
  data[5:4]   = 2'h2;//BW is 32 bit 
  data[3:1]   = 3'b010;//MEM_TYPE - Async CS (FLASH)
  data[0]     = 1'b1;//Chip enabled
  mc_prog("REG", "WR", `CSC0_ADDR , data, `CSCn_MASK, );

  //MEM access is not the goal
  //Goal is to check if MC asserts the vpen output of mem_intf
  
endtask

endclass : mc_flash_vpen_seq



