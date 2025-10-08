//Exception 
//Spec has only one flas connection
//Here we are connecting 4 memories

generate
genvar i;
for(i = 0; i < 8; i=i+1) begin
	A8Kx8 flash_mem_inst_0(
								.Address(mc_mem_pif.mc_addr_pad_o[12:0]), 
								.dataIO(mc_dq[7:0]), 
								.OEn(mc_mem_pif.mc_oe_pad_o_), 
								.CE1n(mc_mem_pif.mc_cs_pad_o_[i]), 
								.CE2(~mc_mem_pif.mc_cs_pad_o_[i]), 
								.WEn(mc_mem_pif.mc_we_pad_o_)
								);

	A8Kx8 flash_mem_inst_1(
								.Address(mc_mem_pif.mc_addr_pad_o[12:0]), 
								.dataIO(mc_dq[15:8]), 
								.OEn(mc_mem_pif.mc_oe_pad_o_), 
								.CE1n(mc_mem_pif.mc_cs_pad_o_[i]), 
								.CE2(~mc_mem_pif.mc_cs_pad_o_[i]), 
								.WEn(mc_mem_pif.mc_we_pad_o_)
								);

	A8Kx8 flash_mem_inst_2(
								.Address(mc_mem_pif.mc_addr_pad_o[12:0]), 
								.dataIO(mc_dq[23:16]), 
								.OEn(mc_mem_pif.mc_oe_pad_o_), 
								.CE1n(mc_mem_pif.mc_cs_pad_o_[i]), 
								.CE2(~mc_mem_pif.mc_cs_pad_o_[i]), 
								.WEn(mc_mem_pif.mc_we_pad_o_)
								);

	A8Kx8 flash_mem_inst_3(
								.Address(mc_mem_pif.mc_addr_pad_o[12:0]), 
								.dataIO(mc_dq[31:24]), 
								.OEn(mc_mem_pif.mc_oe_pad_o_), 
								.CE1n(mc_mem_pif.mc_cs_pad_o_[i]), 
								.CE2(~mc_mem_pif.mc_cs_pad_o_[i]), 
								.WEn(mc_mem_pif.mc_we_pad_o_)
								);
end
endgenerate

