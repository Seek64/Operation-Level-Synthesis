# Create project
open_project -reset synthesis

# Add design files
add_files ISS.cpp

# Set the top-level function
set_top ISS_operations

########## Solution 1 ##########

# Create solution1
open_solution -reset solution1

# Define technology and clock rate
set_part  {xcvu9p-flga2104-2-i}
create_clock -period 20

# Insert directives
source ./ISS_directives.tcl

# Synthesis
csynth_design

exit