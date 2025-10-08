#compile 
vcs -sverilog -full64 -kdb -debug_access+all  -l vcs_comp.log \
+error+10\
#+lint=TFIPC-L +lint=PCWM\
+incdir+/home/koushiks/Desktop/KOUSHIK_PERSONAL/PROJECTS_UVM/uvm-1.2/src \
+incdir+/home/koushiks/Desktop/KOUSHIK_PERSONAL/PROJECTS_UVM/MEM_CTRL/MemoryModels/160b3ver\
+incdir+../../design/rtl/verilog\
+incdir+./../TOP\
+incdir+./../TEST_LIB\
+incdir+./../SEQ_LIB\
+incdir+./../ENV\
+incdir+./../ENV/AGENTS/wb\
+incdir+./../ENV/AGENTS/mc_mem\
+incdir+./../ENV/SBD\
+incdir+./../RAL\
/home/koushiks/Desktop/KOUSHIK_PERSONAL/PROJECTS_UVM/uvm_dpi/uvm_dpi.cc\
-CFLAGS -DVCS \
-cm_dir compile.vdb \
+define+FLASH_BW16 \
-f file_list.f 
#+define+FLASH \
#+define+FLASH_RO \
#+define+UVM_NO_DPI\
#+define+FLASH_BW8 \

./simv -l mc.log  +UVM_MAX_QUIT_COUNT=5 +fsdb+all +UVM_VERBOSITY=HIGH#+UVM_TESTNAME=uart_tx_test #-gui

