proc iso_check {} {
foreach PD [query_power_domain *] {
  foreach ISO_POLICY [query_isolation * -domain $PD] {
    array set iso_detail [query_isolation $ISO_POLICY -domain $PD -detailed]
    set PD_NAME [list PD_NAME $iso_detail(domain)]
        set isoSupply [list isoSupply $iso_detail(isolation_power_net)]
        set isoGround [list isoGround $iso_detail(isolation_ground_net)]
        set ISO_IN  [list ISO_IN UPF_GENERIC_DATA]
        set ISO_OUT [list ISO_OUT UPF_GENERIC_OUTPUT]
        set ISOEN [list ISOEN $iso_detail(isolation_signal)]
    set ISO_PWR_NET_NAME [list ISO_PWR_NET_NAME $iso_detail(isolation_power_net)]
    set ISO_GRND_NET_NAME [list ISO_GRND_NET_NAME $iso_detail(isolation_ground_net)]
    set ISO_IN_GEN  [list ISO_IN_GEN UPF_GENERIC_DATA]
    set ISO_OUT_GEN [list ISO_OUT_GEN UPF_GENERIC_OUTPUT]
    set ISO_FULLNAME  @$PD.isolation.$ISO_POLICY
    set ISOPOLICY1 [list ISOPOLICY1  [query_original_name $ISO_FULLNAME]]    
    set ports_list {}
    lappend ports_list $isoGround $isoSupply $ISO_IN $ISO_OUT $ISOEN
    set params_list {}
    lappend params_list $PD_NAME $ISO_PWR_NET_NAME $ISO_GRND_NET_NAME $ISOPOLICY1 $ISO_IN_GEN $ISO_OUT_GEN 
 
    bind_checker  no_iso_msg \
        -module iso_checker \
        -elements @$PD.isolation.$ISO_POLICY \
        -parameters $params_list \
        -ports $ports_list
    array unset iso_detail
  }
}
}
iso_check 
