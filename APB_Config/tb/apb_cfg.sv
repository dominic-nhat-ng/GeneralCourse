class apb_config extends uvm_object;
    
    `ubm_object_utils(apb_config)

    virtual apb_intf    intf;
    
    typedef enum {MASTER, SLAVE} apb_mode_t;
    apb_mode_t mode;
    function new(string name = "apb_config");
        super.new(name);
        mode = MASTER;
    endfunction

endclass : apb_config

