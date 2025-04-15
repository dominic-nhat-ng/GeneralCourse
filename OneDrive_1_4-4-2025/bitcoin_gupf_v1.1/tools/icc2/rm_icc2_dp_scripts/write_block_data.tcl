set start_cpu [cputime]
set sh_continue_on_error true
set monitor_cpu_memory true

set top 0
# Check to see if the top level block is running
if {![info exists block_libfilename]} {
   set fields [split [get_object_name [get_blocks]] :]
   lassign $fields block_libfilename block_refname
   set block_refname_no_label [file dir $block_refname]
   set top 1
}

if { !$top } {
   open_block $block_libfilename:$block_refname
}

if {[llength [get_corners estimated_corner -quiet]] != 0} {remove_corners estimated_corner}

# Remove constraint mapping file
set_constraint_mapping_file -reset

save_upf $path_dir/${block_refname_no_label}.icc2.out.upf

write_verilog -compress gzip \
    $path_dir/${block_refname_no_label}.icc2.out.v

write_verilog -compress gzip \
    -include pg_netlist \
    $path_dir/${block_refname_no_label}.icc2.pg.out.v

write_floorplan -compress gzip \
    -output $path_dir/${block_refname_no_label}.icc.floorplan \
    -force \
    -nosplit \
    -format icc

write_floorplan -compress gzip \
    -output $path_dir/${block_refname_no_label}.icc2.floorplan \
    -force \
    -nosplit \
    -format icc2

write_script -compress gzip \
    -output $path_dir/${block_refname_no_label}.icc.ws \
    -force \
    -nosplit \
    -format icc

write_script -compress gzip \
    -output $path_dir/${block_refname_no_label}.icc2.ws \
    -force \
    -nosplit \
    -format icc2

# The block is opened as read_only because it has an abstract.  The tool auto merges the abstract, 
# but the block is still read_only and cannot be saved.  So upgrade to writeable.
reopen_block $block_refname

save_lib -all

if { !$top } {
   close_lib
}
