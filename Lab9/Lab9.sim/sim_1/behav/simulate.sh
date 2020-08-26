#!/bin/sh -f
xv_path="/softwares/Linux/xilinx/Vivado/2015.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim up_counter_tb_behav -key {Behavioral:sim_1:Functional:up_counter_tb} -tclbatch up_counter_tb.tcl -log simulate.log
