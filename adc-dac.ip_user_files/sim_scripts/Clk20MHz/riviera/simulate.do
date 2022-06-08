onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+Clk20MHz -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Clk20MHz xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {Clk20MHz.udo}

run -all

endsim

quit -force
