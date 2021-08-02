onerror {resume}
add list -width 23 /tb_dynamic_bound/rst
add list /tb_dynamic_bound/clk
add list /tb_dynamic_bound/upperBound
add list /tb_dynamic_bound/countOut
configure list -usestrobe 0
configure list -strobestart {0 ns} -strobeperiod {0 ns}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
