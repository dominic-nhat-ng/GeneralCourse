## This report is used to get a detailed understanding of the logical structure of a
## net, it's MV characteristics, and its bufferability.  It takes the following arguments:
##
## <object>: String name of any logical or physical pin, port, or any segment of the net.  Also can give
##           a cell name and if it only has one output, it uses that as the pin.  The
##           command derives the physical driver of the net from this information, and reports
##           on the whole net (every pin and every segment).
## -voltage_area: Optionally a voltage area can be specified which is used for bufferability
##                analysis on all net segments.  By default, the native VA for each net segment
##                is automatically determined and bufferability analysis is done based on that.
##                Practically speaking, this means that the -voltage_area should not be used
##                unless you are specifically interested in physical feedthrough bufferability
##                analysis.
## -check_all_segments: By default, check_bufferability is called only on net segments where
##                      the power domain has changed.  This is done to limit the total number
##                      of calls to check_bufferability, which is by far the most runtime
##                      costly aspect of this report.
## -nolegend: Skips printing the legend before the report.  Useful for when you are familiar with
##            what all the report annotations mean, and don't want to see a large legend every time.
## -debug: For development purposes only

## Change Log:
##   2016.03.16: Added support for nets connected to ports
##   2016.03.16: Changed the 'Related Supply' column to 'Primary or Related Supply'.  For physical
##               pins and ports, related supply is printed.  For logical pins and nets, the primary
##               supply of the power domain is printed.

## Planned Enhancements:
##    Check for tri-state nets
##    Trigger check_bufferability calls for PD boundaries (multi PD in VA)
##    Add physical checking (given coordinate): Derive VA from coordinate, site name compatibility check, placement
##        blockages, routing blockages, fixed cells, macros, move bounds
##    Update concept of default/native VA to handle PFT cases where the net VA would differ from the hierarchy VA
##    Collapsing of loads on same logical net that share identical characteristics
##    Annotate PFT buffers/nets in the report
##    Add way to report only fan-in chain to a single load of a net, instead of showing full net hierarchy & fanouts
##    Add lib_cell for drivers / loads (can share check_bufferability column)
##    Clock marking check needs to look at all scenarios, even inactive
##    Remove one space initial indent before (P1)
##    Add reporting through buffer stages to a specific load
##      This is independent of fanin_only reporting - could show each stage with all fanouts, or only relevant fanout to load
##    GUI Visualization showing relevant cells / fanouts, handle visualization through buffers
##      Useful annotations like gui_draw_path
##      Somehow indicate useful MV info
##      Bring in some gui_draw_net capabilities
##   Check about timing violations or logical DRC situation
##   Enhance MV attributes, consider: 
##      is_isolation_data_pin
##      is_isolation_enable_pin
##      is_nor_isolation_data_pin
##      is_nor_isolation_enable_pin
##      is_single_rail_level_shifter
##      is_dual_rail_level_shifter
##      is_differential_level_shifter
##      is_tb_cell
##   Identify isolated macro inputs
##   Mark related supply on ISO input as 'ISO' unless SRSN on it
##   Add summary section at bottom detailing all bufferability issues detected
##   Do LEQ checks automatically if a net segment returns 0,0 repeaters
##   Add general warning if PFT disabled about bufferability problems
##   Mode to report only drivers / loads / phys hier, and PD boundaries (addresses Naga's 
##      case of excess logical hierarchy around each ICG

proc report_net_structure {args} {

    #####
    ##### Initialize variables
    #####

    ## Initialize proc arguments
    set proc_args(-voltage_area) default_of_object
    set proc_args(-check_all_segments) 0
    set proc_args(-debug) 0
    set proc_args(-nolegend) 0
    parse_proc_arguments -args $args proc_args
    set object $proc_args(object)
    set voltage_area $proc_args(-voltage_area)
    set check_all_segments $proc_args(-check_all_segments)
    set debug $proc_args(-debug)
    set nolegend $proc_args(-nolegend)

    if {$debug} {puts "DEBUG: proc arguments initialized"}
    
    #####
    ##### Sign-in checks
    #####

    ## Bail if DEFAULT_VA has been renamed, this is unsupported by script
    if {[get_voltage_areas DEFAULT_VA -quiet] == ""} {
	error "Aborting.  Script does not support designs where DEFAULT_VA has been renamed."
    }

    ## Bail if the user specified voltage area doesn't exist
    if {$voltage_area != "default_of_object" && [get_voltage_areas $voltage_area -quiet] == ""} {
	error "Aborting.  The specified voltage_area $voltage_area does not exist."
    }

    if {$debug} {puts "DEBUG: sign-in checks complete"}

    #####
    ##### report_net_structure can take any logical or physical pin, port, or any net segment, or any
    ##### cell with only one output pin, from which to derive the net to be reported.  Here we 
    ##### determine the physical net driver.
    #####

    ## Strip collection from object so it's a bare name
    if {[as_collection -check $object]} {
	set object [get_object_name $object]
    }

    set object_type [get_object_type $object]

    if {$object_type == "pin"} {
	set driver_is_pin [expr ![catch {get_pins -of [get_nets -of [get_pins $object] -segments] -physical -filter "is_net_driver&&!is_hierarchical" -expect_at_least 1 -quiet}]]
	set driver_is_port [expr ![catch {get_ports -of [get_nets -of [get_pins $object] -segments] -physical -filter "is_net_driver" -expect_at_least 1 -quiet}]]
	if {$driver_is_pin} {
	    set driver [get_object_name [get_pins -of [get_nets -of [get_pins $object] -segments] -physical -filter "is_net_driver&&!is_hierarchical"]]
	} else {
	    set driver [get_object_name [get_ports -of [get_nets -of [get_pins $object] -segments] -physical -filter "is_net_driver"]]
	}
    } elseif {$object_type == "port"} {
	set driver_is_pin [expr ![catch {get_pins -of [get_nets -of [get_ports $object] -segments] -physical -filter "is_net_driver&&!is_hierarchical" -expect_at_least 1 -quiet}]]
	set driver_is_port [expr ![catch {get_ports -of [get_nets -of [get_ports $object] -segments] -physical -filter "is_net_driver" -expect_at_least 1 -quiet}]]
	if {$driver_is_pin} {
	    set driver [get_object_name [get_pins -of [get_nets -of [get_ports $object] -segments] -physical -filter "is_net_driver&&!is_hierarchical"]]
	} else {
	    set driver [get_object_name [get_ports -of [get_nets -of [get_ports $object] -segments -physical] -filter "is_net_driver"]]
	}
    } elseif {$object_type == "net"} {
	set driver_is_pin [expr ![catch {get_pins -of [get_nets $object -segments] -physical -filter "is_net_driver&&!is_hierarchical" -expect_at_least 1 -quiet}]]
	set driver_is_port [expr ![catch {get_ports -of [get_nets $object -segments] -physical -filter "is_net_driver" -expect_at_least 1 -quiet}]]
	if {$driver_is_pin} {
	    set driver [get_object_name [get_pins -of [get_nets $object -segments] -physical -filter "is_net_driver&&!is_hierarchical"]]
	} else {
	    set driver [get_object_name [get_ports -of [get_nets $object -segments] -physical -filter "is_net_driver"]]
	}
    } elseif {$object_type == "cell"} {
	if {[sizeof_collection [get_pins -of [get_cells $object] -filter "direction==out"]] == 1} {
	    set driver_is_pin 1
	    set driver_is_port 0
	    set driver [get_object_name [get_pins -of [get_cells $object] -filter "direction==out"]]
	} else {
	    error "Cannot derive net from cell object $object because it has multiple output pins."
	}
    }
    
    if {[llength $driver] == 0} {
	error "No physical net driver found.  Net cannot be buffered."
    } elseif {[llength $driver] > 1} {
        puts $driver
	error "Multiple drivers found for net.  Net cannot be buffered."
    }

    if {$debug} {puts "DEBUG: Net driver identified"}

    #####
    ##### An initial net recursion is done to find the necessary widths of several columns in the report
    ##### Here we initialize those variables, do the initial recursion, and increment some of those
    ##### column widths for improved readability.
    #####
    
    ## Initialize vars used to store max field lengths with the length of the header fields
    set max_pin_or_net_name_length 15
    set max_domain_length 6
    set max_related_supply_length 14
    set max_check_buf_length 13

    ## Recurse net segments to get max name lengths for formatting purposes only
    recurse_net $driver 1 none 1

    if {$debug} {puts "DEBUG: Finished recurse_net_for_formatting"}

    ## Add some extra spacing to fields for readability
    incr max_domain_length
    incr max_related_supply_length
    incr max_check_buf_length

    #####
    ##### Generate report header information
    #####

    puts ""
    puts "============================================="
    puts "========== Reporting Net Structure =========="
    puts "============================================="
    puts [format "%s %6s %s %s" "Queried Object" "([get_object_type $object])" ":" $object]
    puts [format "%s %12s %s" "Net Driver" ":" $driver]
    puts ""

    if {!$nolegend} {
	puts "----- Legend -----"
	puts "Type:                           DRIVER (physical driver pin), load (physical load pin),"
	puts "                                down (logical hier input), up (logical hier output),"
	puts "                                blkin (physical hier input), blkout (physical hier output)"
	puts "                                net (net segment)"
	puts "Domain:                         * (Domain of DEFAULT_VA), % (VA name different than domain name), # (no VA defined)"
	puts "                                unknown (net domain undetermined due to multiple PDs in DEFAULT_VA)"
	puts "Primary or Related Supply:      Shows related supply for driver/loads, domain primary supply otherwise"
        puts "                                & (not the primary supply of the domain), # (can't identify domain primary)"
	puts "Bufferability Attributes (net): dt (dont_touch), ideal (ideal net)"
	puts "Bufferability Attributes (pin): clock / mixedclk&data"
	puts "MV Attributes (pin):            iso (is_isolation), ls (is_level_shifter), ao (always_on), rt (is_retention),"
	puts "                                pft (physical feedthrough buf/inv)"
	puts "Check Bufferability (net):      <required supply>,<single or dual rail>,<avail buf count>,<avail inv count>"
	puts "                                Unknown PD & VA (could not determine PD or VA of net)"
	puts ""
    }

    ## Warning if non-default voltage area is used for reporting, but PFT buffering disabled
    if {$voltage_area != "default_of_object" && ![get_app_option_value -name opt.common.allow_physical_feedthrough]} {
	puts "WARNING: User specified voltage_area $voltage_area is specified for bufferability checking,"
	puts "WARNING: but physical feedthrough buffering is disabled.  Buffering can only be done in non-"
	puts "WARNING: native VAs if app option opt.common.allow_physical_feedthrough is true."
	puts ""
    }

    puts [format "%-[expr ${max_pin_or_net_name_length}]s %7s %${max_domain_length}s %${max_related_supply_length}s %14s %13s %${max_check_buf_length}s" "" "" "" "Primary or" "Bufferability" "MV" "Check"]
    puts [format "%-[expr ${max_pin_or_net_name_length}]s %7s %${max_domain_length}s %${max_related_supply_length}s %14s %13s %${max_check_buf_length}s" "Pin or Net Name" Type Domain "Related Supply" "Attributes" "Attributes" "Bufferability"]
    puts [format "%-[expr ${max_pin_or_net_name_length}]s %7s %${max_domain_length}s %${max_related_supply_length}s %14s %13s %${max_check_buf_length}s" "---------------" "----" "------" "--------------" "----------" "----------" "-------------"]

    #####
    ##### Call recurse_net, which does the actual reporting of each net driver/segment
    ##### 
    recurse_net $driver 1 none 0

    if {$debug} {puts "DEBUG: Finished recurse_net -- report_net_structure done"}
    puts ""

}
define_proc_attributes report_net_structure -info "Detailed report of a net's logical structure, MV characteristics, and bufferability" \
    -define_args {
        { object "Any net segment, pin, port, or driver cell name connected to the net to be reported (as a collection or as a TCL string)" net_or_pin_or_cell string required }
	{ -voltage_area "VA for bufferability check (default: each net segment's native VA)" "va_name" string optional }
	{ -check_all_segments "Call check_bufferability on all net segments (default: first segment of each domain)" "" boolean optional }
	{ -debug "Verbose messages to debug problems with report_net_structure script" "" boolean optional }
	{ -nolegend "Skip printing legend before report" "" boolean optional }
    }


## Used by report_net_structure to recursively trace the net segments
## $format_only mode just gathers formatting information for the output
## table by finding the max field length for:
## "Pin or Net Name", "Domain", and "Primary or Related Supply" columns only
## "Bufferability Attributes" and "MV Attributes" column data is always shorter than
## the column header, so no need to check.  "Check Bufferability" is the last column,
## so we allow the data to take as much room as needed and left justify the header.
proc recurse_net {pin_name level last_domain format_only} {

    ## Pass in global vars used for report column width formatting
    ## Also report_net_structure -voltage_area option to specify VA to query for bufferability
    upvar 1 max_pin_or_net_name_length max_pin_or_net_name_length
    upvar 1 max_domain_length max_domain_length
    upvar 1 max_related_supply_length max_related_supply_length

    upvar 1 voltage_area voltage_area
    upvar 1 check_all_segments check_all_segments
    upvar 1 debug debug

    #####
    ##### Get the net segment that is directly connected to $pin_name
    ##### Direction only matters for logical hierarchy pins, but queries work for physical pins or ports
    #####

    set pin_direction [get_attribute [get_pin_or_port $pin_name] direction]
    if {$pin_direction == "out"} {
	set net_name [get_object_name [get_nets -of [get_pin_or_port $pin_name] -boundary_type upper]]
    } elseif {$pin_direction == "in"} {
	set net_name [get_object_name [get_nets -of [get_pin_or_port $pin_name] -boundary_type lower]]
    } else {
	error "Pin direction other than in or out for pin/port  $pin_name is not supported by this script."
    }

    if {$debug} {puts "DEBUG: \$net_name is $net_name"}

    #####
    ##### Populate 'Domain' column fields for pins
    #####

    set pin_domain [get_attribute [get_pin_or_port $pin_name] power_domain]
    if {[get_voltage_areas -of $pin_domain -quiet] == ""} {
	set printed_pin_domain "$pin_domain #"
    } elseif {$pin_domain == [get_object_name [get_voltage_areas -of $pin_domain]]} {
	set printed_pin_domain $pin_domain
    } elseif {[get_object_name [get_voltage_areas -of $pin_domain]] == "DEFAULT_VA"} {
	set printed_pin_domain "$pin_domain *"
    } else {
	set printed_pin_domain "$pin_domain %"
    }

    if {$debug} {puts "DEBUG: \$pin_domain is $pin_domain"}

    #####
    ##### Populate 'Domain' column fields for nets
    #####
    
    if {[get_attribute [get_nets $net_name] parent_cell -quiet] == ""} {
	set net_domain [get_object_name [get_top_power_domain]]
	set printed_net_domain "$net_domain *"
    } else {
	## Determine net's VA through NDM
	set net_domain [get_attribute [get_nets $net_name] parent_cell.power_domain]
	if {[get_voltage_areas -of $net_domain -quiet] == ""} {
	    set printed_net_domain "$net_domain #"
	} elseif {$net_domain == [get_object_name [get_voltage_areas -of $net_domain]]} {
	    set printed_net_domain $net_domain
	} elseif {[get_object_name [get_voltage_areas -of $net_domain]] == "DEFAULT_VA"} {
	    set printed_net_domain "$net_domain *"
	}	else {
	    set printed_net_domain "$net_domain %"
	}
    }

    if {$debug} {puts "DEBUG: \$net_domain is $net_domain"}
    
    #####
    ##### Populate 'Type' column fields
    #####
    
    if {[get_object_type $pin_name] == "port"} {
	if {$pin_direction == "in"} {
	    set pin_type DRIVER
	} elseif {$pin_direction == "out"} {
	    set pin_type LOAD
	}
    } else {
	set pin_is_hierarchical [get_attribute [get_pins $pin_name] is_hierarchical]
	set pin_is_physical [get_attribute [get_cells -of [get_pins $pin_name]] is_physical -quiet]
	if {$pin_is_physical == ""} {
	    set pin_is_physical false
	}
	
	if       {$pin_is_physical && !$pin_is_hierarchical && $pin_direction == "in"} {
	    set pin_type LOAD
	} elseif {$pin_is_physical && !$pin_is_hierarchical && $pin_direction == "out"} {
	    set pin_type DRIVER
	} elseif {$pin_is_physical &&  $pin_is_hierarchical && $pin_direction == "in"} {
	    set pin_type blkin
	} elseif {$pin_is_physical &&  $pin_is_hierarchical && $pin_direction == "out"} {
	    set pin_type blkout
	} elseif {$pin_direction == "in"} {
	    set pin_type down
	} elseif {$pin_direction == "out"} {
	    set pin_type up
	} else {
	    error "Cannot identify pin_type for $pin_name"
	}
    }
    
    if {$debug} {puts "DEBUG: \$pin_type is $pin_type"}
    
    #####
    ##### Populate 'Primary or Related Supply' column fields
    #####
    if {$pin_type == "DRIVER" || $pin_type == "LOAD"} {
	set pin_supply [get_object_name [get_related_supply_nets [get_pin_or_port $pin_name] -quiet]]
    } else {
	set pin_supply "none"
    }
    set pin_pd_primary_supply [get_object_name [get_attribute [get_power_domains $pin_domain] primary_power]]
    set printed_net_supply [get_object_name [get_attribute [get_power_domains $net_domain] primary_power]]

    if {$pin_supply == "none"} {
	## Domain primary supply for logical pins
	set printed_pin_supply $pin_pd_primary_supply
    } else {
        ## Related supply for physical pins & ports
	if {$pin_supply == ""} {
	    set printed_pin_supply ""
	} elseif {$pin_pd_primary_supply == ""} {
	    set printed_pin_supply "$pin_supply #"
	} elseif {$pin_supply == $pin_pd_primary_supply} {
	    set printed_pin_supply $pin_supply
	} else {
	    set printed_pin_supply "$pin_supply &"
	}
    }

    if {$debug} {puts "DEBUG: \$pin_supply is $pin_supply"}

    
    
    ## The following information isn't needed by $format_only mode, so skip
    if {!$format_only} {

	#####
	##### Populate Pin 'Bufferability Attributes' column fields
	#####
	set pin_attributes ""
	set pin_clock_as_clock [get_attribute [get_pin_or_port $pin_name] is_clock_used_as_clock]
	set pin_clock_as_data [get_attribute [get_pin_or_port $pin_name] is_clock_used_as_data]
	if {$pin_clock_as_clock && !$pin_clock_as_data} {
	    set pin_attributes "clock"
	} elseif {$pin_clock_as_data} {
	    set pin_attributes "mixedclk&data"
	}
	
	if {$debug} {puts "DEBUG: \$pin_attributes is $pin_attributes"}
	
	#####
	##### Populate Net 'Bufferability Attributes' column fields
	#####
	set net_attributes ""
	set net_dont_touch [get_attribute [get_nets $net_name] dont_touch]
	set net_ideal [get_attribute [get_nets $net_name] is_ideal]
	if {$net_dont_touch && $net_ideal} {
	    set net_attributes "dt,ideal"
	} elseif {$net_dont_touch} {
	    set net_attributes "dt"
	} elseif {$net_ideal} {
	    set net_attributes "ideal"
	}
	
	if {$debug} {puts "DEBUG: \$net_attributes is $net_attributes"}
	
	#####
	##### Populate 'MV Attributes' column fields
	#####
	set mv_attributes ""
	
	if {[get_object_type $pin_name] == "pin"} {
	    if {$pin_type == "LOAD" || $pin_type == "DRIVER"} {
		
		set driver_cell [get_cells -of [get_pins $pin_name]]
		
		set is_always_on [get_attribute [get_lib_cells -of $driver_cell] always_on]
		set is_isolation [get_attribute $driver_cell is_isolation]
		set is_level_shifter [get_attribute $driver_cell is_level_shifter]
		set is_retention [get_attribute $driver_cell is_retention]
		if {[get_attribute $driver_cell is_power_domain_root_cell] && [get_attribute $driver_cell ref_block.always_on]} {
		    set is_pft true
		} else {
		    set is_pft false
		}

		if {$is_always_on} {set mv_attributes "ao"}
		if {$is_pft} {
		    if {$mv_attributes == ""} {
			set mv_attributes "pft"
		    } else {
			set mv_attributes "${mv_attributes},pft"
		    }
		}
		if {$is_isolation} {
		    if {$mv_attributes == ""} {
			set mv_attributes "iso"
		    } else {
			set mv_attributes "${mv_attributes},iso"
		    }
		}
		if {$is_level_shifter} {
		    if {$mv_attributes == ""} {
			set mv_attributes "ls"
		    } else {
			set mv_attributes "${mv_attributes},ls"
		    }
		}
		if {$is_retention} {
		    if {$mv_attributes == ""} {
			set mv_attributes "rt"
		    } else {
			set mv_attributes "${mv_attributes},rt"
		    }
		}
		
	    }
	}
	
	if {$debug} {puts "DEBUG: \$mv_attributes is $mv_attributes"}
	
	#####
	##### Populate 'Check Bufferability' column fields
	#####
	
	set chkbuf_rail "N/A"
	set chkbuf_supply "N/A"
	set chkbuf_bufs "N/A"
	set chkbuf_invs "N/A"
	
	## Only do check_bufferability for the first net segment of each power domain encountered, to save runtime.
	## Two situations where this happens:
	## (1) Very first net segment reported
	## (2) The domain of the net segment doesn't match the domain of the previous net segment
	## Or, check all net segments if -check_all_segments is specified.
	if {$last_domain == "none" || $last_domain != $net_domain || $check_all_segments} { 
	    
	    ## Determine the VA to pass to check_bufferability.  By default, the native VA of the net is passed to it,
	    ## unless the user specifies the report_net_structure -voltage_area option.
	    if {$voltage_area != "default_of_object"} {
		set chkbuf_va $voltage_area
	    } else {
		if {$net_domain == "unknown"} {
		    set chkbuf_va "Unknown PD & VA"
		} elseif {[get_voltage_areas -of $net_domain -quiet] == ""} {
		    set chkbuf_va "No VA Defined"
		} else {
		    set chkbuf_va [get_voltage_areas -of $net_domain]
		}
	    }
	    
	    if {$chkbuf_va == "Unknown PD & VA"} {
		set printed_chkbuf " Unknown PD & VA"
	    } else {
		
		redirect -variable chkbuf {check_bufferability -net $net_name -voltage_area $chkbuf_va}
		set chkbuf [split $chkbuf "\n"]
		
		foreach line $chkbuf {
		    ## Gather information about single/dual rail, required supply, and available buf/inv counts from possible check_bufferability outputs
		    if {[regexp {MV-491} $line] || [regexp {MV-492} $line] || [regexp {MV-471} $line]} {
			## Information: The net <net> cannot be buffered (MV-471)
			## Information: Required supply is ( power supply_VDD, ground supply_VSS ), cannot find appropriate single rail buffers/inverters in the library. (MV-491)		   
			## Information: Required supply is ( power supply_VDD, ground supply_VSS ), cannot find appropriate dual rail buffers/inverters in the library. (MV-492)
			## Situation 1: No buffers found
			
			if {[regexp {MV-471} $line]} {
			    set chkbuf_rail "?"
			    set chkbuf_supply "?"
			} else {
			    set chkbuf_rail [lindex $line 13]
			    set chkbuf_supply [string trimright [lindex $line 6] ,]
			}
			set chkbuf_bufs 0
			set chkbuf_invs 0
			break
		    } elseif {[regexp {MV-452} $line] || [regexp {MV-462} $line]} {
			## Information: Can buffer with single rail buffers ( number of buffers 103 ) and inverters ( number of inverters 97 ) powered by ( power supply_VDD11_D1, ground supply_VSS ). (MV-452)
			## Information: Can buffer with dual rail buffers (number of buffers 18 ) and inverters ( number of inverters 18 ) powered by ( power supply_VDD11, ground supply_VSS ) (MV-462)
			## Situation 2: Buffers found - notice slight format difference w/ '( number' and '(number'
			set chkbuf_rail [lindex $line 4]
			
			## Adjust for format mismatch of single and dual rail messages
			if {$chkbuf_rail == "single"} {
			    set index_incr 1
			} else {
			    set index_incr 0
			}
			
			set chkbuf_supply [string trimright [lindex $line [expr 24 + $index_incr]] ,]
			set chkbuf_bufs [lindex $line [expr 10 + $index_incr]]
			set chkbuf_invs [lindex $line [expr 18 + $index_incr]]
			break
		    }
		    
		}
		
		set printed_chkbuf " $chkbuf_supply,$chkbuf_rail,$chkbuf_bufs,$chkbuf_invs"
		
	    }
	} else {
	    set printed_chkbuf ""
	}
    
	if {$debug} {puts "DEBUG: \$printed_chkbuf is $printed_chkbuf"}

    }


    #####
    ##### Update field max lengths if $format_only
    #####
    if {$format_only} {

	set printed_pin_length [expr 5 + [string length [get_object_name [get_pin_or_port $pin_name]]] + $level]
        if {$printed_pin_length > $max_pin_or_net_name_length} {
	    set max_pin_or_net_name_length $printed_pin_length
	}
	
	set printed_net_length [expr 5 + [string length $net_name] + $level]
	if {$printed_net_length > $max_pin_or_net_name_length} {
	    set max_pin_or_net_name_length $printed_net_length
	}
	
	if {[string length $printed_pin_domain] > $max_domain_length} {
	    set max_domain_length [string length $printed_pin_domain]
	}
	
	if {[string length $printed_pin_supply] > $max_related_supply_length} {
	    set max_related_supply_length [string length $printed_pin_supply]
	}

	if {[string length $printed_net_supply] > $max_related_supply_length} {
	    set max_related_supply_length [string length $printed_net_supply]
	}

	## Needed to pass into recursive call
	set net_domain "none"

	if {$debug} {puts "DEBUG: Finished updating max field lengths for \$format_only mode"}

    }

    #####
    ##### Generate report output for pin or net segment
    #####

    if {!$format_only} {

	## Print information about pin
	puts [format "%[expr ${level} - 1]s %-4s %-[expr $max_pin_or_net_name_length - 5 - $level]s %7s %${max_domain_length}s %${max_related_supply_length}s %14s %13s %s" "" "(P${level})" $pin_name $pin_type $printed_pin_domain $printed_pin_supply $pin_attributes $mv_attributes ""]
	
	## Print information about net for anything but physical load pins
	if {$pin_type != "LOAD"} {
	    puts [format "%[expr ${level} - 1]s %-4s %-[expr $max_pin_or_net_name_length - 5 - $level]s %7s %${max_domain_length}s %${max_related_supply_length}s %14s %13s %s" "" "(N${level})" $net_name  "net" $printed_net_domain $printed_net_supply $net_attributes "" $printed_chkbuf]
	}

    }

    #####
    ##### Recursively call recurse_nets, if current $pin_name is not a physical load pin
    #####

    ## Terminate recursion if the pin is a physical net load
    ## This will propagate through abstract block pins which are is_hierarchical==true
    if {$pin_type == "LOAD"} {return}

    ## Recurse for each fanout
    set net_object [get_nets $net_name]
    set fanout_pins [remove_from_collection [get_pins -of $net_object -quiet] [get_pin_or_port $pin_name]]
    set fanout_ports [remove_from_collection [get_ports -of $net_object -quiet] [get_pin_or_port $pin_name]]
    foreach_in_collection fanout $fanout_pins {
	recurse_net [get_object_name $fanout] [expr $level + 1] $net_domain $format_only
    }
    foreach_in_collection fanout $fanout_ports {
	recurse_net [get_object_name $fanout] [expr $level + 1] $net_domain $format_only
    }
}

## Returns type of object, considering pin, port, net, and cell types.
## Type precedence (from high to low) is pin, port, net, cell
proc get_object_type {object} {
    set is_pin  [expr ![catch {get_pins $object -expect_at_least 1 -quiet}]]
    set is_port [expr ![catch {get_ports $object -expect_at_least 1 -quiet}]]
    set is_net  [expr ![catch {get_nets $object -expect_at_least 1 -quiet}]]
    set is_cell [expr ![catch {get_cells $object -expect_at_least 1 -quiet}]]
    if {!$is_net && !$is_pin && !$is_port && !$is_cell} {
	error "Unknown object_class for $object"
    } elseif {$is_pin} {
	return "pin"
    } elseif {$is_port} {
	return "port"
    } elseif {$is_net} {
	return "net"
    } elseif {$is_cell} {
	return "cell"
    }
}

## Like [get_pins] or [get_ports] but works for either type.  Typically useful
## when querying common pin/port attributes, or when getting a net from the object.
proc get_pin_or_port {object} {
    set is_pin  [expr ![catch {get_pins $object -expect_at_least 1 -quiet}]]
    set is_port [expr ![catch {get_ports $object -expect_at_least 1 -quiet}]]
    if {!$is_pin && !$is_port} {
	error "Object $object is not a pin or a port."
    } elseif {$is_pin && $is_port} {
	error "Object is both a pin and port.  Unexpected condition."
    } elseif {$is_pin} {
	return [get_pins $object]
    } elseif {$is_port} {
	return [get_ports $object]
    }
}

## Returns the top power domain in the design, which is tricky to get if multiple PDs associated with DEFAULT_VA
proc get_top_power_domain {} {
    if {[sizeof_collection [get_power_domains -of [get_voltage_areas DEFAULT_VA]]] == 1} {
	## Only one PD in DEFAULT_VA, so net must belong to it
	return [get_power_domains -of [get_voltage_areas DEFAULT_VA]]
    } else {
	## If more than one PD in DEFAULT_VA, determine which is the top PD
	## Top PD will have the [current_design] name as an element
	set current_design_name [get_attribute [current_design] name]
	foreach_in_collection pd [get_power_domains -of_objects [get_voltage_areas DEFAULT_VA]] {
	    foreach_in_collection element [get_attribute $pd elements] {
		set element_name [get_attribute $element name]
		if {$element_name == $current_design_name} {
		    return $pd
		}
	    }
	}
    }
}
