task flash_sleep_check();
	wait(mc_mem_pif.mc_rp_pad_o_ == 0);
	`uvm_info("FLASH_SLEEP_CHECK", "FLASH in Reset/ Power-Down", UVM_NONE)
endtask

task flash_vpen_check();
	wait(mc_mem_pif.mc_vpen_pad_o == 1);
	`uvm_info("FLASH_VPEN_CHECK", "FLASH in Erase/ Program enable", UVM_NONE)
endtask
