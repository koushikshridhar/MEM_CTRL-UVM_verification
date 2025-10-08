//TODO 
mt48lc8m8a2 sdram_64Mb_inst_0(
										.Dq(mc_dq[7:0]), 
										.Addr(mc_mem_pif.mc_addr_pad_o[11:0]), 
										.Ba(mc_mem_pif.mc_addr_pad_o[14:13]), 
										.Clk(mc_mem_pif.mc_clk_i), 
										.Cke(), 
										Cs_n, 
										Ras_n, 
										Cas_n, 
										We_n, 
										Dqm
										);

