// ----------------------------------------------------
//UVM sequence: mc_flash_access_seq
//----------------------------------------------------
class mc_flash_access_seq extends mc_base_seq; 
`uvm_object_utils(mc_flash_access_seq)

function new(string name = "mc_flash_access_seq");
  super.new(name);
endfunction

virtual task body();
	bit [31:0] data;
  `uvm_info(get_type_name(), "Starting mc_flash_access_seq", UVM_NONE)

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
  for(int i = 0; i < 16; i++) begin
  	if ((i % 2) != 0) begin // selects TMSn address
  		//TMSn Reg
		data[31:24] = 8'h00;//RSVD
		data[25:20] = 6'd60;
		data[19:16] = 4'd10;
		data[15:12] = 4'd10;
		data[11:8]  = 4'd10;
		data[7:0]   = 8'd10;
  		mc_prog("REG", "WR", reg_addr[i] , data, `TMSn_MASK, );
  	end
  	else begin // selects CSCn address 
  		//CSCn Reg 
		data[23:16] = 8'b0000_0001 << i/2;//0 2 4 6 8 10 12 14
		data[11]    = 1'b0;//Parity disabled - Invalid for FLASH
		data[10]    = 1'b0;//KRO - Invalid for FLASH
		data[9]     = 1'b0;//BAS - Invalid for FLASH
		data[8]     = 1'b0;//WP - Writes are enabled
		data[7:6]   = 2'b00;//MS - Invalid for FLASH
		data[5:4]   = 2'h2;//BW is 32 bit 
		data[3:1]   = 3'b010;//MEM_TYPE - Async CS (FLASH)
		data[0]     = 1'b1;//Chip enabled
  		mc_prog("REG", "WR", reg_addr[i] , data, `CSCn_MASK, );
  	end

  end

  //MEM Wr 
  for(int i = 0; i < 1; i++) begin
  		mc_prog("MEM", "WR", , , , 8'b0000_0001 << i);
  end

  //MEM Rd
  for(int i = 0; i < 1; i++) begin
  		mc_prog("MEM", "RD", , , , 8'b0000_0001 << i);
  end
endtask

endclass : mc_flash_access_seq


