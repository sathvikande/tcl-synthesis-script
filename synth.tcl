#################################################################################
# 1. Setup Library & Search Paths
#################################################################################
# Point to the DIRECTORY, not the file
set_db init_lib_search_path /home/vlsi/install/tools/FOUNDRY/digital/90nm/dig/lib/
set_db init_hdl_search_path /home/btech/sathvik/src

# Load the actual library file
set_db library slow.lib

#################################################################################
# 2. Read and Elaborate Design
#################################################################################
# Loading your Verilog file
read_hdl -language sv washing_machine_controller.v

# Building the design hierarchy
elaborate washing_machine_controller

# Check if any pins or modules are missing
check_design -unresolved

#################################################################################
# 3. Apply Timing Constraints
#################################################################################
# Define a 10ns clock (100MHz)
create_clock -name VCLK -period 10 [get_ports clk] 

# Basic I/O delays
set_input_delay 2.0 -clock VCLK [all_inputs]
set_output_delay 2.0 -clock VCLK [all_outputs]

#################################################################################
# 4. Synthesis Execution
#################################################################################
# Generic synthesis (Boolean optimization)
syn_generic

# Technology mapping (Mapping to 90nm gates)
syn_map

# Final optimization
syn_opt

#################################################################################
# 5. Export Reports
#################################################################################
report_area > washing_machine_area.txt
report_timing > washing_machine_timing.txt
report_power > washing_machine_power.txt

# Save the gate-level netlist for the next lab step
write_hdl > washing_machine_netlist.v

puts "--- Synthesis Finished Successfully for Sathvik ---"
# --- GUI and Schematic Commands ---
# Start the GUI mode
gui_show

# Open the schematic for the top-level design
gui_select -design washing_machine_controller
gui_show_schematic View:1

# Optional: Zoom to fit the whole design
gui_zoom -full

