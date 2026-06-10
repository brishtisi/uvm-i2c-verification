#!/bin/bash
# Synopsys VCS Simulation Script
# UVM-Based I2C Master Controller Verification

VCS_CMD="vcs -sverilog -ntb_opts uvm-1.2 \
    +incdir+../tb \
    ../rtl/i2c_master_top.v \
    ../tb/tb_top.sv \
    -o simv \
    -l compile.log"

echo "Compiling..."
$VCS_CMD

echo "Running simulation..."
./simv +UVM_TESTNAME=i2c_write_test \
       +UVM_VERBOSITY=UVM_MEDIUM \
       -l sim.log

echo "Done. Check sim.log for results."
