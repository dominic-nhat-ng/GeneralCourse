STIL 1.0 {
    CTL P2001.10;
    Design 2005;
}
Header {
    Title "Minimal STIL for design `bit_slice'";
    Date "Mon Oct  2 10:25:03 2017";
    Source "DFT Compiler M-2016.12-SP5";
}
Signals {
    "data_valid" In;
    "hclk" In;
    "hv_scan_in" In;
    "isolation_signals[0]" In;
    "isolation_signals[1]" In;
    "lclk" In;
    "lv_scan_in" In;
    "memory_sleep" In;
    "piso_scan_in" In;
    "reset" In;
    "retention_signals[0]" In;
    "retention_signals[1]" In;
    "scan_enable" In;
    "shut_down_signals[0]" In;
    "shut_down_signals[1]" In;
    "sin" In;
    "sipo_scan_in" In;
    "PG_ack_signals[0]" Out;
    "PG_ack_signals[1]" Out;
    "hv_scan_out" Out;
    "lv_scan_out" Out;
    "memory_ack" Out;
    "piso_scan_out" Out;
    "sipo_scan_out" Out;
    "sout" Out;
    "temp_0_reg/SI" Pseudo;
    "lreset_sync/reset_sync_reg/Q" Pseudo;
    "sipo_bit/pout_reg_8_/SI" Pseudo;
    "sipo_bit/pout_reg_9_/Q" Pseudo;
    "piso_bit/temp_reg_7_/SI" Pseudo;
    "piso_bit/temp_reg_6_/Q" Pseudo;
    "sync_data2mem/dut_sync/t_sync_out_reg_8_/SI" Pseudo;
    "hreset_sync/reset_sync_reg/Q" Pseudo;
}
SignalGroups  {
    "all_inputs" = '"data_valid" + "hclk" + "hv_scan_in" + 
    "isolation_signals[0]" + "isolation_signals[1]" + "lclk" + "lv_scan_in" + 
    "memory_sleep" + "piso_scan_in" + "reset" + "retention_signals[0]" + 
    "retention_signals[1]" + "scan_enable" + "shut_down_signals[0]" + 
    "shut_down_signals[1]" + "sin" + "sipo_scan_in"';
    "all_outputs" = '"PG_ack_signals[0]" + "PG_ack_signals[1]" + "hv_scan_out" + 
    "lv_scan_out" + "memory_ack" + "piso_scan_out" + "sipo_scan_out" + "sout"';
    "all_ports" = '"all_inputs" + "all_outputs"';
    "_pi" = '"data_valid" + "hclk" + "hv_scan_in" + "isolation_signals[0]" + 
    "isolation_signals[1]" + "lclk" + "lv_scan_in" + "memory_sleep" + 
    "piso_scan_in" + "reset" + "retention_signals[0]" + "retention_signals[1]" + 
    "scan_enable" + "shut_down_signals[0]" + "shut_down_signals[1]" + "sin" + 
    "sipo_scan_in"';
    "_po" = '"PG_ack_signals[0]" + "PG_ack_signals[1]" + "hv_scan_out" + 
    "lv_scan_out" + "memory_ack" + "piso_scan_out" + "sipo_scan_out" + "sout"';
}
SignalGroups all_dft_protocol {
    "_clk" = '"hclk" + "lclk" + "reset"';
}
SignalGroups Internal_scan {
    "_si" = '"hv_scan_in" + "lv_scan_in" + "piso_scan_in" + "sipo_scan_in"' {
        ScanIn;
    }
    "_so" = '"hv_scan_out" + "lv_scan_out" + "piso_scan_out" + "sipo_scan_out"' 
    {
        ScanOut;
    }
    "_clk" = '"hclk" + "lclk" + "reset"';
}
ScanStructures Internal_scan {
    ScanChain "1" {
        ScanLength 38;
        ScanCells "temp_0_reg" "temp_1_reg" "temp_2_reg" 
        "load_data_from_memory_reg" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_14_" 
        "sync_datafrommem/dut_sync/sync_out_reg_14_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_5_" 
        "sync_datafrommem/dut_sync/sync_out_reg_5_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_6_" 
        "sync_datafrommem/dut_sync/sync_out_reg_6_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_7_" 
        "sync_datafrommem/dut_sync/sync_out_reg_7_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_15_" 
        "sync_datafrommem/dut_sync/sync_out_reg_15_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_12_" 
        "sync_datafrommem/dut_sync/sync_out_reg_12_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_4_" 
        "sync_datafrommem/dut_sync/sync_out_reg_4_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_1_" 
        "sync_datafrommem/dut_sync/sync_out_reg_1_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_2_" 
        "sync_datafrommem/dut_sync/sync_out_reg_2_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_0_" 
        "sync_datafrommem/dut_sync/sync_out_reg_0_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_3_" 
        "sync_datafrommem/dut_sync/sync_out_reg_3_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_9_" 
        "sync_datafrommem/dut_sync/sync_out_reg_9_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_10_" 
        "sync_datafrommem/dut_sync/sync_out_reg_10_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_8_" 
        "sync_datafrommem/dut_sync/sync_out_reg_8_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_13_" 
        "sync_datafrommem/dut_sync/sync_out_reg_13_" 
        "sync_datafrommem/dut_sync/t_sync_out_reg_11_" 
        "sync_datafrommem/dut_sync/sync_out_reg_11_" 
        "lreset_sync/t_reset_sync_reg" "lreset_sync/reset_sync_reg";
        ScanIn "sipo_scan_in";
        ScanOut "sipo_scan_out";
        ScanEnable "scan_enable";
        ScanMasterClock "lclk";
    }
    ScanChain "2" {
        ScanLength 53;
        ScanCells "sipo_bit/pout_reg_8_" "sipo_bit/tmp_reg_7_" 
        "sipo_bit/tmp_reg_8_" "sipo_bit/addr_reg_2_" "sipo_bit/pout_reg_1_" 
        "sipo_bit/tmp_reg_10_" "sipo_bit/tmp_reg_0_" "sipo_bit/tmp_reg_4_" 
        "sipo_bit/addr_reg_3_" "sipo_bit/wr_addr_reg_3_" 
        "sipo_bit/wr_addr_reg_2_" "sipo_bit/rd_addr_reg_3_" 
        "sipo_bit/addr_reg_0_" "sipo_bit/pout_reg_5_" "sipo_bit/pout_reg_14_" 
        "sipo_bit/addr_reg_1_" "sipo_bit/pout_reg_6_" "sipo_bit/pout_reg_3_" 
        "sipo_bit/rd_addr_reg_1_" "sipo_bit/wr_addr_reg_1_" 
        "sipo_bit/rd_addr_reg_2_" "sipo_bit/tmp_reg_14_" "sipo_bit/tmp_reg_6_" 
        "sipo_bit/tmp_reg_12_" "sipo_bit/tmp_reg_1_" "sipo_bit/pout_reg_10_" 
        "sipo_bit/pout_reg_0_" "sipo_bit/pout_reg_12_" "sipo_bit/tmp_reg_9_" 
        "sipo_bit/wr_tmp_reg" "sipo_bit/tmp_reg_3_" "sipo_bit/rd_addr_reg_0_" 
        "sipo_bit/wr_addr_reg_0_" "sipo_bit/wr_reg" "sipo_bit/count_reg_2_" 
        "sipo_bit/count_reg_3_" "sipo_bit/pout_reg_11_" "sipo_bit/pout_reg_13_" 
        "sipo_bit/pout_reg_15_" "sipo_bit/pout_reg_4_" "sipo_bit/count_reg_1_" 
        "sipo_bit/count_reg_0_" "sipo_bit/pout_reg_2_" "sipo_bit/rd_reg" 
        "sipo_bit/tmp_reg_15_" "sipo_bit/tmp_reg_5_" "sipo_bit/tmp_reg_11_" 
        "sipo_bit/tmp_reg_2_" "sipo_bit/tmp_reg_13_" "sipo_bit/pout_reg_7_" 
        "sipo_bit/wr_1_reg" "sipo_bit/wr_0_reg" "sipo_bit/pout_reg_9_";
        ScanIn "piso_scan_in";
        ScanOut "piso_scan_out";
        ScanEnable "scan_enable";
        ScanMasterClock "lclk";
    }
    ScanChain "3" {
        ScanLength 17;
        ScanCells "piso_bit/temp_reg_7_" "piso_bit/temp_reg_4_" 
        "piso_bit/temp_reg_1_" "piso_bit/temp_reg_8_" "piso_bit/temp_reg_9_" 
        "piso_bit/temp_reg_3_" "piso_bit/temp_reg_10_" "piso_bit/temp_reg_0_" 
        "piso_bit/temp_reg_11_" "piso_bit/temp_reg_15_" "piso_bit/temp_reg_12_" 
        "piso_bit/temp_reg_2_" "piso_bit/dout_reg" "piso_bit/temp_reg_14_" 
        "piso_bit/temp_reg_13_" "piso_bit/temp_reg_5_" "piso_bit/temp_reg_6_";
        ScanIn "hv_scan_in";
        ScanOut "hv_scan_out";
        ScanEnable "scan_enable";
        ScanMasterClock "lclk";
    }
    ScanChain "4" {
        ScanLength 42;
        ScanCells "sync_data2mem/dut_sync/t_sync_out_reg_8_" 
        "sync_data2mem/dut_sync/sync_out_reg_8_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_1_" 
        "sync_data2mem/dut_sync/sync_out_reg_1_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_0_" 
        "sync_data2mem/dut_sync/sync_out_reg_0_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_10_" 
        "sync_data2mem/dut_sync/sync_out_reg_10_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_7_" 
        "sync_data2mem/dut_sync/sync_out_reg_7_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_5_" 
        "sync_data2mem/dut_sync/sync_out_reg_5_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_14_" 
        "sync_data2mem/dut_sync/sync_out_reg_14_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_12_" 
        "sync_data2mem/dut_sync/sync_out_reg_12_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_4_" 
        "sync_data2mem/dut_sync/sync_out_reg_4_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_6_" 
        "sync_data2mem/dut_sync/sync_out_reg_6_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_2_" 
        "sync_data2mem/dut_sync/sync_out_reg_2_" 
        "sync_add2mem/dut_sync/t_sync_out_reg_1_" 
        "sync_add2mem/dut_sync/sync_out_reg_1_" 
        "sync_add2mem/dut_sync/t_sync_out_reg_3_" 
        "sync_add2mem/dut_sync/sync_out_reg_3_" 
        "sync_add2mem/dut_sync/t_sync_out_reg_0_" 
        "sync_add2mem/dut_sync/sync_out_reg_0_" 
        "sync_add2mem/dut_sync/t_sync_out_reg_2_" 
        "sync_add2mem/dut_sync/sync_out_reg_2_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_3_" 
        "sync_data2mem/dut_sync/sync_out_reg_3_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_15_" 
        "sync_data2mem/dut_sync/sync_out_reg_15_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_13_" 
        "sync_data2mem/dut_sync/sync_out_reg_13_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_11_" 
        "sync_data2mem/dut_sync/sync_out_reg_11_" 
        "sync_data2mem/dut_sync/t_sync_out_reg_9_" 
        "sync_data2mem/dut_sync/sync_out_reg_9_" "hreset_sync/t_reset_sync_reg" 
        "hreset_sync/reset_sync_reg";
        ScanIn "lv_scan_in";
        ScanOut "lv_scan_out";
        ScanEnable "scan_enable";
        ScanMasterClock "hclk";
    }
}
Timing  {
    WaveformTable "_default_WFT_" {
        Period '100ns';
        Waveforms {
            "all_inputs" {
                0 {
                    '0ns' D;
                }
            }
            "all_inputs" {
                1 {
                    '0ns' U;
                }
            }
            "all_inputs" {
                Z {
                    '0ns' Z;
                }
            }
            "all_inputs" {
                N {
                    '0ns' N;
                }
            }
            "all_outputs" {
                X {
                    '0ns' X;
                    '40ns' X;
                }
            }
            "all_outputs" {
                H {
                    '0ns' X;
                    '40ns' H;
                }
            }
            "all_outputs" {
                T {
                    '0ns' X;
                    '40ns' T;
                }
            }
            "all_outputs" {
                L {
                    '0ns' X;
                    '40ns' L;
                }
            }
            "hclk" {
                P {
                    '0ns' D;
                    '45ns' U;
                    '55ns' D;
                }
            }
            "lclk" {
                P {
                    '0ns' D;
                    '45ns' U;
                    '55ns' D;
                }
            }
            "reset" {
                P {
                    '0ns' U;
                    '45ns' D;
                    '55ns' U;
                }
            }
        }
    }
    WaveformTable "_multiclock_capture_WFT_" {
        Period '100ns';
        Waveforms {
            "all_inputs" {
                0 {
                    '0ns' D;
                }
            }
            "all_inputs" {
                1 {
                    '0ns' U;
                }
            }
            "all_inputs" {
                Z {
                    '0ns' Z;
                }
            }
            "all_inputs" {
                N {
                    '0ns' N;
                }
            }
            "all_outputs" {
                X {
                    '0ns' X;
                    '40ns' X;
                }
            }
            "all_outputs" {
                H {
                    '0ns' X;
                    '40ns' H;
                }
            }
            "all_outputs" {
                T {
                    '0ns' X;
                    '40ns' T;
                }
            }
            "all_outputs" {
                L {
                    '0ns' X;
                    '40ns' L;
                }
            }
            "hclk" {
                P {
                    '0ns' D;
                    '45ns' U;
                    '55ns' D;
                }
            }
            "lclk" {
                P {
                    '0ns' D;
                    '45ns' U;
                    '55ns' D;
                }
            }
            "reset" {
                P {
                    '0ns' U;
                    '45ns' D;
                    '55ns' U;
                }
            }
        }
    }
    WaveformTable "_allclock_capture_WFT_" {
        Period '100ns';
        Waveforms {
            "all_inputs" {
                0 {
                    '0ns' D;
                }
            }
            "all_inputs" {
                1 {
                    '0ns' U;
                }
            }
            "all_inputs" {
                Z {
                    '0ns' Z;
                }
            }
            "all_inputs" {
                N {
                    '0ns' N;
                }
            }
            "all_outputs" {
                X {
                    '0ns' X;
                    '40ns' X;
                }
            }
            "all_outputs" {
                H {
                    '0ns' X;
                    '40ns' H;
                }
            }
            "all_outputs" {
                T {
                    '0ns' X;
                    '40ns' T;
                }
            }
            "all_outputs" {
                L {
                    '0ns' X;
                    '40ns' L;
                }
            }
            "hclk" {
                P {
                    '0ns' D;
                    '45ns' U;
                    '55ns' D;
                }
            }
            "lclk" {
                P {
                    '0ns' D;
                    '45ns' U;
                    '55ns' D;
                }
            }
            "reset" {
                P {
                    '0ns' U;
                    '45ns' D;
                    '55ns' U;
                }
            }
        }
    }
    WaveformTable "_allclock_launch_WFT_" {
        Period '100ns';
        Waveforms {
            "all_inputs" {
                0 {
                    '0ns' D;
                }
            }
            "all_inputs" {
                1 {
                    '0ns' U;
                }
            }
            "all_inputs" {
                Z {
                    '0ns' Z;
                }
            }
            "all_inputs" {
                N {
                    '0ns' N;
                }
            }
            "all_outputs" {
                X {
                    '0ns' X;
                    '40ns' X;
                }
            }
            "all_outputs" {
                H {
                    '0ns' X;
                    '40ns' H;
                }
            }
            "all_outputs" {
                T {
                    '0ns' X;
                    '40ns' T;
                }
            }
            "all_outputs" {
                L {
                    '0ns' X;
                    '40ns' L;
                }
            }
            "hclk" {
                P {
                    '0ns' D;
                    '45ns' U;
                    '55ns' D;
                }
            }
            "lclk" {
                P {
                    '0ns' D;
                    '45ns' U;
                    '55ns' D;
                }
            }
            "reset" {
                P {
                    '0ns' U;
                    '45ns' D;
                    '55ns' U;
                }
            }
        }
    }
    WaveformTable "_allclock_launch_capture_WFT_" {
        Period '100ns';
        Waveforms {
            "all_inputs" {
                0 {
                    '0ns' D;
                }
            }
            "all_inputs" {
                1 {
                    '0ns' U;
                }
            }
            "all_inputs" {
                Z {
                    '0ns' Z;
                }
            }
            "all_inputs" {
                N {
                    '0ns' N;
                }
            }
            "all_outputs" {
                X {
                    '0ns' X;
                    '40ns' X;
                }
            }
            "all_outputs" {
                H {
                    '0ns' X;
                    '40ns' H;
                }
            }
            "all_outputs" {
                T {
                    '0ns' X;
                    '40ns' T;
                }
            }
            "all_outputs" {
                L {
                    '0ns' X;
                    '40ns' L;
                }
            }
            "hclk" {
                P {
                    '0ns' D;
                    '45ns' U;
                    '55ns' D;
                }
            }
            "lclk" {
                P {
                    '0ns' D;
                    '45ns' U;
                    '55ns' D;
                }
            }
            "reset" {
                P {
                    '0ns' U;
                    '45ns' D;
                    '55ns' U;
                }
            }
        }
    }
}
PatternBurst "__burst__" {
    PatList {
        "bit_slice_Internal_scan_patterns" {
            SignalGroups Internal_scan;
            ScanStructures Internal_scan;
            Procedures Internal_scan;
            MacroDefs Internal_scan;
        }
    }
}
PatternExec  {
    PatternBurst "__burst__";
}
Procedures all_dft_protocol {
    "multiclock_capture" {
        W "_multiclock_capture_WFT_";
        C {
            "hclk" = 0;
            "lclk" = 0;
            "reset" = 1;
            "PG_ack_signals[0]" = X;
            "PG_ack_signals[1]" = X;
            "hv_scan_out" = X;
            "lv_scan_out" = X;
            "memory_ack" = X;
            "piso_scan_out" = X;
            "sipo_scan_out" = X;
            "sout" = X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_po" = \r8 #;
            "_pi" = \r17 #;
        }
    }
    "allclock_capture" {
        W "_allclock_capture_WFT_";
        C {
            "hclk" = 0;
            "lclk" = 0;
            "reset" = 1;
            "PG_ack_signals[0]" = X;
            "PG_ack_signals[1]" = X;
            "hv_scan_out" = X;
            "lv_scan_out" = X;
            "memory_ack" = X;
            "piso_scan_out" = X;
            "sipo_scan_out" = X;
            "sout" = X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_po" = \r8 #;
            "_pi" = \r17 #;
        }
    }
    "allclock_launch" {
        W "_allclock_launch_WFT_";
        C {
            "hclk" = 0;
            "lclk" = 0;
            "reset" = 1;
            "PG_ack_signals[0]" = X;
            "PG_ack_signals[1]" = X;
            "hv_scan_out" = X;
            "lv_scan_out" = X;
            "memory_ack" = X;
            "piso_scan_out" = X;
            "sipo_scan_out" = X;
            "sout" = X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_po" = \r8 #;
            "_pi" = \r17 #;
        }
    }
    "allclock_launch_capture" {
        W "_allclock_launch_capture_WFT_";
        C {
            "hclk" = 0;
            "lclk" = 0;
            "reset" = 1;
            "PG_ack_signals[0]" = X;
            "PG_ack_signals[1]" = X;
            "hv_scan_out" = X;
            "lv_scan_out" = X;
            "memory_ack" = X;
            "piso_scan_out" = X;
            "sipo_scan_out" = X;
            "sout" = X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_po" = \r8 #;
            "_pi" = \r17 #;
        }
    }
}
Procedures Internal_scan {
    "multiclock_capture" {
        W "_multiclock_capture_WFT_";
        C {
            "all_inputs" = N0N000NNN111 \r5 N;
            "all_outputs" = \r8 X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_pi" = \r17 #;
            "_po" = \r8 #;
        }
    }
    "allclock_capture" {
        W "_allclock_capture_WFT_";
        C {
            "all_inputs" = N0N000NNN111 \r5 N;
            "all_outputs" = \r8 X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_pi" = \r17 #;
            "_po" = \r8 #;
        }
    }
    "allclock_launch" {
        W "_allclock_launch_WFT_";
        C {
            "all_inputs" = N0N000NNN111 \r5 N;
            "all_outputs" = \r8 X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_pi" = \r17 #;
            "_po" = \r8 #;
        }
    }
    "allclock_launch_capture" {
        W "_allclock_launch_capture_WFT_";
        C {
            "all_inputs" = N0N000NNN111 \r5 N;
            "all_outputs" = \r8 X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_pi" = \r17 #;
            "_po" = \r8 #;
        }
    }
    "load_unload" {
        W "_default_WFT_";
        C {
            "all_inputs" = N0N000NNN111 \r5 N;
            "all_outputs" = \r8 X;
        }
        "Internal_scan_pre_shift" : V {
            "scan_enable" = 1;
        }
        Shift {
            V {
                "_clk" = PP1;
                "_si" = ####;
                "_so" = ####;
            }
        }
    }
}
Procedures Mission_mode {
    "multiclock_capture" {
        W "_multiclock_capture_WFT_";
        C {
            "all_inputs" = N0N000NNN111 \r5 N;
            "all_outputs" = \r8 X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_pi" = \r17 #;
            "_po" = \r8 #;
        }
    }
    "allclock_capture" {
        W "_allclock_capture_WFT_";
        C {
            "all_inputs" = N0N000NNN111 \r5 N;
            "all_outputs" = \r8 X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_pi" = \r17 #;
            "_po" = \r8 #;
        }
    }
    "allclock_launch" {
        W "_allclock_launch_WFT_";
        C {
            "all_inputs" = N0N000NNN111 \r5 N;
            "all_outputs" = \r8 X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_pi" = \r17 #;
            "_po" = \r8 #;
        }
    }
    "allclock_launch_capture" {
        W "_allclock_launch_capture_WFT_";
        C {
            "all_inputs" = N0N000NNN111 \r5 N;
            "all_outputs" = \r8 X;
        }
        F {
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "_pi" = \r17 #;
            "_po" = \r8 #;
        }
    }
}
MacroDefs all_dft_protocol {
    "test_setup" {
        W "_default_WFT_";
        V {
            "hclk" = 0;
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "lclk" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "reset" = 1;
        }
    }
}
MacroDefs Internal_scan {
    "test_setup" {
        W "_default_WFT_";
        C {
            "all_inputs" = \r17 N;
            "all_outputs" = \r8 X;
        }
        V {
            "hclk" = 0;
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "lclk" = 0;
            "reset" = 1;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
        }
    }
}
MacroDefs Mission_mode {
    "test_setup" {
        W "_default_WFT_";
        C {
            "all_inputs" = \r17 N;
            "all_outputs" = \r8 X;
        }
        V {
            "hclk" = 0;
            "isolation_signals[0]" = 0;
            "isolation_signals[1]" = 0;
            "lclk" = 0;
            "retention_signals[0]" = 1;
            "retention_signals[1]" = 1;
        }
        V {
            "reset" = 1;
        }
    }
}
Environment "bit_slice" {
    CTL  {
    }
    CTL all_dft_user {
        TestMode ForInheritOnly;
        Internal {
            "hclk" {
                DataType ScanMasterClock MasterClock {
                    ActiveState ForceUp;
                }
            }
            "isolation_signals[0]" {
                DataType Constant {
                    ActiveState ForceDown;
                }
            }
            "isolation_signals[1]" {
                DataType Constant {
                    ActiveState ForceDown;
                }
            }
            "lclk" {
                DataType ScanMasterClock MasterClock {
                    ActiveState ForceUp;
                }
            }
            "reset" {
                DataType Reset {
                    ActiveState ForceDown;
                }
            }
            "retention_signals[0]" {
                DataType Constant {
                    ActiveState ForceUp;
                }
            }
            "retention_signals[1]" {
                DataType Constant {
                    ActiveState ForceUp;
                }
            }
        }
    }
    CTL all_dft_protocol {
        TestMode ForInheritOnly;
        Inherit all_dft_user;
        DomainReferences {
            SignalGroups all_dft_protocol;
            Procedures all_dft_protocol;
            MacroDefs all_dft_protocol;
        }
    }
    CTL all_dft {
        TestMode ForInheritOnly;
        Inherit all_dft_protocol;
        Internal {
            "scan_enable" {
                CaptureClock "lclk" {
                    LeadingEdge;
                }
                CaptureClock "hclk" {
                    LeadingEdge;
                }
            }
        }
    }
    CTL Internal_scan_user {
        TestMode ForInheritOnly;
        Inherit all_dft;
        Internal {
            "scan_enable" {
                CaptureClock "lclk" {
                    LeadingEdge;
                }
                CaptureClock "hclk" {
                    LeadingEdge;
                }
            }
        }
    }
    CTL Internal_scan_protocol {
        TestMode ForInheritOnly;
        Inherit Internal_scan_user;
        Internal {
            "scan_enable" {
                CaptureClock "lclk" {
                    LeadingEdge;
                }
                CaptureClock "hclk" {
                    LeadingEdge;
                }
            }
        }
    }
    CTL Internal_scan {
        TestMode InternalTest;
        Focus Top {
        }
        Inherit Internal_scan_protocol;
        DomainReferences {
            SignalGroups Internal_scan;
            ScanStructures Internal_scan;
            MacroDefs Internal_scan;
            Procedures Internal_scan;
        }
        Internal {
            "hclk" {
                DataType ScanMasterClock MasterClock;
            }
            "hv_scan_in" {
                IsConnected In {
                    Signal "piso_bit/temp_reg_7_/SI";
                }
                CaptureClock "lclk" {
                    LeadingEdge;
                }
                DataType ScanDataIn {
                    ScanDataType Internal;
                }
                ScanStyle MultiplexedData;
            }
            "lclk" {
                DataType ScanMasterClock MasterClock;
            }
            "lv_scan_in" {
                IsConnected In {
                    Signal "sync_data2mem/dut_sync/t_sync_out_reg_8_/SI";
                }
                CaptureClock "hclk" {
                    LeadingEdge;
                }
                DataType ScanDataIn {
                    ScanDataType Internal;
                }
                ScanStyle MultiplexedData;
            }
            "piso_scan_in" {
                IsConnected In {
                    Signal "sipo_bit/pout_reg_8_/SI";
                }
                CaptureClock "lclk" {
                    LeadingEdge;
                }
                DataType ScanDataIn {
                    ScanDataType Internal;
                }
                ScanStyle MultiplexedData;
            }
            "scan_enable" {
                CaptureClock "lclk" {
                    LeadingEdge;
                }
                CaptureClock "hclk" {
                    LeadingEdge;
                }
                DataType TestMode TestData ScanEnable {
                    ActiveState ForceUp;
                }
            }
            "sipo_scan_in" {
                IsConnected In {
                    Signal "temp_0_reg/SI";
                }
                CaptureClock "lclk" {
                    LeadingEdge;
                }
                DataType ScanDataIn {
                    ScanDataType Internal;
                }
                ScanStyle MultiplexedData;
            }
            "hv_scan_out" {
                IsConnected Out {
                    Signal "piso_bit/temp_reg_6_/Q";
                }
                LaunchClock "lclk" {
                    LeadingEdge;
                }
                DataType ScanDataOut {
                    ScanDataType Internal;
                }
                ScanStyle MultiplexedData;
            }
            "lv_scan_out" {
                IsConnected Out {
                    Signal "hreset_sync/reset_sync_reg/Q";
                }
                LaunchClock "hclk" {
                    LeadingEdge;
                }
                DataType ScanDataOut {
                    ScanDataType Internal;
                }
                ScanStyle MultiplexedData;
            }
            "piso_scan_out" {
                IsConnected Out {
                    Signal "sipo_bit/pout_reg_9_/Q";
                }
                LaunchClock "lclk" {
                    LeadingEdge;
                }
                DataType ScanDataOut {
                    ScanDataType Internal;
                }
                ScanStyle MultiplexedData;
            }
            "sipo_scan_out" {
                IsConnected Out {
                    Signal "lreset_sync/reset_sync_reg/Q";
                }
                LaunchClock "lclk" {
                    LeadingEdge;
                }
                DataType ScanDataOut {
                    ScanDataType Internal;
                }
                ScanStyle MultiplexedData;
            }
        }
    }
    CTL Mission_mode_user {
        TestMode ForInheritOnly;
        Inherit all_dft;
        Internal {
            "scan_enable" {
                CaptureClock "lclk" {
                    LeadingEdge;
                }
                CaptureClock "hclk" {
                    LeadingEdge;
                }
            }
        }
    }
    CTL Mission_mode_protocol {
        TestMode ForInheritOnly;
        Inherit Mission_mode_user;
        Internal {
            "scan_enable" {
                CaptureClock "lclk" {
                    LeadingEdge;
                }
                CaptureClock "hclk" {
                    LeadingEdge;
                }
            }
        }
    }
    CTL Mission_mode {
        TestMode Normal;
        Inherit Mission_mode_protocol;
        DomainReferences {
            MacroDefs Mission_mode;
            Procedures Mission_mode;
        }
        Internal {
            "data_valid" {
                DataType Functional;
            }
            "hclk" {
                DataType Functional;
            }
            "hv_scan_in" {
                DataType Functional;
            }
            "isolation_signals[0]" {
                DataType Functional;
            }
            "isolation_signals[1]" {
                DataType Functional;
            }
            "lclk" {
                DataType Functional;
            }
            "lv_scan_in" {
                DataType Functional;
            }
            "memory_sleep" {
                DataType Functional;
            }
            "piso_scan_in" {
                DataType Functional;
            }
            "reset" {
                DataType Functional;
            }
            "retention_signals[0]" {
                DataType Functional;
            }
            "retention_signals[1]" {
                DataType Functional;
            }
            "scan_enable" {
                CaptureClock "lclk" {
                    LeadingEdge;
                }
                CaptureClock "hclk" {
                    LeadingEdge;
                }
                DataType TestMode TestData Functional {
                    ActiveState ForceUp;
                }
            }
            "shut_down_signals[0]" {
                DataType Functional;
            }
            "shut_down_signals[1]" {
                DataType Functional;
            }
            "sin" {
                DataType Functional;
            }
            "sipo_scan_in" {
                DataType Functional;
            }
            "PG_ack_signals[0]" {
                DataType Functional;
            }
            "PG_ack_signals[1]" {
                DataType Functional;
            }
            "hv_scan_out" {
                DataType Functional;
            }
            "lv_scan_out" {
                DataType Functional;
            }
            "memory_ack" {
                DataType Functional;
            }
            "piso_scan_out" {
                DataType Functional;
            }
            "sipo_scan_out" {
                DataType Functional;
            }
            "sout" {
                DataType Functional;
            }
        }
    }
}
Environment dftSpec {
    CTL  {
    }
    CTL all_dft {
        TestMode ForInheritOnly;
    }
    CTL Internal_scan {
        TestMode InternalTest;
        Inherit all_dft;
    }
    CTL Mission_mode {
        TestMode InternalTest;
        Inherit all_dft;
    }
}

