A8Kx8 flash_mem_bw8_inst(
							.Address(mc_mem_pif.mc_addr_pad_o[12:0]), 
							.dataIO(mc_dq[7:0]), 
							.OEn(mc_mem_pif.mc_oe_pad_o_), 
							.CE1n(mc_mem_pif.mc_cs_pad_o_[0]), 
							.CE2(~mc_mem_pif.mc_cs_pad_o_[0]), 
							.WEn(mc_mem_pif.mc_we_pad_o_)
							);

