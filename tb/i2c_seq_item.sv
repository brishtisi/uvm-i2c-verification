
//FILE NAME: i2c_seq_item

class i2c_seq_item extends uvm_sequence_item;

    `uvm_object_utils(i2c_seq_item)

    // 0 = write
    // 1 = read
    rand bit       rw;

    // slave address
    rand bit [6:0] addr;

    // register address inside slave
    rand bit [7:0] reg_addr;

    // write data
    rand bit [7:0] data_in;

    // repeated start enable
    rand bit       rep_start;

    //---------------------------------------------
    // Observed results
    //---------------------------------------------

    bit [7:0] data_out;

    bit done;
    bit arb_lost;
    bit nack_error;

    //---------------------------------------------
    // Constraints
    //---------------------------------------------

    constraint valid_slave_c {
        addr inside {7'h30, 7'h31};
    }

    constraint rw_c {
        rw inside {0,1};
    }

    constraint reg_addr_c {
        reg_addr inside {[8'h00:8'hFF]};
    }

    function new(string name="i2c_seq_item");
        super.new(name);
    endfunction

    function string convert2string();

        return $sformatf(
        "RW=%0s SLAVE=0x%0h REG=0x%0h DIN=0x%0h DOUT=0x%0h REP_START=%0b
DONE=%0b ARB=%0b NACK=%0b",
        rw ? "READ" : "WRITE",
        addr,
        reg_addr,
        data_in,
        data_out,
        rep_start,
        done,
        arb_lost,
        nack_error);

    endfunction

endclass
