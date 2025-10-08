package mc_mem_pkg;
	`include "uvm_pkg.sv"//only comment for EDA sims
	import uvm_pkg::*;

	`include "mc_mem_tx.sv"
	`include "mc_mem_cov.sv"
	`include "mc_mem_mon.sv"
	`include "mc_mem_agent.sv"
endpackage
