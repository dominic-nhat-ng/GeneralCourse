class axi_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(axi_scoreboard)
    uvm_analysis_imp #(transaction, axi_scoreboard) monitor_port;
    uvm_blocking_put_imp #(transaction, axi_scoreboard) driver_port;

    transaction monitor_item[$];
    transaction driver_item[$];

    function new(string name="axi_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitor_port = new("monitor_port", this);
        driver_port = new("driver_port", this);
    endfunction

    function void write(transaction item);
        `uvm_info("MONITOR - SCOREBOARD", "Received item from monitor", UVM_MEDIUM)
        monitor_item.push_back(item);
    endfunction

    function void put(transaction item);
        `uvm_info("DRIVER - SCROEBOARD", "Received item from driver", UVM_LOW)
        driver_item.push_back(item);
    endfunction
    extern function bit compare(transaction mon_item, transaction drv_item);
    virtual task run_phase(uvm_phase phase);
        transaction mon_item, drv_item;
        //super.run_phase(phase);
        forever begin
            mon_item = transaction::type_id::create("mon_item");
            drv_item = transaction::type_id::create("drv_item");
            wait(monitor_item.size() > 0 && driver_item.size() > 0)
            mon_item = monitor_item.pop_front();
            drv_item = driver_item.pop_front();
            if (compare(mon_item, drv_item)) begin
                `uvm_info("COMPARE", "Data matched", UVM_LOW)
            end else begin
                `uvm_info("COMPARE", "Data mismatched", UVM_LOW)
            end 
        end
    endtask
endclass

function bit axi_scoreboard::compare(transaction mon_item, transaction  drv_item);
    if (mon_item.awlen != drv_item.awlen) begin
        return 0;
    end else begin
        if(mon_item.awaddr != drv_item.awaddr) begin
            return 0;
        end
        for (int i = 0; i < mon_item.awlen; i++) begin
            if(mon_item.wdata[i] != drv_item.wdata[i]) return 0;
        end
    end

    if (mon_item.arlen != drv_item.arlen) begin
        return 0;
    end else begin
        if(mon_item.araddr != drv_item.araddr) begin
        end
        for(int i = 0; i < mon_item.arlen; i++) begin
            if(mon_item.rdata[i] != drv_item.rdata[i]) return 0;
        end
    end
    return 1;

endfunction
