proc GET_REF_NAME_PATTERN {patterns} {
  set reptcelpattern ""
  set init 0
  foreach reptcel $patterns {
     if {$init==0} {
        set reptcelpattern "ref_name=~ *$reptcel*"
     } else {
        set reptcelpattern "$reptcelpattern || ref_name=~ *$reptcel*"
     }
     set init 1
  }
  return $reptcelpattern
}


proc progress {cur tot} {
    # if you don't want to redraw all the time, uncomment and change ferquency
    #if {$cur % ($tot/300)} { return }
    # set to total width of progress bar
    set total 76

    set half [expr {$total/2}]
    set percent [expr {100.*$cur/$tot}]
    set val (\ [format "%6.2f%%" $percent]\ )
    set str "\r|[string repeat = [
                expr {round($percent*$total/100)}]][
                        string repeat { } [expr {$total-round($percent*$total/100)}]]|"
    set str "[string range $str 0 $half]$val[string range $str [expr {$half+[string length $val]-1}] end]"
    puts -nonewline stderr $str
    if {$cur==$tot} { echo "Done\n"}
}


proc COMMAND_RUNTIME {args} {
    set command [join $args]
    puts "SYN-INFO: Starting command `$command'"
    puts [format "SYN-INFO: [clock format [clock seconds] -format "%A %B %e %Y %r %Z"]"]
    puts [format "SYN-INFO: Peak memory %.3f GB" [expr [mem] / (1024.0 * 1024.0)]]
    redirect /dev/null {set wallclocktime_start [clock seconds]}
    redirect /dev/null {set cputime_start [cputime -self -child]}
    uplevel $args
    redirect /dev/null {set wallclocktime_stop [clock seconds]}
    redirect /dev/null {set cputime_stop [cputime -self -child]}
    set hrs  [expr  ($wallclocktime_stop - $wallclocktime_start) / (60 * 60)]
    set mins [expr (($wallclocktime_stop - $wallclocktime_start) % (60 * 60)) / 60]
    set secs [expr  ($wallclocktime_stop - $wallclocktime_start) % 60]
    puts [format "SYN-INFO: Completing command `$command' (Runtime: %3d Hrs %02d Mins %02d Secs)" $hrs $mins $secs]
    set hrs  [expr  ($cputime_stop - $cputime_start) / (60 * 60)]
    set mins [expr (($cputime_stop - $cputime_start) % (60 * 60)) / 60]
    set secs [expr  ($cputime_stop - $cputime_start) % 60]
    puts [format "SYN-INFO: Completing command `$command' (CPUtime: %3d Hrs %02d Mins %02d Secs)" $hrs $mins $secs]
    puts [format "SYN-INFO: [clock format [clock seconds] -format "%A %B %e %Y %r %Z"]"]
    puts [format "SYN-INFO: Peak memory %.3f GB" [expr [mem] / (1024.0 * 1024.0)]]
}

proc GENERATE_REPORTS_SYN {} {

global report_dir
global stage
global machine_info

update_timing -full
report_qor -nosplit -summary > ${report_dir}/${stage}_qor.summary
report_utilization > ${report_dir}/${stage}_utilization.summary
report_constraints -all_violators -scenario [all_scenarios] > ${report_dir}/${stage}_all_viol.rpt
report_timing -transition_time -capacitance -nets -input_pins -attributes -crosstalk_delta -max_paths 10 > ${report_dir}/${stage}_tim.rpt
report_design -physical  -nosplit > ${report_dir}/${stage}_design_stats.rpt
puts "SYSTEM-INFO $machine_info"
    echo Hostname: [lindex [split [info hostname] .] 0]
}

proc GENERATE_REPORTS_SYN_NO_UPDATE {} {

global report_dir
global stage
global machine_info

report_qor -nosplit -summary > ${report_dir}/${stage}_qor.summary
report_utilization > ${report_dir}/${stage}_utilization.summary
report_constraints -all_violators -scenario [all_scenarios] > ${report_dir}/${stage}_all_viol.rpt
report_timing -transition_time -capacitance -nets -input_pins -attributes -crosstalk_delta -max_paths 10 > ${report_dir}/${stage}_tim.rpt
report_design -physical  -nosplit > ${report_dir}/${stage}_design_stats.rpt
puts "SYSTEM-INFO $machine_info"
echo Hostname: [lindex [split [info hostname] .] 0]
}

proc GENERATE_REPORTS_SUMMARY {} {

global report_dir
global stage
global DESIGN_NAME
global machine_info
update_timing -full

redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.qor.rpt" {report_qor}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.qor_sum.rpt" {report_qor -summary}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.phys.rpt" {report_design -physical}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.phys_netlist.rpt" {report_design -netlist}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.clock_tree.rpt" {report_clock_qor -type summary}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.pwr.rpt" {set_scenario_status -dynamic_power true -leakage_power true [get_scenarios] ;report_power -nosplit -scenario [get_scenarios]}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.util.rpt" {report_utilization}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.drc.rpt" {check_routes -check_from_frozen_shapes true -check_from_user_shapes true}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.drc_without_preroutes.rpt" {check_routes}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.cmv.rpt" {check_mv_design -max_message_count 1000}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.va.rpt" {report_voltage_areas}
puts "SYSTEM-INFO $machine_info"
echo Hostname: [lindex [split [info hostname] .] 0]
}

proc GENERATE_REPORTS_SUMMARY_NO_UPDATE {} {

global report_dir
global stage
global DESIGN_NAME
global machine_info

redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.qor.rpt" {report_qor}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.qor_sum.rpt" {report_qor -summary}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.phys.rpt" {report_design -physical}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.phys_netlist.rpt" {report_design -netlist}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.clock_tree.rpt" {report_clock_qor -type summary}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.pwr.rpt" {report_power -nosplit}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.util.rpt" {report_utilization}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.drc.rpt" {check_routes -check_from_frozen_shapes true -check_from_user_shapes true}
redirect -file "${report_dir}/${DESIGN_NAME}.${stage}.drc_without_preroutes.rpt" {check_routes}
puts "SYSTEM-INFO $machine_info"
echo Hostname: [lindex [split [info hostname] .] 0]
}

proc PUTS_PROC_INFO {name} {
    puts "SYN-INFO: Defining Tcl procedure : \"$name\""
}




PUTS_PROC_INFO "START_TIMER <timer_name> <message>"
proc START_TIMER {timer_name message} {
  global machine_info
    echo Hostname: [lindex [split [info hostname] .] 0]
    puts "SYS-INFO: $machine_info"
    puts "SYN-INFO: $message"
    puts [format "SYN-INFO: [clock format [clock seconds] -format "%A %B %e %Y %r %Z"]"]
    puts [format "SYN-INFO: Peak memory %.3f GB" [expr [mem] / (1024.0 * 1024.0)]]
    global $timer_name
    global ${timer_name}_cpu
    redirect /dev/null {set $timer_name [clock seconds]}
    redirect /dev/null {set ${timer_name}_cpu [cputime -self -child]}
echo Hostname: [lindex [split [info hostname] .] 0]
}

PUTS_PROC_INFO "STOP_TIMER <timer_name> <message>"
proc STOP_TIMER {timer_name message} {
  global machine_info
    upvar $timer_name wallclocktime_start
    upvar ${timer_name}_cpu cputime_start
    redirect /dev/null {set wallclocktime_stop [clock seconds]}
    redirect /dev/null {set cputime_stop [cputime -self -child]}
    set hrs  [expr  ($wallclocktime_stop - $wallclocktime_start) / (60 * 60)]
    set mins [expr (($wallclocktime_stop - $wallclocktime_start) % (60 * 60)) / 60]
    set secs [expr  ($wallclocktime_stop - $wallclocktime_start) % 60]
    puts [format "SYN-INFO: $message (Runtime: %3d Hrs %02d Mins %02d Secs)" $hrs $mins $secs]
    set hrs  [expr  ($cputime_stop - $cputime_start) / (60 * 60)]
    set mins [expr (($cputime_stop - $cputime_start) % (60 * 60)) / 60]
    set secs [expr  ($cputime_stop - $cputime_start) % 60]
    puts [format "SYN-INFO: $message (CPUtime: %3d Hrs %02d Mins %02d Secs)" $hrs $mins $secs]
    puts [format "SYN-INFO: [clock format [clock seconds] -format "%A %B %e %Y %r %Z"]"]
    puts [format "SYN-INFO: Peak memory %.3f GB" [expr [mem] / (1024.0 * 1024.0)]]
    puts "SYSTEM-INFO $machine_info"
    echo Hostname: [lindex [split [info hostname] .] 0]
}

set machine_info [sh uname -a]



proc ALL_RETENTION {} {
  return [get_cells -quiet -phys * -filter "is_retention==true"]
}
proc ALL_LEVEL_SHIFTERS {} {
  return [get_cells -quiet -phys * -filter "is_level_shifter==true"]
}
proc ALL_ISOLATION_CELLS {} {
  return [get_cells -quiet -phys * -filter "is_isolation==true"]
}
proc ALL_MACRO_CELLS {} {
  return [get_cells -quiet -phys * -filter "is_hard_macro==true"]
}
proc ALL_POWER_SWITCHES {} {
  return [get_cells -quiet -phys * -filter "is_power_switch==true"]
}


proc ALL_AON_CELLS {} {
  set aoceli ""
  set aorefs [get_lib_cell -quiet -filter {(always_on == true)} */*]
  set init 0
  foreach aocel [get_attribute $aorefs name] {
     if {$init==0} {
        set aocelpattern "ref_name=~ *$aocel*"
     } else {
        set aocelpattern "$aocelpattern || ref_name=~ *$aocel*"
     }
     set init 1
  }
  if {[info exists aocelpattern]} {
     set aoceli [get_cells -quiet -phys * -filter "$aocelpattern"]
  } else {
     set aoceli ""
  }
  return $aoceli
}

proc ALL_REPEATER_CELLS {} {
  set reptceli ""
  set reptrefs [get_lib_cell -quiet -filter {number_of_pins==2} */*]
  set init 0
  foreach reptcel [get_attribute $reptrefs name] {
     if {$init==0} {
        set reptcelpattern "ref_name=~ *$reptcel*"
     } else {
        set reptcelpattern "$reptcelpattern || ref_name=~ *$reptcel*"
     }
     set init 1
  }
  if {[info exists reptcelpattern]} {
     set reptceli [get_cells -quiet -phys * -filter "$reptcelpattern"]
  } else {
     set reptceli ""
  }
  return $reptceli
}
