
#include "systemc.h"
#include "Uart.h"
#include "../Interfaces/Interfaces.h"
#include "Stimuli.h"
#include "Uart_types.h"

int sc_main(int, char **)
{
    Shared<data_t>          uart_data_in("uart_data_in");
    MasterSlave<bool>       uart_data_in_notify("uart_data_in_notify");
    Blocking<bool>          uart_txd("uart_txd");
    Shared<data_t>          uart_data_out("uart_data_out");
    Shared<bool>            uart_data_out_sync("uart_data_out_sync");
    Blocking<bool>          uart_rxd("uart_rxd");
    MasterSlave<bus_req_t>  uart_bus_in("uart_in");
    MasterSlave<bus_resp_t> uart_bus_out("uart_out");
    MasterSlave<tasks_t>    uart_tasks("uart_tasks");
    MasterSlave<events_t>   uart_events("uart_events");
    MasterSlave<bool>       uart_cts_in("uart_cts_in");
    Shared<bool>            uart_rts_out("uart_rts_out");

    Uart    uart("Uart");
    Stimuli stimuli("stimuli");

    uart.bus_in(uart_bus_in);
    uart.bus_out(uart_bus_out);
    uart.tasks_in(uart_tasks);
    uart.events_out(uart_events);
    uart.tx_data_in(uart_data_in);
    uart.tx_data_in_notify(uart_data_in_notify);
    uart.rxd(uart_rxd);
    uart.rx_data_out(uart_data_out);
    uart.rx_data_out_sync(uart_data_out_sync);
    uart.txd(uart_txd);
    uart.cts_in(uart_cts_in);
    uart.rts_out(uart_rts_out);
    stimuli.bus_out(uart_bus_in);
    stimuli.bus_in(uart_bus_out);
    stimuli.tasks_out(uart_tasks);
    stimuli.events_in(uart_events);
    stimuli.tx_data_out(uart_data_in);
    stimuli.tx_data_out_sync(uart_data_in_notify);
    stimuli.txd(uart_txd);
    stimuli.rx_data_in(uart_data_out);
    stimuli.rx_data_in_notify(uart_data_out_sync);
    stimuli.rxd(uart_rxd);
    stimuli.cts_out(uart_cts_in);
    stimuli.rts_in(uart_rts_out);

    sc_start();

    return 0;
}
