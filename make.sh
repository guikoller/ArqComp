rm -r work-obj93.cf
./ghdl.sh ula
./ghdl.sh ula_tb
./ghdl.sh register_unit
./ghdl.sh register_bank
./ghdl.sh register_bank_tb
./ghdl.sh ula
./ghdl.sh rom
./ghdl.sh rom_tb
./ghdl.sh program_counter
./ghdl.sh plus_one
./ghdl.sh pc_plus_one
# ./ghdl.sh pc_plus_one_tb
# ./ghdl.sh pc_rom
# ./ghdl.sh pc_rom_tb
./ghdl.sh state_machine
./ghdl.sh state_machine_tb
./ghdl.sh control_unit
./ghdl.sh control_unit_tb
./ghdl.sh top_level
./ghdl.sh top_level_tb