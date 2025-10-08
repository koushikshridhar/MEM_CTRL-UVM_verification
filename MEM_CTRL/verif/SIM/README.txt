top.sv generation summary

DUT Name             : MC
Number of Interfaces : 4

top.sv contents:
- `module top;` with DUT `MC` instantiated
- Clock signal declarations and generation:
    • clk_i  (200 MHz)
    • mc_clk_i  (100 MHz)
- Interface instantiations:
    • wb_if wb_if_inst();
    • mc_mem_if mc_mem_if_inst();
- uvm_config_db set() calls to pass virtual interfaces
- run_test("mc_base_test")` to launch simulation

TODOs for User To code in top.sv:
- Connect interface instances to DUT ports:
    • Connect `wb_if_inst` to DUT
    • Connect `mc_mem_if_inst` to DUT
- Define SystemVerilog interface files (*.sv)

-----------------------------------------------------------

mc_base_test.sv Summary

Class Structure:
- class mc_base_test extends uvm_test
- Factory registered using `uvm_component_utils(mc_base_test)`
- build_phase(): creates `mc_env`
- run_phase():
    - Creates `mc_base_seq`
    - Raises/drops uvm_objection
    - Calls `start()` on `mc_env_h.sqr`
------------------------------------------------------------------------

mc_env.sv Summary

Class Structure:
- class mc_env extends uvm_env
- Factory registration using `uvm_component_utils`
- One agent per interface: ['WB', 'MC_MEM']
- One scoreboard instance: sbd
- User need to Implement SBD file manually as of now. Script might be modified in future for SBD generation.

Instantiated Components:
       - wb_agent (WB protocol)
       - mc_mem_agent (MC_MEM protocol)
- m_sbd : scoreboard

TODOs for User:
- check the agent to SBD connection
------------------------------------------------------------------------


Agent & Component Summary
 -wb_agent.sv
   └── wb_mon.sv (extends uvm_monitor)
   └── wb_cov.sv (extends uvm_subscriber)
   └── wb_drv.sv (extends uvm_driver)
   └── wb_sqr.sv (extends uvm_sequencer)
 -mc_mem_agent.sv
   └── mc_mem_mon.sv (extends uvm_monitor)
   └── mc_mem_cov.sv (extends uvm_subscriber)
TODO for User:
- In Driver file
-- Implement Protocol specific drive logic functionality
- In Cov file
-- Implement protocol specific FC
- In Mon file
-- Implement protocol specific mon logic functionality
---------------------------------------------------------------------------

mc_base_seq.sv Summary
- Class mc_base_seq extends uvm_sequence
- Factory registration with `uvm_object_utils`
- new() constructor
- body() includes:
   - `uvm_info` to indicate start of sequence
   - `uvm_do macro which allows tool to randomize the tx fields
- TODO: Define sequence item type (req) and if needed use uuvm_do_with instead of uvm_do
---------------------------------------------------------------------------------------------
