onerror {quit -f}
vlib work
vlog -work work socorro.vo
vlog -work work socorro.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.pre_projeto_vlg_vec_tst
vcd file -direction socorro.msim.vcd
vcd add -internal pre_projeto_vlg_vec_tst/*
vcd add -internal pre_projeto_vlg_vec_tst/i1/*
add wave /*
run -all
