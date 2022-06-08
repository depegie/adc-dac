onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib Clk20MHz_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {Clk20MHz.udo}

run -all

quit -force
