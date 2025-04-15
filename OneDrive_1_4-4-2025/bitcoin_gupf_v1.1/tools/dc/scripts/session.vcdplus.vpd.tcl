# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Mon Aug 15 10:48:11 2016
# Designs open: 1
#   V1: vcdplus.vpd
# Toplevel windows open: 4
# 	TopLevel.1
# 	TopLevel.2
# 	TopLevel.3
# 	TopLevel.4
#   Source.1: siso
#   Wave.1: 12 signals
#   Wave.2: 7 signals
#   Wave.3: 7 signals
#   Group count = 13
#   Group Group1 signal count = 2
#   Group Group2 signal count = 1
#   Group Group3 signal count = 4
#   Group Group4 signal count = 1
#   Group Group5 signal count = 10
#   Group Group6 signal count = 0
#   Group Group7 signal count = 2
#   Group Group8 signal count = 0
#   Group Group9 signal count = 1
#   Group Group10 signal count = 6
#   Group Group11 signal count = 1
#   Group Group12 signal count = 2
#   Group Group13 signal count = 4
# End_DVE_Session_Save_Info

# DVE version: L-2016.06-SP1
# DVE build date: Aug 11 2016 21:07:25


#<Session mode="Full" path="/global/gtsna_benchmark3/gmaben/LP_TRAINING_NEW_DESIGN/bit_coin/session.vcdplus.vpd.tcl" type="Debug">

gui_set_loading_session_type Post
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all

# Close all windows
gui_close_window -type Console
gui_close_window -type Wave
gui_close_window -type Source
gui_close_window -type Schematic
gui_close_window -type Data
gui_close_window -type DriverLoad
gui_close_window -type List
gui_close_window -type Memory
gui_close_window -type HSPane
gui_close_window -type DLPane
gui_close_window -type Assertion
gui_close_window -type CovHier
gui_close_window -type CoverageTable
gui_close_window -type CoverageMap
gui_close_window -type CovDetail
gui_close_window -type Local
gui_close_window -type Stack
gui_close_window -type Watch
gui_close_window -type Group
gui_close_window -type Transaction



# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.1

if {![gui_exist_window -window TopLevel.1]} {
    set TopLevel.1 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.1 TopLevel.1
}
gui_show_window -window ${TopLevel.1} -show_state normal -rect {{31 74} {898 743}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_set_toolbar_attributes -toolbar {BackTrace} -dock_state top
gui_set_toolbar_attributes -toolbar {BackTrace} -offset 0
gui_show_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_hide_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 256]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
catch { set Power.1 [gui_share_window -id ${HSPane.1} -type Power -silent] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 256
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 255} {height 362} {dock_state left} {dock_on_new_line true} {child_hier_colhier 121} {child_hier_coltype 64} {child_hier_colpd 59} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 2}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 258]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 258
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 257} {height 362} {dock_state left} {dock_on_new_line true} {child_data_colvariable 129} {child_data_colvalue 59} {child_data_coltype 60} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set Console.1 [gui_create_window -type Console -parent ${TopLevel.1} -dock_state bottom -dock_on_new_line true -dock_extent 180]
gui_set_window_pref_key -window ${Console.1} -key dock_width -value_type integer -value 689
gui_set_window_pref_key -window ${Console.1} -key dock_height -value_type integer -value 180
gui_set_window_pref_key -window ${Console.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${Console.1} {{left 0} {top 0} {width 867} {height 179} {dock_state bottom} {dock_on_new_line true}}
#### Start - Readjusting docked view's offset / size
set dockAreaList { top left right bottom }
foreach dockArea $dockAreaList {
  set viewList [gui_ekki_get_window_ids -active_parent -dock_area $dockArea]
  foreach view $viewList {
      if {[lsearch -exact [gui_get_window_pref_keys -window $view] dock_width] != -1} {
        set dockWidth [gui_get_window_pref_value -window $view -key dock_width]
        set dockHeight [gui_get_window_pref_value -window $view -key dock_height]
        set offset [gui_get_window_pref_value -window $view -key dock_offset]
        if { [string equal "top" $dockArea] || [string equal "bottom" $dockArea]} {
          gui_set_window_attributes -window $view -dock_offset $offset -width $dockWidth
        } else {
          gui_set_window_attributes -window $view -dock_offset $offset -height $dockHeight
        }
      }
  }
}
#### End - Readjusting docked view's offset / size
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 [gui_create_window -type {Source}  -parent ${TopLevel.1}]
gui_show_window -window ${Source.1} -show_state maximized
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings


# Create and position top-level window: TopLevel.2

if {![gui_exist_window -window TopLevel.2]} {
    set TopLevel.2 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.2 TopLevel.2
}
gui_show_window -window ${TopLevel.2} -show_state minimized -rect {{314 274} {1790 858}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_set_toolbar_attributes -toolbar {BackTrace} -dock_state top
gui_set_toolbar_attributes -toolbar {BackTrace} -offset 0
gui_show_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
gui_sync_global -id ${TopLevel.2} -option true

# MDI window settings
set Wave.1 [gui_create_window -type {Wave}  -parent ${TopLevel.2}]
gui_show_window -window ${Wave.1} -show_state maximized
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 428} {child_wave_right 1043} {child_wave_colname 212} {child_wave_colvalue 212} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


# Create and position top-level window: TopLevel.3

if {![gui_exist_window -window TopLevel.3]} {
    set TopLevel.3 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.3 TopLevel.3
}
gui_show_window -window ${TopLevel.3} -show_state normal -rect {{378 349} {1854 933}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_set_toolbar_attributes -toolbar {BackTrace} -dock_state top
gui_set_toolbar_attributes -toolbar {BackTrace} -offset 0
gui_show_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
gui_sync_global -id ${TopLevel.3} -option true

# MDI window settings
set Wave.2 [gui_create_window -type {Wave}  -parent ${TopLevel.3}]
gui_show_window -window ${Wave.2} -show_state maximized
gui_update_layout -id ${Wave.2} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 428} {child_wave_right 1043} {child_wave_colname 212} {child_wave_colvalue 212} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


# Create and position top-level window: TopLevel.4

if {![gui_exist_window -window TopLevel.4]} {
    set TopLevel.4 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.4 TopLevel.4
}
gui_show_window -window ${TopLevel.4} -show_state normal -rect {{386 353} {1862 937}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_set_toolbar_attributes -toolbar {BackTrace} -dock_state top
gui_set_toolbar_attributes -toolbar {BackTrace} -offset 0
gui_show_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
gui_sync_global -id ${TopLevel.4} -option true

# MDI window settings
set Wave.3 [gui_create_window -type {Wave}  -parent ${TopLevel.4}]
gui_show_window -window ${Wave.3} -show_state maximized
gui_update_layout -id ${Wave.3} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 428} {child_wave_right 1043} {child_wave_colname 212} {child_wave_colvalue 212} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings

gui_set_env TOPLEVELS::TARGET_FRAME(Source) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Schematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(PathSchematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Wave) none
gui_set_env TOPLEVELS::TARGET_FRAME(List) none
gui_set_env TOPLEVELS::TARGET_FRAME(Memory) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(DriverLoad) none
gui_update_statusbar_target_frame ${TopLevel.1}
gui_update_statusbar_target_frame ${TopLevel.2}
gui_update_statusbar_target_frame ${TopLevel.3}
gui_update_statusbar_target_frame ${TopLevel.4}

#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {vcdplus.vpd}] } {
	gui_open_db -design V1 -file vcdplus.vpd -nosource
}
gui_set_precision 1s
gui_set_time_units 1s
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: User-defined Radicies
proc proc_tb/dut/bit_secure_2/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/BIT_COIN_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON_SIPO_OFF PISO_OFF_SIPO_ON SIPO_PISO_SLICE_MEM_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_3/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_1/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_0/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/BIT_TOP_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_SLICE_ON SIPO_SLICE_ON SIPO_PISO_SLICE_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_4/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_29/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_14/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_23/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_4/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_19/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_28/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_5/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_22/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_2/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_14/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_9/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_24/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_16/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_18/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_21/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_15/slice_25/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_15/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_11/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_7/slice_12/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_5/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_8/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_0/slice_10/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_13/slice_9/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_27/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_3/slice_17/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_31/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_11/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_2/slice_30/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_10/slice_26/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_6/slice_7/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_12/slice_13/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_1/slice_20/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
proc proc_tb/dut/bit_secure_8/slice_6/BIT_SLICE_PST { arg } {
 return [UPF_PST_MULTI_STATE_ENUM_NAME $arg [list ALL_ON PISO_ON SIPO_ON SIPO_PISO_OFF]] 
}
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/BIT_TOP_PST -proc proc_tb/dut/bit_secure_0/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/BIT_COIN_PST -proc proc_tb/dut/BIT_COIN_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/BIT_TOP_PST -proc proc_tb/dut/bit_secure_15/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/BIT_TOP_PST -proc proc_tb/dut/bit_secure_6/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/BIT_TOP_PST -proc proc_tb/dut/bit_secure_14/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/BIT_TOP_PST -proc proc_tb/dut/bit_secure_8/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/BIT_TOP_PST -proc proc_tb/dut/bit_secure_7/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/BIT_TOP_PST -proc proc_tb/dut/bit_secure_13/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/BIT_TOP_PST -proc proc_tb/dut/bit_secure_1/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/BIT_TOP_PST -proc proc_tb/dut/bit_secure_12/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/BIT_TOP_PST -proc proc_tb/dut/bit_secure_9/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/BIT_TOP_PST -proc proc_tb/dut/bit_secure_11/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/BIT_TOP_PST -proc proc_tb/dut/bit_secure_10/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/BIT_TOP_PST -proc proc_tb/dut/bit_secure_2/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/BIT_TOP_PST -proc proc_tb/dut/bit_secure_3/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_3/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_3/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/BIT_TOP_PST -proc proc_tb/dut/bit_secure_4/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_1/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_1/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_0/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_0/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/BIT_TOP_PST -proc proc_tb/dut/bit_secure_5/BIT_TOP_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_4/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_4/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_29/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_29/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_14/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_14/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_23/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_23/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_4/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_4/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_19/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_19/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_28/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_28/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_5/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_5/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_22/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_22/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_2/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_2/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_14/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_14/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_9/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_9/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_24/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_24/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_16/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_16/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_18/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_18/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_21/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_21/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_15/slice_25/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_15/slice_25/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_15/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_15/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_11/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_11/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_6/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_7/slice_12/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_7/slice_12/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_5/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_5/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_8/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_8/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_0/slice_10/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_0/slice_10/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_13/slice_9/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_13/slice_9/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_27/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_27/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_3/slice_17/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_3/slice_17/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_31/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_31/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_11/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_11/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_2/slice_30/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_2/slice_30/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_10/slice_26/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_10/slice_26/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_6/slice_7/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_6/slice_7/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_12/slice_13/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_12/slice_13/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_1/slice_20/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_1/slice_20/BIT_SLICE_PST -base dec
gui_set_userradix -name radix_tb/dut/bit_secure_8/slice_6/BIT_SLICE_PST -proc proc_tb/dut/bit_secure_8/slice_6/BIT_SLICE_PST -base dec


# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups


set _session_group_7 Group1
gui_sg_create "$_session_group_7"
set Group1 "$_session_group_7"

gui_sg_addsignal -group "$_session_group_7" { {<upf>.\tb/dut .PD_PISO_SECURE.SW_PISO_SECURE.sleep_signals_17_PISO_SECURE} {<upf>.\tb/dut .PD_PISO_SECURE.SW_PISO_SECURE.ack_signal_17_PISO_SECURE} }

set _session_group_8 Group2
gui_sg_create "$_session_group_8"
set Group2 "$_session_group_8"

gui_sg_addsignal -group "$_session_group_8" { {<upf>.\tb/dut .PD_PISO_SECURE.SW_PISO_SECURE.power_switch_state} }

set _session_group_9 Group3
gui_sg_create "$_session_group_9"
set Group3 "$_session_group_9"

gui_sg_addsignal -group "$_session_group_9" { tb.dut.sleep_signals tb.dut.isolation_signals tb.dut.power_ack_signals tb.dut.secure_data_in }

set _session_group_10 Group4
gui_sg_create "$_session_group_10"
set Group4 "$_session_group_10"

gui_sg_addsignal -group "$_session_group_10" { tb.dut.clk }

set _session_group_11 Group5
gui_sg_create "$_session_group_11"
set Group5 "$_session_group_11"

gui_sg_addsignal -group "$_session_group_11" { tb.dut.upf_simstate tb.dut.bit_secure_15.slice_31.sipo_bit.upf_simstate tb.dut.piso_secure_1.upf_simstate tb.dut.bit_secure_15.slice_31.piso_bit.upf_simstate tb.dut.isolation_signals tb.dut.sleep_signals tb.dut.switch_ack_signal tb.dut.data_valid tb.dut.secure_data_in tb.dut.clk }

set _session_group_12 Group6
gui_sg_create "$_session_group_12"
set Group6 "$_session_group_12"


set _session_group_13 Group7
gui_sg_create "$_session_group_13"
set Group7 "$_session_group_13"

gui_sg_addsignal -group "$_session_group_13" { tb.dut.power_ack_signals tb.dut.secure_data_out }

set _session_group_14 Group8
gui_sg_create "$_session_group_14"
set Group8 "$_session_group_14"


set _session_group_15 Group9
gui_sg_create "$_session_group_15"
set Group9 "$_session_group_15"

gui_sg_addsignal -group "$_session_group_15" { tb.dut.piso_secure_1.upf_simstate }

set _session_group_16 Group10
gui_sg_create "$_session_group_16"
set Group10 "$_session_group_16"

gui_sg_addsignal -group "$_session_group_16" { tb.dut.piso_secure_1.dout tb.dut.piso_secure_1.din tb.dut.piso_secure_1.clk tb.dut.piso_secure_1.reset tb.dut.piso_secure_1.load tb.dut.piso_secure_1.temp }

set _session_group_17 Group11
gui_sg_create "$_session_group_17"
set Group11 "$_session_group_17"

gui_sg_addsignal -group "$_session_group_17" { tb.dut.bit_secure_15.slice_31.sipo_bit.upf_simstate }

set _session_group_18 Group12
gui_sg_create "$_session_group_18"
set Group12 "$_session_group_18"

gui_sg_addsignal -group "$_session_group_18" { tb.dut.bit_secure_15.slice_31.sipo_bit.clk tb.dut.bit_secure_15.slice_31.sipo_bit.sin }

set _session_group_19 Group13
gui_sg_create "$_session_group_19"
set Group13 "$_session_group_19"

gui_sg_addsignal -group "$_session_group_19" { tb.dut.bit_secure_15.slice_31.sipo_bit.pout tb.dut.bit_secure_15.slice_31.sipo_bit.addr tb.dut.bit_secure_15.slice_31.sipo_bit.wr tb.dut.bit_secure_15.slice_31.sipo_bit.rd }

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 27260



# Save global setting...

# Wave/List view global setting
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {VirtPowSwitch 0} {UnnamedProcess 1} {UDP 0} {Function 1} {Block 1} {SrsnAndSpaCell 0} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {ClassDef 1} {VirtIsoCell 0} }
gui_list_set_filter -id ${Hier.1} -text {*}
gui_hier_list_init -id ${Hier.1}
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} tb}
catch {gui_list_expand -id ${Hier.1} tb.dut}
catch {gui_list_expand -id ${Hier.1} tb.dut.bit_secure_15}
catch {gui_list_expand -id ${Hier.1} tb.dut.bit_secure_15.slice_31}
catch {gui_list_select -id ${Hier.1} {tb.dut.bit_secure_15.slice_31.sipo_bit}}
gui_view_scroll -id ${Hier.1} -vertical -set 191
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Power 'Power.1'
gui_list_set_filter -id ${Power.1} -list { {Retention Strategy 1} {Isolation Strategy 1} {Implicit Supply Set 0} {All 0} {Power Switch 1} {Power State Table 1} {Explicit Supply Set 1} }
gui_list_set_filter -id ${Power.1} -text {*}
gui_change_design -id ${Power.1} -design V1
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_31 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_30 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_29 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_28 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_27 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_26 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_25 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_24 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_23 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_22 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_21 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_20 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_19 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_18 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_17 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_16 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_15 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_14 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_13 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_12 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_11 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_10 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_9 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_8 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_7 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_6 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_5 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_4 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_3 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_2 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_1 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0/slice_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut/bit_secure_0 }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut }}
catch {gui_list_expand -id ${Power.1} {<upf>.\tb/dut .PD_PISO_SECURE}}
catch { gui_list_select -id ${Power.1} {{<upf>.\tb/dut .PD_PISO_SECURE.SW_PISO_SECURE} }}

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -reset
gui_list_show_data -id ${Data.1} {tb.dut.bit_secure_15.slice_31.sipo_bit}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 191
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active siso rtl/siso.v
gui_src_value_annotate -id ${Source.1} -switch true
gui_set_env TOGGLE::VALUEANNOTATE 1
gui_view_scroll -id ${Source.1} -vertical -set 340
gui_src_set_reusable -id ${Source.1}

# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_create -id ${Wave.1} C2 28790
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 26376 29584
gui_list_add_group -id ${Wave.1} -after {New Group} {Group5}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group6}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group7}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group8}
gui_list_select -id ${Wave.1} {tb.dut.clk }
gui_seek_criteria -id ${Wave.1} {Any Edge}


gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group Group5  -item {tb.dut.bit_secure_15.slice_31.piso_bit.upf_simstate[31:0]} -position below

gui_marker_move -id ${Wave.1} {C1} 27260
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false

# View 'Wave.2'
gui_wv_sync -id ${Wave.2} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_create -id ${Wave.2} C2 28790
gui_marker_set_ref -id ${Wave.2}  C1
gui_wv_zoom_timerange -id ${Wave.2} 26872 30891
gui_list_add_group -id ${Wave.2} -after {New Group} {Group9}
gui_list_add_group -id ${Wave.2} -after {New Group} {Group10}
gui_list_select -id ${Wave.2} {tb.dut.piso_secure_1.temp }
gui_seek_criteria -id ${Wave.2} {Any Edge}


gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.2} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.2} -text {*}
gui_list_set_insertion_bar  -id ${Wave.2} -group Group10  -item {tb.dut.piso_secure_1.temp[15:0]} -position below

gui_marker_move -id ${Wave.2} {C1} 27260
gui_view_scroll -id ${Wave.2} -vertical -set 0
gui_show_grid -id ${Wave.2} -enable false

# View 'Wave.3'
gui_wv_sync -id ${Wave.3} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.3}  C1
gui_wv_zoom_timerange -id ${Wave.3} 0 34550
gui_list_add_group -id ${Wave.3} -after {New Group} {Group11}
gui_list_add_group -id ${Wave.3} -after {New Group} {Group12}
gui_list_add_group -id ${Wave.3} -after {New Group} {Group13}
gui_seek_criteria -id ${Wave.3} {Any Edge}



gui_set_env TOGGLE::DEFAULT_WAVE_WINDOW ${Wave.3}
gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.3} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.3} -text {*}
gui_list_set_insertion_bar  -id ${Wave.3} -group Group13  -item tb.dut.bit_secure_15.slice_31.sipo_bit.rd -position below

gui_marker_move -id ${Wave.3} {C1} 27260
gui_view_scroll -id ${Wave.3} -vertical -set 0
gui_show_grid -id ${Wave.3} -enable false
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.2}]} {
	gui_set_active_window -window ${TopLevel.2}
	gui_set_active_window -window ${Wave.1}
}
if {[gui_exist_window -window ${TopLevel.3}]} {
	gui_set_active_window -window ${TopLevel.3}
	gui_set_active_window -window ${Wave.2}
}
if {[gui_exist_window -window ${TopLevel.1}]} {
	gui_set_active_window -window ${TopLevel.1}
	gui_set_active_window -window ${Source.1}
	gui_set_active_window -window ${DLPane.1}
}
if {[gui_exist_window -window ${TopLevel.4}]} {
	gui_set_active_window -window ${TopLevel.4}
	gui_set_active_window -window ${Wave.3}
}
#</Session>

