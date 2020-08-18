 #ifndef UART_H_
#define UART_H_

#include "systemc.h"
#include "../Interfaces/Interfaces.h"
#include "Uart_types.h"
#include "Uart_control.h"
#include "Uart_tx.h"
#include "Uart_rx.h"


SC_MODULE(Uart)
{
    slave_in<bus_req_t>        bus_in;
    slave_out<bus_resp_t>      bus_out;
    slave_in<tasks_t>          tasks_in;
    master_out<events_t>       events_out;
    slave_in<bool>             cts_in;
    shared_out<bool>           rts_out;

    // Internal channels
    MasterSlave<tx_events_t>  tx_to_ctrl_events;
    Shared<tx_control_t>      ctrl_to_tx_active;
    MasterSlave<rx_events_t>  rx_to_ctrl_events;
    Shared<bool>              ctrl_to_rx_active;
    Shared<config_t>          ctrl_to_tx_config;
    Shared<config_t>          ctrl_to_rx_config;

    shared_in<data_t>  tx_data_in;
    master_out<bool>   tx_data_in_notify;
    shared_out<data_t> rx_data_out;
    shared_in<bool>    rx_data_out_sync;
    blocking_out<bool> txd;
    blocking_in<bool>  rxd;


    Uart_control uart_control;
    Uart_tx uart_tx;
    Uart_rx uart_rx;

    SC_CTOR(Uart):
    tx_to_ctrl_events("tx_to_ctrl_events"),
    ctrl_to_tx_active("ctrl_to_tx_active"),
    rx_to_ctrl_events("rx_to_ctrl_events"),
    ctrl_to_rx_active("ctrl_to_rx_active"),
    ctrl_to_tx_config("ctrl_to_tx_config"),
    ctrl_to_rx_config("ctrl_to_rx_config"),
    uart_control("uart_control"),
    uart_tx("uart_tx"),
    uart_rx("uart_rx")
    {
        uart_control.bus_in(bus_in);
        uart_control.bus_out(bus_out);
        uart_control.tasks_in(tasks_in);
        uart_control.events_out(events_out);
        uart_control.tx_control_out(ctrl_to_tx_active);
        uart_control.tx_events_in(tx_to_ctrl_events);
        uart_control.rx_active_out(ctrl_to_rx_active);
        uart_control.rx_events_in(rx_to_ctrl_events);
        uart_control.tx_config_out(ctrl_to_tx_config);
        uart_control.rx_config_out(ctrl_to_rx_config);
        uart_control.cts_in(cts_in);
        uart_control.rts_out(rts_out);

        uart_tx.data_in(tx_data_in);
        uart_tx.data_in_notify(tx_data_in_notify);
        uart_tx.txd(txd);
        uart_tx.control_in(ctrl_to_tx_active);
        uart_tx.events_out(tx_to_ctrl_events);
        uart_tx.config_in(ctrl_to_tx_config);

        uart_rx.data_out(rx_data_out);
        uart_rx.data_out_sync(rx_data_out_sync);
        uart_rx.rxd(rxd);
        uart_rx.control_active_in(ctrl_to_rx_active);
        uart_rx.events_out(rx_to_ctrl_events);
        uart_rx.config_in(ctrl_to_rx_config);

    }

};

#endif
