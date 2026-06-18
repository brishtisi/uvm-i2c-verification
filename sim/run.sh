#!/bin/bash
# Synopsys VCS Simulation Script
# UVM-Based I2C Master Controller Verification
# Tested on VCS X-2025.06-SP2-1

echo "Compiling..."
vcs -sverilog -ntb_opts uvm-1.2 \
    +incdir+../tb \
    ../rtl/i2c_master_top.v \
    ../tb/i2c_tb_pkg.sv \
    ../tb/tb_top.sv \
    -cm line+cond+tgl+fsm+branch \
    -o simv \
    -l compile.log

echo "Running simulation..."
./simv \
    +UVM_TESTNAME=i2c_test \
    +UVM_VERBOSITY=UVM_MEDIUM \
    -cm line+cond+tgl+fsm+branch \
    -cm_dir simv.vdb \
    -l sim.log

echo "Generating coverage reports..."
urg -dir simv.vdb -format text -report cov_text
urg -dir simv.vdb -report cov_report

echo "Done."
echo "  Sim log      : sim.log"
echo "  Coverage HTML: cov_report/dashboard.html"
echo "  Coverage text: cov_text/"
