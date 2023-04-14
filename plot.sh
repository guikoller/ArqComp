ghdl -a $1".vhd"
ghdl -e $1
ghdl -r $1 --wave=$1.ghw
gtkwave $1.ghw 