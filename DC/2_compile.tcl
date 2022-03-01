### before synthesis settings ###
# 在 STA 時，如果某些訊號為 constant 就直接以常數來分析，不把它當作變數
set case_analysis_with_logic_constants true
# 避免直接連結的 net 中出現 assign 的描述 (backend 會有問題)，所以以 buffer 取代
set_fix_multiple_port_nets -feedthroughs -outputs -constants -buffer_constants

### check design ###
# Checks for possible timing problems in the current design
check_design > ./$RPT_DIR/check_design.log
# Checks the current design for consistency
check_timing > ./$RPT_DIR/check_timing.log

# 對於 gated clock，設定控制邏輯閘的最大 fanout
set_clock_gating_style -max_fanout 10

### Synthesis all design ###
# you can add "-gate_clock" to do gated-clock
# you can add "-incremental" for higher performance

# exact_map 不將 logic 簡化到 sequential 中
# no_autoungroup 避免為了化簡而分解 module，all hierarchies are preserved
# no_boundary_optimization 避免為了化簡而使某些 module 的 output pin inversion
# no_seq_output_inversion
# 這些大部分是為了 LEC 可以驗證合成結果
compile_ultra -gate_clock -exact_map -no_autoungroup -no_seq_output_inversion -no_boundary_optimization
# In the incremental mode, the tool does not run the mapping or implementation selection stages
# compile_ultra -incremental -exact_map -no_autoungroup -no_seq_output_inversion -no_boundary_optimization

# remove dummy ports
remove_unconnected_ports [get_cells -hierarchical *]
# decompose buses and remove dummy ports
remove_unconnected_ports [get_cells -hierarchical *] -blast_buses
