onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+Clk15MHz -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Clk15MHz xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {Clk15MHz.udo}

run -all

endsim

quit -force
