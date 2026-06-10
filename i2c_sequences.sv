
//FILENAME: i2c_master_agent

class i2c_master_agent extends uvm_agent;

    `uvm_component_utils(i2c_master_agent)

    uvm_sequencer #(i2c_seq_item) seqr;
    i2c_master_driver             driver;
    i2c_master_monitor            monitor;
    uvm_analysis_port #(i2c_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        seqr = uvm_sequencer #(i2c_seq_item)
                ::type_id::create("seqr", this);

        driver = i2c_master_driver
                ::type_id::create("driver", this);

        monitor = i2c_master_monitor
                ::type_id::create("monitor", this);

    endfunction

    function void connect_phase(uvm_phase phase);
        driver.seq_item_port.connect(
            seqr.seq_item_export);
        ap = monitor.ap;
    endfunction

endclass
