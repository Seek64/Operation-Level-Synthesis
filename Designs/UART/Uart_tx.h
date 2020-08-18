
#include "systemc.h"
#include "../Interfaces/Interfaces.h"
#include "Uart_types.h"


SC_MODULE(Uart_tx)
{
    // Data bus
    shared_in<data_t> data_in;
    master_out<bool>  data_in_notify; // Event

    // UART txd line
    blocking_out<bool>   txd; // syncs with the baud rate clock

    // Control interface
    shared_in<tx_control_t>     control_in;
    shared_in<config_t>         config_in;
    master_out<tx_events_t>     events_out; // Event

    // Message variables (not visible registers)
    data_t       data_in_msg;
    tx_control_t control_in_msg;
    config_t     config_in_msg;
    tx_events_t  events_out_msg;

    // Visible registers
    unsigned int data;
    bool         txd_bit; // Must be a visible register!

    // Try_read/try_write success signals
    bool success_txd;

    SC_CTOR(Uart_tx):
        data_in("data_in"),
        data_in_notify("data_out"),
        txd("txd"),
        control_in("control_in"),
        config_in("config_in"),
        events_out("events_out"),
        data(0),
        txd_bit(STOP_BIT),
        success_txd(false)
    {
        SC_THREAD(fsm);
    }

    void fsm()
    {

        while(true)
        {
            //txd->try_write(txd_bit, success_txd, "IDLE");
            insert_state("IDLE");
            data_in->get(data_in_msg);
            control_in->get(control_in_msg);

            //if (data_in_msg.valid && success_txd && control_in_msg.active && (control_in_msg.cts == CTS_ACTIVATED))
            if (data_in_msg.valid && control_in_msg.active && (control_in_msg.cts == CTS_ACTIVATED))
            {
                txd_bit = START_BIT;
                data = data_in_msg.data;
                data_in_notify->master_write(true);
                insert_state("DATA_NOTIFY"); // Send data read event

                std::cout << "###### TX: writing start bit" << std::endl;

                txd->write(txd_bit,"TRANSMITTING_START");
                // bounded for loops not yet supported in SystemC-PPA
                // for (unsigned int i = 0; i < 8; i++)
                // {
                //     txd_bit = get_data_bit(data, i);
                //     txd->write(txd_bit,"TRANSMITTING_DATA");
                // }
                txd_bit = get_data_bit(data, 0);
                txd->write(txd_bit,"TRANSMITTING_DATA_ZERO");
                txd_bit = get_data_bit(data, 1);
                txd->write(txd_bit,"TRANSMITTING_DATA_ONE");
                txd_bit = get_data_bit(data, 2);
                txd->write(txd_bit,"TRANSMITTING_DATA_TWO");
                txd_bit = get_data_bit(data, 3);
                txd->write(txd_bit,"TRANSMITTING_DATA_THREE");
                txd_bit = get_data_bit(data, 4);
                txd->write(txd_bit,"TRANSMITTING_DATA_FOUR");
                txd_bit = get_data_bit(data, 5);
                txd->write(txd_bit,"TRANSMITTING_DATA_FIVE");
                txd_bit = get_data_bit(data, 6);
                txd->write(txd_bit,"TRANSMITTING_DATA_SIX");
                txd_bit = get_data_bit(data, 7);
                txd->write(txd_bit,"TRANSMITTING_DATA_SEVEN");
                config_in->get(config_in_msg);
                if (config_in_msg.parity)
                {
                    txd_bit = config_in_msg.odd_parity ? !get_even_parity(data) : get_even_parity(data);
                    txd->write(txd_bit,"TRANSMITTING_PARITY");
                }
                txd_bit = STOP_BIT;
                config_in->get(config_in_msg);
                if (config_in_msg.two_stop_bits)
                {
                    txd->write(txd_bit,"TRANSMITTING_STOP_FIRST");
                }
                events_out_msg.done = true;
                events_out->master_write(events_out_msg); // Send DONE TRANSMITTING event
                events_out_msg.done = false;

                insert_state("STOP_NOTIFY");
            }
            else if (!control_in_msg.active)
            {
                // "Reset" state
                txd_bit = STOP_BIT;
                data = 0;
            }
        }
    }

private:
    bool get_even_parity(unsigned int data) const
    {
        return bits_xor(data) == 1;
    }

    bool get_data_bit(unsigned int data, unsigned int data_count) const
    {
        return  data & (1 << data_count);
    }

};
