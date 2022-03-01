### Set Library (If not in .synopsys_dc.setup)
# set search_path "/xxx/xxx/ /xxx/xxx/ $search_path"
# set target_library "xxx.db xxx.db"
# set link_library "* $target_library dw_foundation.sldb"
# set symbol_library "generic.sdb"
# set synthetic_library "dw_foundation.sldb"

set TOP_DIR $TOPLEVEL
set RPT_DIR report
set NET_DIR netlist

sh rm -rf ./$TOP_DIR
sh rm -rf ./$RPT_DIR
sh rm -rf ./$NET_DIR
sh mkdir ./$TOP_DIR
sh mkdir ./$RPT_DIR
sh mkdir ./$NET_DIR

# define(create) library to record the design
define_design_lib $TOPLEVEL -path ./$TOPLEVEL   

# Read Design File (add your files here)
set HDL_DIR "../hdl"

# put all your HDL here
analyze -library $TOPLEVEL -format verilog "$HDL_DIR/xxx.v \  
                                            $HDL_DIR/xxx.v"

# elaborate your design
elaborate $TOPLEVEL -architecture verilog -library $TOPLEVEL

# Solve Multiple Instance
set uniquify_naming_style "%s_mydesign_%d"
uniquify

# Uniquify (avoid multiple instances refer to the synthesized design)
# design U0(…); design U1(…);
# Uniquified => design_0 U0(…); design_1 U1(…);
# Each design can be optimized independently


# 指定要處理的 design 下一步要設定整個電路的 constrain，所以要在 top 做
current_design $TOPLEVEL 
# link design and library
link
