typedef enum {RO, RW} reg_access_t;


class reg_field_cfg;

    rand int unsigned lsb;
    rand int unsigned msb;
    rand reg_access_t access;

    function new(int lsb, int msb, reg_access_t access);
        this.lsb = lsb;
        this.msb = msb;
        this.access = access;
    endfunction

endclass

class reg_cfg;

    rand int unsigned addr;
    string reg_name;
    reg_field_cfg fields[$];
    function new(int unsigned addr, string reg_name);
        this.addr = addr;
        this.reg_name = reg_name;
    endfunction

    function void add_field(reg_field_cfg field);
        fields.push_back(field);
    endfunction 
endclass

class scoreboard extends uvm_scoreboard;

    `uvm_componen_utils(scoreboard)

    reg_cfg reg_map[int unsigned];

    function new(string name = "scoreboard", uvm_component parent);
        super.new(name, parent);

    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        build_register_map();
    endfunction

    function void build_register_map();
        reg_field_cfg field1, field2;

        reg_cfg reg_rf_modem_measure;
        reg_rf_modem_measure = new(32'h4004C000, "MM_RF_MODEM_MEASURE");
        field1 = new(0, 31, RO);
        reg_rf_modem_measure.add_field(field1);
        reg_map[reg_rf_modem_measure.addr] = reg_rf_modem_measure;

        reg_cfg reg_rf_modem_tstcont;
    endfunction


endclass
