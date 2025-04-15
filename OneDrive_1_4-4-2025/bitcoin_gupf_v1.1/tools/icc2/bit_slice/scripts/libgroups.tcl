###############################################################################
#
#  TEST		libGroups.tcl
#
#  ABSTRACT	Identify unique groups of libraries, where all members of a
#               group have compatible lib_cell's by name.
#
#  LIMITATIONS
#  - Does not validate same lib_pins, function, timing arcs, etc.
#  - Does not separate lib groups by different process
#  - No support for TLUP files?
#  - If user wants to put a process label with some DBs, 2nd arg could be
#       [list [list "process_label" [list files]] ... ]
#  - Two DB's which almost match (one with x cells, other with x+10, 
#    where x is equivalent) don't get grouped together. DB's are expected
#    to match except for single-cell RAM/Macro DBs (PVT mode)
#  - Scaling (or potential for scaling) is not determined
#
#  TODO:
#  - Show lefs which did not match anything. 
#  - DB's too?
#
#  HISTORY
#  Mar 29 2010 - Bill Mullen : Created.
#  Jul 31 2012 - Andy Seigel : Major rewrites
#   - Broke up findGroups into several smaller procs
#   - Removed old unused parts of the flow. findGroups is the only one now.
#   - Full paths for LEF and tech files
#   - Support organize_by_pvt grouping
#   - Fixed init proc so findGroups can be used multiple times w/o quit
#  Aug  2 2012 - Qian Ma : Detect need for a build_physical_only workspace.
#  Sep  6 2012 - Andy Seigel : A few changes
#    - Added dash args and command-line help. Still backward compatible 
#      with positional args. Also has some debug info now with -debug level
#      or -verbose value
#    - For issue 4142, replaced the LEF/DB grouping method.
#  Sep  13 2012 - Qian Ma : create_scaling_group if feasible
#       provide -no_scaling_group to skipping scaling group creation.
#  Nov  07 2012 - Qian:  Andy fixed the duplicated db output for physical_only lib
#                        remove proc getRailSignature, it was replaced by get_attr 
#                        rail_signature on lib
#
###############################################################################

namespace eval ::libGroups {
  variable debug 0
  variable verbose 0
}
  
# All procs are in the ::libGroups namespace

# Passed a tech file name, list of db file names and list of 
# lef file names, condense this all into a set of groups, showing
# a report in a format of scripts that the user can use to create
# correct libs.

proc libGroups::findGroups { args } {

  parse_proc_arguments -args $args hargs
  set ptech [info exists hargs(tech)]
  set dtech [info exists hargs(-tech_file)]
  set pdb [info exists hargs(db_files)]
  set ddb [info exists hargs(-db_files)]
  set plef [info exists hargs(lef_files)]
  set dlef [info exists hargs(-lef_files)]
  set pout [info exists hargs(output)]
  set dout [info exists hargs(-output)]
  if { ($ptech && $dtech) || ($pdb && $ddb) || ($plef && $dlef) ||
       ($pout && $dout) } {
    return -code error "Cannot mix positional and dash args"
  }

  if { [info exists hargs(-debug)] } {
    setDebug $hargs(-debug)
  }
  if { [info exists hargs(-verbose)] } {
    setVerbose $hargs(-verbose)
  }


  set tech ""
  if { $ptech } {
    set tech $hargs(tech)
  } elseif { $dtech } {
    set tech $hargs(-tech_file)
  }
  set dbFnames [list]
  set lefFnames [list]
  set outScriptFile ""
  if { $pdb } {
    set dbFnames $hargs(db_files)
  } elseif { $ddb } {
    set dbFnames $hargs(-db_files)
  }
  if { $plef } {
    set lefFnames $hargs(lef_files)
  } elseif { $dlef } {
    set lefFnames $hargs(-lef_files)
  }
  if { $pout } {
    set outScriptFile $hargs(output)
  } elseif { $dout } {
    set outScriptFile $hargs(-output)
  }

  if { [sizeof_collection [get_libs * -quiet]] != 0 } {
    return -code error "Can't use libGroups::findGroups if libraries are loaded\n\tEither remove_lib -all, or exit and start again."
  }

  init

  set ::libGroups::tech ""
  if {[string length $tech] != 0} {
    set ::libGroups::tech [which $tech]
    if {[string length $::libGroups::tech] == 0} {
      return -code error "specify a valid tech file or change your search_path"
    }
  }

  # create a workspace
  if {[string length $::libGroups::tech] != 0} {
    create_workspace group -tech $::libGroups::tech
  }  else {
    create_workspace group
  }

  # read the db's and lef's
  set nowLibs ""
  if {[llength $lefFnames]  != 0} {
    puts "Reading [llength $lefFnames] LEF files..."
  }
  foreach lef $lefFnames {
    if { [string length [which $lef]] == 0 } {
      continue
    }
    read_lef $lef
    set newLib [lastLibRead nowLibs]
    append_to_collection ::libGroups::lefCollection $newLib
    set lefName [get_attribute $newLib name]
    set ::libGroups::lefMap($lefName) $lef
    set ::libGroups::lefFiles($lef) [get_attribute $newLib source_file_name]
  }
  if {[llength $dbFnames]  != 0} {
    puts "Reading [llength $dbFnames] DB files..."
  }

  setenv NWLM_MINIMUM_DATA 1
  foreach db $dbFnames {
    if { [string length [which $db]] == 0 } {
      continue
    }
    read_db $db
    set newLib [lastLibRead nowLibs]
    append_to_collection ::libGroups::dbCollection $newLib
    set dbLibName [get_attribute $newLib name]
    set ::libGroups::dbMap($dbLibName) $db
  }
  unsetenv NWLM_MINIMUM_DATA

  puts "...read [sizeof_collection $::libGroups::dbCollection] DB libraries"
  puts "...read [sizeof_collection $::libGroups::lefCollection] LEF libraries"
  puts "\n\nAnalyzing your libraries...\n"

  if {$libGroups::debug > 5} {
    show_workspace -panes
  }
  # First pass at building groups of DBs based on signature
  buildLibGroups $::libGroups::dbCollection

  # See if there is any physical_only lib_cell, if true, collect info 
  puts "...looking for physical-only cells...\n"
  identifyPhysicalOnlyCells

  # See if we can merge any groups for PVT reorg?
  global env
  if { ! [info exists env(LIBGROUPS_NO_MACRO_GROUPING)] } {
    puts "...looking for macros which can be grouped by PVT...\n"
    adjustGroupsForPvtReorg
  }

  # Now compare the groups to the LEFs
  puts "...matching LEF files to groups...\n"
  findLEFCovering

  # scaling group exploration and validation
  if {![info exists hargs(-no_scaling_group)]} {
    exploreScalingGroups
  }

  # Write the script (or report)
  generateOutput $outScriptFile

  # remove the workspace
  redirect /dev/null {remove_workspace}
}

define_proc_attributes ::libGroups::findGroups -info "Group DB and LEF libraries" -define_args {
  {"tech" "Tech file name" "tech" string {hidden optional}}
  {"db_files" "List of DB files" "db_files" list {hidden optional}}
  {"lef_files" "List of LEF files" "lef_files" list {hidden optional}}
  {"output" "Output script file name" "output" string {hidden optional}}
  {"-tech_file" "Tech file name" "tech_file_name" string optional}
  {"-db_files" "List of DB files" "list" list optional}
  {"-lef_files" "List of LEF files" "list" list optional}
  {"-no_scaling_group" "skip scaling group creation" "" boolean optional}
  {"-output" "Output script file name" "script" string optional}
  {"-debug" "Debug level" "level" int {hidden optional}}
  {"-verbose" "Verbose level" "vlevel" int {hidden optional}}
}

# Get a sorted list of lib_cell names from one library
proc libGroups::getLibCellNameList {lib} {
  return [getLibCellNameListFromColl [get_lib_cells -of_objects $lib]]
}

# Get a sorted list of lib_cell names from a collection
proc libGroups::getLibCellNameListFromColl {libCells} {
  set nameList [list]
  foreach_in_collection libCell $libCells {
    set lcName [get_attribute $libCell name]
    lappend nameList $lcName
  }
  set nameList [lsort $nameList]
  return $nameList
}

# Build a string of the space-separated lib_cell names for one library
proc libGroups::getSignature { lib } {
  return [getLibCellNameList $lib]
}

# Return the 'last' lib read based on the collection of libs passed in
# and update that collection to be all current libs
proc libGroups::lastLibRead {libRef} {
  upvar $libRef libs
  set allLibs [get_libs * -quiet]
  set ret [remove_from_collection $allLibs $libs]
  set libs $allLibs
  return $ret
}

# Build the data structures for a set of DB libraries
# Result is two variables:
# ::libGroups::uniqueSignatures : List of unique signatures across libs
# ::libGroups::libDict : dictionary of signature to list of libs with that 
# signature
proc libGroups::buildLibGroups {libs} {
  incr ::libGroups::libCount [sizeof_collection $libs]

  foreach_in_collection lib $libs {
    set sig [getSignature $lib]
    set libName [get_attribute $lib name]
    set libFname [get_attribute $lib source_file_name]
    if { ! [info exists ::libGroups::libDict($sig)] } {
      # Map an id to a signature.
      set sigId [llength ::libGroups::uniqueSignatures]
      set ::libGroups::idToSig($sigId) $sig
      set ::libGroups::sigToId($sig) $sigId
      lappend ::libGroups::uniqueSignatures $sig
      set ::libGroups::libDict($sig) [list]
      set ::libGroups::libFiles($sig) [list]
      set ::libGroups::libDbs($sig) ""
    } else {
      set sigId $::libGroups::sigToId($sig)
    }
    lappend ::libGroups::libDict($sig) $libName
    lappend ::libGroups::libFiles($sig) $libFname
    append_to_collection ::libGroups::libDbs($sig) $lib
  }
}


# Check if all lib_cell from LEF have corresponding db, if not, need to create
#  a physical_only library. Build ::libGroups::physOnlyCollection array,
#  index is leflibname which with physical_only cells,  value is a
#  collection of dblib 

proc libGroups::identifyPhysicalOnlyCells {} {

  foreach_in_collection leflib $::libGroups::lefCollection {
    set lefSig [getSignature $leflib]
    set lenth [ llength $lefSig ]
    if { [ llength $lefSig ] == 0 } {
      continue
    }
    set tempDBLibs ""
    foreach uSig $::libGroups::uniqueSignatures {
      set beforeSize [llength $lefSig]
      set left [lminus $lefSig $uSig]
      set afterSize [llength $left] 
      set lefSig $left
      if { $beforeSize > $afterSize } {
        append_to_collection -uniq tempDBLibs $::libGroups::libDbs($uSig) 
      }
      if { $afterSize == 0 } {
        break
      }
    } 
    if { [llength $lefSig] == 0} {
      continue
    }

    # phys_only found in this lef
    set lefName [get_attribute $leflib name]
    set ::libGroups::physOnlyCollection($lefName) $tempDBLibs
  }
   
}

 
# Look through the DB groups and see if there are some candidates for
# organize_by_pvt. These will have one cell per DB and have the same cell
# across multiple PVT (rail signature)

proc libGroups::adjustGroupsForPvtReorg {} {
  array set binSig {}
  set canCount 0

  puts "... ... binning"
  foreach uSig $::libGroups::uniqueSignatures {
    if { [llength $uSig] == 1 } {
      set pvts [list]
      foreach_in_collection dbLib $::libGroups::libDbs($uSig) {
	lappend pvts [get_attribute $dbLib rail_signature]
      }
      set pvts [lsort $pvts]
      lappend binSig($pvts) $uSig
    }
  }
  if {[llength [array names binSig]] == 0} {
    puts "... No candidates for PVT reorg."
    return
  }

  puts "... ... candidate search across [llength [array names binSig]] bins ..."
  foreach bs [array names binSig] {
    set newSig [list]
    set candLibs ""
    set candDict [list]
    foreach sig $binSig($bs) {
      lappend newSig $sig
      foreach dbName $::libGroups::libDict($sig) {
	lappend candDict $dbName
      }
      foreach_in_collection dbLib $::libGroups::libDbs($sig) {
	append_to_collection candLibs $dbLib
      }
    }
    if {$sig == $newSig} {
      # Not a candidate; single lib
      continue;
    }
    if { $canCount == 0 } {
      puts ""
    }
    puts "Candidate for PVT reorg: [llength $candDict] libraries:\n"
    set i 0
    foreach ccc $candDict {
      puts -nonewline " $ccc"
      incr i 
      if {[expr {$i % 6}] == 0} {
	puts ""
      }
      if { $i == 600 } {
	puts " ..."
	break
      }
    }
    puts ""
    incr canCount
    
    # Create the new unique signature (verify it's unique??!!!!), then
    # remove the old signature, libDict, and libDbs, then
    
    set ::libGroups::orgByPvtSigs($newSig) 1
    lappend ::libGroups::uniqueSignatures $newSig
    set ::libGroups::libDbs($newSig) $candLibs
    set ::libGroups::libDict($newSig) [lsort $candDict]
    foreach sig $binSig($bs) {
      set ::libGroups::originalSignatures($sig) $newSig
      set ::libGroups::uniqueSignatures [lminus $::libGroups::uniqueSignatures $sig]
      if {[info exists ::libGroups::libFiles($newSig)]} {
	set ::libGroups::libFiles($newSig) [concat $::libGroups::libFiles($newSig) $::libGroups::libFiles($sig)]
      } else {
	set ::libGroups::libFiles($newSig) $::libGroups::libFiles($sig)
      }
      unset ::libGroups::libFiles($sig)
      unset ::libGroups::libDbs($sig)
      unset ::libGroups::libDict($sig)
    }
  }
}

# compare DB groups to the lefs. Output is ::libGroups::lefMatch, an
# array indexed by signature, the value is a list of LEF names that go with.

proc libGroups::findLEFCovering {} {
  array set lMatch {}
  array set dMatch {}
  foreach_in_collection leflib $::libGroups::lefCollection {
    set lMatch($::libGroups::lefMap([get_attribute $leflib name])) 0
  }
  foreach uSig $::libGroups::uniqueSignatures {
    set ::libGroups::lefMatch($uSig) [list]
  }
  
  array set desVsLef {}
  array set lefVsDbCells {}
  foreach_in_collection leflib $::libGroups::lefCollection {
    set lefSig [getSignature $leflib]
    foreach elem $lefSig {
      if { ! [info exists desVsLef($elem)] } {
	set desVsLef($elem) [list]
      }
      lappend desVsLef($elem) $leflib
    }
  }
  
  foreach uSig $::libGroups::uniqueSignatures {
    # Technically, each element of usig should only match 1 lef....
    foreach elem $uSig {
      # Could use this to find duplicate cells (ie, in multiple lef's). TBD!!!!
      if { [info exists desVsLef($elem)] } {
	foreach leflib $desVsLef($elem) {
	  lappend ::libGroups::lefMatch($uSig) $::libGroups::lefMap([get_attribute $leflib name])
	  set key $::libGroups::lefMap([get_attribute $leflib name])
	  incr lMatch($key)
	  if { ! [info exists lefVsDbCells($key)] } {
	    set lefVsDbCells($key) [list]
	  }
	  lappend lefVsDbCells($key) $elem
	}
      } else {
	# Warning - not in any lef?
	puts "** WARNING - DB design '$elem' does not exist in any LEF file"
      }
    }
  }
  
  foreach n [array names ::libGroups::lefMatch] {
    set ::libGroups::lefMatch($n) [lsort -uniq $::libGroups::lefMatch($n)]
    if { $::libGroups::debug > 0 } {
      puts "DEBUG: usig '$n':"
      foreach x $::libGroups::lefMatch($n) {
	puts " + $x"
      }
      puts ""
    }
  }
  
  puts "\nDB cells matching LEF files:"
  foreach n [array names lMatch] {
    if {$lMatch($n) == 0} {
      puts -nonewline " *** ZERO "
    } else {
      puts -nonewline " ... [format "%4d" $lMatch($n)] "
    }
    puts "match $n"
    if { $::libGroups::verbose > 0 && $lMatch($n) != 0 } {
      puts "         $lefVsDbCells($n)"
    }
  }
}


# with each dbs-lef group, check if those dbs can be in a scaling group.
proc libGroups::exploreScalingGroups {} {
  
  foreach uSig $::libGroups::uniqueSignatures {
    set libs $::libGroups::libDbs($uSig)
    if { [sizeof_collection $libs] <= 1 } { 
      continue
    }   
    
    set slgList [explore_scaling_group -libs $libs]
    if { [llength $slgList] == 0 } { 
      continue
    }   
    set ::libGroups::slg($uSig) $slgList
  }
}

# generates output, either a report or a script file
proc libGroups::generateOutput { outScriptFile } {
  puts ""
  
  if { [string length $outScriptFile] != 0 } {
    set report_script 1
    set outScript [open $outScriptFile "w"]
  } else {
    set report_script 0
  }
  
  set g 1
  foreach uSig $::libGroups::uniqueSignatures {
    if { $report_script } {
      puts $outScript "\# Group $g:"
      puts -nonewline $outScript  "create_workspace \"$g\""
      if {[info exists ::libGroups::orgByPvtSigs($uSig)]} {
	puts -nonewline $outScript " -organize_by_pvt"
      }
      
      if { [string length $::libGroups::tech] != 0 } {
	puts $outScript " -tech $::libGroups::tech"
      } else {
	puts $outScript ""
      }
    } else {
      puts ""
      if {[info exists ::libGroups::orgByPvtSigs($uSig)]} {
	set pvtGroup " (PVT)"
      } else {
	set pvtGroup ""
      }
      puts "Group ${g}${pvtGroup}:"
    }
    incr g
    set firstLib ""
    if { [llength $::libGroups::libDict($uSig)] != 0 } {
      if {$report_script} {
	set firstLib [lindex $::libGroups::libDict($uSig) 0]
	foreach l $::libGroups::libFiles($uSig) {
	  puts $outScript "read_db $l"
	}
      } else {
	foreach l $::libGroups::libDict($uSig) {
	  puts "   db $l"
	}
      }
    }
    if { [llength  $::libGroups::lefMatch($uSig)] != 0 } {
      if {$report_script } {
	foreach l $::libGroups::lefMatch($uSig) {
	  puts $outScript "read_lef $::libGroups::lefFiles($l)"
	}
	if { $firstLib eq "" } {
	  set firstLib leflib
	}
      } else {
	foreach l $::libGroups::lefMatch($uSig) {
	  puts "  lef $l"
	}
      }
    }
    
    if { [info exists ::libGroups::slg($uSig)] } {
      foreach l $::libGroups::slg($uSig) {
	if {$report_script } {
	  puts $outScript "create_scaling_group {$l}"
	} else {
	  puts "  scaling group {$l}"
	}
      }
    }
    
    if {$report_script} {
      puts $outScript "check_workspace"
      puts $outScript "commit_workspace -output ${firstLib}.ndm"
      puts $outScript "\n\n"
    }
  }
  
  # create physical_only lib if needed
  if { $report_script} {
    generateOutputForPhysicalOnly $outScript 
  } else {
    generateOutputForPhysicalOnly 0
  }
  
  if {$report_script} {
    close $outScript
  }
}

# generates output for physical_only lib
# outScript is an opened file pointer if an output script 
# file is specified otherwise is 0
proc libGroups::generateOutputForPhysicalOnly { outScript } {
  set size [array size ::libGroups::physOnlyCollection]
  if { $size == 0 } {
    return
  } 
  
  set groupName "physical_only"
  if { $outScript != 0 } {
    puts $outScript "\# Group $groupName:"
    puts -nonewline $outScript  "create_workspace \"$groupName\""
    puts -nonewline $outScript " -build_physical_only"
    if { [string length $::libGroups::tech] != 0 } {
      puts $outScript " -tech $::libGroups::tech"
    } else {
      puts $outScript ""
    }
  } else {
    puts ""
    puts "Group $groupName:"
  }
  
  # out dbs 
  array set wroteDb {}
  foreach lefname [array names ::libGroups::physOnlyCollection] {
    foreach_in_collection dbLib $::libGroups::physOnlyCollection($lefname) { 
      set dbName [get_attribute $dbLib name]
      set dbFile [get_attribute $dbLib source_file_name]
      if {![info exists wroteDb($dbFile)]} {
        set wroteDb($dbFile) 1
        if { $outScript != 0 } {
          puts $outScript "read_db $dbFile"
        } else {
          puts "   db $dbName"
        }
      }  
    }
  }

  # out lefs
  foreach lefName [array names ::libGroups::physOnlyCollection] {
    set lef $::libGroups::lefMap($lefName)
    set lefFile $::libGroups::lefFiles($lef)
    if { $outScript != 0 } {
      puts $outScript "read_lef $lefFile"
    } else {
      puts "  lef $lef"
    }
  }
  if { $outScript != 0 } {
    puts $outScript "check_workspace"
    puts $outScript "commit_workspace -output ${groupName}.ndm"
    puts $outScript "\n\n"
  } 
  
}

# initialize
proc libGroups::init {} {
  set ::libGroups::tech ""
  set ::libGroups::libCount 0
  set ::libGroups::uniqueSignatures [list]
  array unset ::libGroups::orgByPvtSigs
  array unset ::libGroups::originalSigs
  array unset ::libGroups::dbMap
  array unset ::libGroups::lefMap
  array unset ::libGroups::lefFiles
  array unset ::libGroups::lefMatch
  array unset ::libGroups::libFiles
  array unset ::libGroups::libDict
  set ::libGroups::dbCollection ""
  set ::libGroups::lefCollection ""
  array unset ::libGroups::physOnlyCollection
  array unset ::libGroups::slg
}



# Return 0 if equal or a proper subset. Else, return
# the count of extra db cells.

proc libGroups::isEqualOrProperSubset { dbSig lefSig } {
  if { $dbSig == $lefSig } {
    return 0
  }
  set len [llength [extraInDb $lefSig $dbSig]]
  if { $len == 0 } {
    return 0
  }
  return $len
}
proc libGroups::extraInDb { lefSig dbSig } {
  return [lminus $dbSig [lminus $lefSig [lminus $lefSig $dbSig]]]
}

  
  # Utility routines not currently used
  
  proc libGroups::compare_signature_pair { db lef } {
    set quiet 0
    set ii 0
    foreach s1 $::libGroups::uniqueSignatures {
      set us($ii) $s1
      if {$quiet == 0 && ($ii == $db || $ii == $lef) } {
	puts -nonewline "$ii "
	if { $ii == $db } {
	  puts -nonewline "(db)  :"
	} else {
	  puts -nonewline "(lef) :"
	} 
	puts " [llength $us($ii)] elements"
      }
      incr ii
    }
    
    set l3 [lminus $us($db) $us($lef)]
    if {[llength $l3] == 0} {
      # nothing
      if { [llength $us($db)] == [llength $us($lef)] } {
	puts "Perfect match!"
      } else {
	puts "db is a subset of lef!"
      }
    } elseif {[llength $l3] > 30} {
      if {$quiet == 0} {
	puts "$db vs $lef - differ by more than 30 elements"
      }
    } else {
      if {$quiet == 0} {
	puts " [llength $l3] objects in group $db not in group $lef:\n     '$l3'"
      }
    }
    
    ## Why?
    
    set l3 [lminus $us($lef) $us($db)]
    if {[llength $l3] == 0} {
      # nothing
    } elseif {[llength $l3] > 30} {
      if {$quiet == 0} {
	puts "$lef vs $db - differ by more than 30 elements"
      }
    } else {
      if {$quiet == 0 } {
	puts " [llength $l3] objects in group $lef not in group $db:\n     '$l3'"
      }
    }
  }
  
  proc libGroups::compare_signatures { {quiet 1} } {
    if { $quiet == 0 } {
      echo "Compare signatures:"
    }
    set count [llength $::libGroups::uniqueSignatures]
    set i 0
    foreach s1 $::libGroups::uniqueSignatures {
      set us($i) $s1
      if {$quiet == 0} {
	puts "$i : [llength $us($i)] elements"
      }
      incr i
    }
    if {[llength [array names us]] == 1} {
      set l3 [list ]
    } else {
      set l3 [lminus $us(1) $us(0)]
    }
    set i 0
    while {$i < $count} {
      set j [expr $i + 1]
      while {$j < $count} {
	set l3 [lminus $us($i) $us($j)]
	if {[llength $l3] == 0} {
	  # nothing
	} elseif {[llength $l3] > 30} {
	  if {$quiet == 0} {
	    puts "$i vs $j - differ by more than 30 elements"
	  }
	} else {
	  if {$quiet == 0} {
	    puts " [llength $l3] objects in group $i not in group $j:\n     '$l3'"
	  }
	}
	set l3 [lminus $us($j) $us($i)]
	if {[llength $l3] == 0} {
	  # nothing
	} elseif {[llength $l3] > 30} {
	  if {$quiet == 0} {
	    puts "$j vs $i - differ by more than 30 elements"
	  }
	} else {
	  if {$quiet == 0 } {
	    puts " [llength $l3] objects in group $j not in group $i:\n     '$l3'"
	  }
	}
	incr j
      }
      incr i
    }
  }
  
  proc libGroups::setDebug { value } {
    set ::libGroups::debug $value
  }
  
  proc libGroups::setVerbose { value } {
    set ::libGroups::verbose $value
  }
