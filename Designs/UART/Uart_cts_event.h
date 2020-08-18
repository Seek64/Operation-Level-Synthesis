#include "systemc.h"
#include "Interfaces.h"

SC_MODULE(Cts_edge_detector) {
    shared_in<bool>  cts_in;
    shared_in<bool>  enable_in;
    master_out<bool> cts_out;

    bool cts_in_msg;
    bool cts_out_msg;
    bool enable_msg;

    SC_CTOR(Cts_edge_detector):
        cts_in_msg(true),
        cts_out_msg(true),
        enable_msg(false),
        cts_in("cts_in"),
        cts_out("cts_out"),
        enable_in("enable_in")
        {
            SC_THREAD(fsm);
        }

    void fsm()
    {
        while(true)
        {
            insert_state("READ_CTS");
            cts_in->get(cts_in_msg);
            enable_in->get(enable_msg);
            if (enable_msg)
            {
                if ((cts_out_msg && !cts_in_msg) || (cts_in_msg && !cts_out_msg))
                {
                    cts_out->master_write(cts_in_msg);
                }
                cts_out_msg = cts_in_msg;
            }
        }
    }
};