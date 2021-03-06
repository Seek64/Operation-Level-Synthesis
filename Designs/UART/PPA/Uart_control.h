#include "systemc.h"
#include "../Interfaces/Interfaces.h"
#include "Uart_types.h"


SC_MODULE(Uart_control) {

    // System Bus Interface
    slave_in<bus_req_t>   bus_in;
    slave_out<bus_resp_t> bus_out;

    // PPI Bus Interface
    slave_in<tasks_t>    tasks_in;
    master_out<events_t> events_out;

    // Hardware flow control
    slave_in<bool>   cts_in;
    shared_out<bool> rts_out;

    // TX Interface
    shared_out<tx_control_t> tx_control_out;
    shared_out<config_t>     tx_config_out;
    slave_in<tx_events_t>    tx_events_in;

    // RX Interface
    shared_out<bool>       rx_active_out;
    shared_out<config_t>   rx_config_out;
    slave_in<rx_events_t>  rx_events_in;


    bus_req_t    bus_in_msg;
    bus_resp_t   bus_out_msg;

    tx_control_t tx_control_out_msg;
    tx_events_t  tx_events_msg;

    bool         rx_active_out_msg;
    rx_events_t  rx_events_msg;

    tasks_t      tasks_in_msg;
    events_t     events_out_msg;
    bool         cts_in_msg;
    config_t     config_msg;



    // "Valid" signals
    bool bus_in_valid;
    bool tasks_in_valid;
    bool cts_in_valid;
    bool bus_wr;
    bool bus_rd;
    bool tx_events_valid;
    bool rx_events_valid;

    // Tmp registers
    unsigned int error_src_tmp;

    // Visible registers
    unsigned int error_src;
    unsigned int enable;            // TODO: Change to boolean?
    unsigned int frame_config;
    tasks_t      tasks;
    bool         cts_internal;
    bool         rts_internal;

    SC_CTOR(Uart_control) :

            cts_in_msg(CTS_DEACTIVATED),
            cts_in_valid(false),
            bus_in_valid(false),
            tasks_in_valid(false),
            error_src(0),
            enable(0),
            frame_config(0),
            cts_internal(CTS_DEACTIVATED),
            rts_internal(RTS_ACTIVATED),
            bus_in("bus_in"),
            bus_out("bus_out"),
            tx_events_in("tx_events_in"),
            rx_events_in("rx_events_in"),
            tx_control_out("tx_control_out"),
            rx_active_out("rx_active_out"),
            tasks_in("tasks"),
            events_out("events"),
            tx_config_out("tx_config_out"),
            rx_config_out("rx_config_out"),
            bus_wr(false),
            bus_rd(false),
            cts_in("cts_in"),
            rts_out("rts_out")
            {
        SC_THREAD(fsm);
    }

    bool ENABLE_SET(unsigned int enable) const { return (enable & 1) != 0;}
    bool TASK_MASK(unsigned int task) const { return (task & 1) != 0;}
    unsigned int ERROR_MASK(unsigned int error_src) const {return (error_src & 0xF);}
    unsigned int ENABLE_MASK(unsigned int enable) const{return (enable & 1);}
    unsigned int CONFIG_MASK(unsigned int frame_config) const {return (frame_config & 0x11F);}
        // Only update PARITY if all three bits are set

    bool PARITY(unsigned int parity) const {return (parity & 0xE) != 0;}
    bool STOP(unsigned int stop_bit) const {return (stop_bit & CONFIG_STOP_MASK) != 0;}
    bool HWFC(unsigned int stop_bit) const {return (stop_bit & CONFIG_HWFC_MASK) != 0;}
    bool ODD_PARITY(unsigned int odd_parity) const {return (odd_parity & 0x100) != 0;}

    void fsm();

private:

    // bool event_triggered_cts(bool valid, bool cts, bool hwfc_enabled) const {
    //     if (valid && hwfc_enabled) return cts == CTS_ACTIVATED;
    //     return false;
    // }

    // bool event_triggered_ncts(bool valid, bool cts, bool hwfc_enabled) const {
    //     if (valid && hwfc_enabled) return cts == CTS_DEACTIVATED;
    //     return false;
    // }

    // bool update_active(bool already_active, bool start, bool stop, bool enabled) const {
    //     //if (!enabled) {
    //     //    return false;
    //     //}
    //     //else if (already_active) {
    //     //    return !(stop) || start;
    //     //} else return start;
    //     return enabled && (start || (already_active && !(stop)));
    // }

};

void Uart_control::fsm()
{
    rx_active_out_msg = false;
    tx_control_out_msg.active = false;
    tx_control_out_msg.cts    = true;
    tx_control_out->set(tx_control_out_msg);
    rx_active_out->set(rx_active_out_msg);
    while (true) {
        insert_state("IDLE");

        // Values of variables below are not important unless there is a communication.
        // Set to default value so that they are optimized away by DeSCAM
        bus_in_msg.addr         = 0;
        bus_in_msg.data         = 0;
        bus_in_msg.trans_type   = READ;
        bus_out_msg.data        = 0;
        bus_out_msg.valid       = false;
        tasks_in_msg.start_rx   = false;
        tasks_in_msg.stop_rx    = false;
        tasks_in_msg.start_tx   = false;
        tasks_in_msg.stop_tx    = false;
        cts_in_msg              = CTS_ACTIVATED;
        tx_control_out_msg.cts  = CTS_ACTIVATED;
        tx_events_msg.done      = false;
        rx_events_msg.error_src = 0;
        rx_events_msg.ready     = false;
        rx_events_msg.timeout   = false;
        events_out_msg.cts      = false;
        events_out_msg.ncts     = false;
        events_out_msg.rxd_ready = false;
        events_out_msg.txd_ready = false;
        events_out_msg.error     = false;
        events_out_msg.rx_timeout = false;


        bus_in->slave_read(bus_in_msg, bus_in_valid);
        tasks_in->slave_read(tasks_in_msg, tasks_in_valid);
        cts_in->slave_read(cts_in_msg, cts_in_valid);
        tx_events_in->slave_read(tx_events_msg, tx_events_valid);
        rx_events_in->slave_read(rx_events_msg, rx_events_valid);

        bus_rd = bus_in_valid && bus_in_msg.trans_type == READ;
        bus_wr = bus_in_valid && bus_in_msg.trans_type == WRITE;
        //bus_out_msg.valid = bus_rd || bus_wr;
        bus_out_msg.valid = bus_in_valid; // Gives better properties

        // BUS READ
        bus_out_msg.data = (bus_rd && bus_in_msg.addr == ADDR_ERROR_SRC) ? error_src    : bus_out_msg.data;
        bus_out_msg.data = (bus_rd && bus_in_msg.addr == ADDR_ENABLE)    ? enable       : bus_out_msg.data;
        bus_out_msg.data = (bus_rd && bus_in_msg.addr == ADDR_CONFIG)    ? frame_config : bus_out_msg.data;

        // BUS WRITE // TODO: Use ENABLE function instead of TASK_MASK (same functionality)
        tasks.start_rx = bus_wr && (bus_in_msg.addr == ADDR_TASKS_START_RX) && TASK_MASK(bus_in_msg.data);
        tasks.stop_rx  = bus_wr && (bus_in_msg.addr == ADDR_TASKS_STOP_RX)  && TASK_MASK(bus_in_msg.data);
        tasks.start_tx = bus_wr && (bus_in_msg.addr == ADDR_TASKS_START_TX) && TASK_MASK(bus_in_msg.data);
        tasks.stop_tx  = bus_wr && (bus_in_msg.addr == ADDR_TASKS_STOP_TX)  && TASK_MASK(bus_in_msg.data);

        // EVENTS
        // Events should be forwarded without delay. Use old ENABLE value.
        events_out_msg.txd_ready   = ENABLE_SET(enable) && tx_events_valid && tx_events_msg.done;
        events_out_msg.rxd_ready   = ENABLE_SET(enable) && rx_events_valid && rx_events_msg.ready;
        events_out_msg.rx_timeout  = ENABLE_SET(enable) && rx_events_valid && rx_events_msg.timeout;
        events_out_msg.error       = ENABLE_SET(enable) && rx_events_valid && (rx_events_msg.error_src != 0);

        events_out_msg.cts  = ENABLE_SET(enable) && HWFC(frame_config) && cts_in_valid && (cts_in_msg == CTS_ACTIVATED);
        events_out_msg.ncts = ENABLE_SET(enable) && HWFC(frame_config) && cts_in_valid && (cts_in_msg == CTS_DEACTIVATED);

        if (ENABLE_SET(enable) && ((cts_in_valid && HWFC(frame_config)) || rx_events_valid || tx_events_valid))
        {
            events_out->master_write(events_out_msg);
        }
        cts_internal   = cts_in_valid ? cts_in_msg : cts_internal;
        //cts_internal = ((cts_in_valid && cts_in_msg == CTS_ACTIVATED) || !HWFC(frame_config))  ? CTS_ACTIVATED   : cts_internal;
        //cts_internal = (cts_in_valid  && cts_in_msg == CTS_DEACTIVATED && HWFC(frame_config))  ? CTS_DEACTIVATED : cts_internal;
        //cts_internal = (events_out_msg.cts || !HWFC(frame_config))  ? CTS_ACTIVATED   : cts_internal;
        //cts_internal = (events_out_msg.ncts && HWFC(frame_config))  ? CTS_DEACTIVATED : cts_internal;

        // TASKS
        tasks.start_rx = tasks.start_rx || (tasks_in_valid && tasks_in_msg.start_rx);
        tasks.stop_rx  = tasks.stop_rx  || (tasks_in_valid && tasks_in_msg.stop_rx);
        tasks.start_tx = tasks.start_tx || (tasks_in_valid && tasks_in_msg.start_tx);
        tasks.stop_tx  = tasks.stop_tx  || (tasks_in_valid && tasks_in_msg.stop_tx);

        tx_control_out_msg.active = ENABLE_SET(enable) && (tasks.start_tx || (tx_control_out_msg.active && !(tasks.stop_tx)));
        rx_active_out_msg         = ENABLE_SET(enable) && (tasks.start_rx || (rx_active_out_msg         && !(tasks.stop_rx)));

        // Update ERROR_SRC register in case of errors. New errors have priority over clearance
        error_src_tmp  = (bus_wr && (bus_in_msg.addr == ADDR_ERROR_SRC)) ? ERROR_MASK(~bus_in_msg.data & error_src) : error_src;
        error_src      = (ENABLE_SET(enable) && rx_events_valid)             ? (error_src_tmp | rx_events_msg.error_src): error_src_tmp;
        enable         = (bus_wr && (bus_in_msg.addr == ADDR_ENABLE))    ? ENABLE_MASK(bus_in_msg.data)             : enable;
        frame_config   = (bus_wr && (bus_in_msg.addr == ADDR_CONFIG))    ? CONFIG_MASK(bus_in_msg.data)             :frame_config;

        //tx_active_out_msg = ENABLE(enable) && (cts_internal == CTS_ACTIVATED) && (tasks.start_tx || (tx_active_out_msg && !(tasks.stop_tx)));


        // Combinational
//        tx_control_out_msg.cts    = cts_internal && HWFC(frame_config);

//        rts_internal = (!ENABLE_SET(enable) || (HWFC(frame_config) && !rx_active_out_msg)) ? RTS_DEACTIVATED : RTS_ACTIVATED;
        config_msg.parity        = PARITY(frame_config);
        config_msg.two_stop_bits = STOP(frame_config);
        config_msg.odd_parity    = ODD_PARITY(frame_config);
        //tx_control_out_msg.cts   = HWFC(frame_config); // TOBIAS try with STOP()

/*
#ifdef SIM
        //if (tasks.start_rx) debug_print(CONTROL, "Tasks_start_rx");
        //if (tasks.stop_rx) debug_print(CONTROL, "Tasks_stop_rx");
        //if (rx_active_out_msg) debug_print(CONTROL, "RX_ACTIVE_OUT_MSG high");
        if ((tx_control_out_msg.active != tx_active_prev) && tx_control_out_msg.active) debug_print(CONTROL, "TX status change! TX now ON");
        if ((tx_control_out_msg.active != tx_active_prev) && !tx_control_out_msg.active) debug_print(CONTROL, "TX status change! TX now OFF");
        if ((rx_active_out_msg != rx_active_prev) && rx_active_out_msg) debug_print(CONTROL, "RX status change! RX now ON");
        if ((rx_active_out_msg != rx_active_prev) && !rx_active_out_msg) debug_print(CONTROL, "RX status change! RX now OFF");
        tx_active_prev = tx_control_out_msg.active;
        rx_active_prev = rx_active_out_msg;
#endif
*/

/*
#ifdef SIM
        if (bus_wr && (bus_in_msg.addr == ADDR_ENABLE)) debug_print(CONTROL, "Write to ENABLE register");
        if (bus_wr) std::cout << "Enable register is " << enable << std::endl;
        if (bus_wr && (bus_in_msg.addr == ADDR_CONFIG)) debug_print(CONTROL, "Write to CONFIG register");
        if (bus_wr) std::cout << "Stop bit register is " << STOP(frame_config) << std::endl;
        if (bus_rd && (bus_in_msg.addr == ADDR_ENABLE)) debug_print(CONTROL, "Read from ENABLE register");
        if (bus_rd) std::cout << "Enable register is " << enable << ", data_out is " << bus_out_msg.data << std::endl;
#endif
*/

        bus_out->slave_write(bus_out_msg);
        rts_out->set(rts_internal);
        tx_control_out->set(tx_control_out_msg);
        tx_config_out->set(config_msg);
        rx_active_out->set(rx_active_out_msg);
        rx_config_out->set(config_msg);



    }
}
