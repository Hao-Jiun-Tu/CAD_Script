# set your TOPLEVEL here
set TOPLEVEL "xxx"

# change your timing constraint here
set TEST_CYCLE 10.0

# source each script (0_readfile ~ 3_report)
source -echo -verbose 0_readfile.tcl
source -echo -verbose 1_setting.tcl
source -echo -verbose 2_compile.tcl
source -echo -verbose 3_report.tcl

exit