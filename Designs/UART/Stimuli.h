#include "systemc.h"
#include "../Interfaces/Interfaces.h"
#include "Uart_types.h"

#define TWO_STOP_BITS    1
#define ONE_STOP_BIT     0
#define PARITY_BIT       1
#define NO_PARITY_BIT    0
#define ODD_PARITY       1
#define EVEN_PARITY      0
#define HWFC             1 // Hardware flow control
#define NO_HWFC          0 // No hardware flow control

#define SIM_WAIT_TIME std::rand()%11

enum task_channel_t {BUS, TASK};

SC_MODULE(Stimuli)
{
    master_out<bus_req_t> bus_out;
    master_in<bus_resp_t> bus_in;
    shared_out<data_t>    tx_data_out;
    slave_in<bool>        tx_data_out_sync;
    blocking_in<bool>     txd;
    shared_in<data_t>     rx_data_in;
    shared_out<bool>      rx_data_in_notify;
    blocking_out<bool>    rxd;

    master_out<tasks_t>   tasks_out;
    slave_in<events_t>    events_in;
    master_out<bool>      cts_out;
    shared_in<bool>       rts_in;

    bus_req_t  bus_stimuli;
    tasks_t    task_stimuli;
    events_t   events_monitor;

    bool txd_bit;
    bool rts_monitor;
    bool prev_rts_monitor;

    bool parity;
    bool two_stop_bits;
    bool hwfc;
    bool odd_parity;

    bool tx_transmitting;
    bool rx_data_ready;
    bool rx_timeout;
    bool rx_transmitting;

    sc_event event_error;
    sc_event rts_activated;
    sc_event rts_deactivated;
    sc_event event_data_out_sync;

    bool insert_parity_error;
    bool insert_overrun_error;
    bool insert_break_error;
    bool insert_framing_error;
    unsigned int rx_transmit_data;
    unsigned int tx_transmit_data;
    unsigned int tx_transmitted_data;
    unsigned int tx_num_bits_received;
    unsigned int rx_num_bits_transmitted;

    void stimuli_generation();

    SC_CTOR(Stimuli):
        tx_transmitting(false),
        rts_monitor(RTS_DEACTIVATED),
        rx_data_ready(false),
        rx_timeout(false),
        rx_transmitting(false),
        insert_parity_error(false),
        insert_break_error(false),
        insert_framing_error(false),
        insert_overrun_error(false),
        tx_num_bits_received(0),
        tx_transmit_data(0),
        tx_transmitted_data(0),
        rx_transmit_data(0),
        rx_num_bits_transmitted(0),
        bus_out("stimuli_bus_out"),
        bus_in("stimuli_bus_in"),
        tasks_out("stimuli_tasks_out"),
        events_in("stimuli_events_in"),
        tx_data_out("stimuli_data_out"),
        tx_data_out_sync("stimuli_data_out_sync"),
        txd("stimuli_txd"),
        rx_data_in("stimuli_data_in"),
        rx_data_in_notify("data_in_notify"),
        rxd("stimuli_rxd")
    {
        SC_THREAD(stimuli_generation);
        SC_THREAD(tx_read);
        SC_THREAD(rx_write);
        SC_THREAD(uart_events);
        SC_THREAD(tx_write_sync);
    }

    // Test cases
    void test_tx();
    void test_rx();
    void test_rx_error();
    void test_hwfc();
    void test_disabled();

    std::string get_reg_name(unsigned int addr);

    // Monitor for UART events
    void uart_events()
    {
        while(1)
        {
            bool success;
            events_in->slave_read(events_monitor,success);
            if (success)
            {
                if (events_monitor.txd_ready)
                {
                    tx_transmitting = false;
                }
                if (events_monitor.rxd_ready)
                {
                    rx_data_ready = true;
                }
                if (events_monitor.rx_timeout)
                {
                    rx_timeout = true;
                    std::cout << "EVENT_MONITOR: RX timeout" << std::endl;
                }
                if (events_monitor.error)
                {
                    std::cout << "EVENT_MONITOR: error event" << std::endl;
                    event_error.notify();
                }
            }
            prev_rts_monitor = rts_monitor;
            rts_in->get(rts_monitor);
            if (rts_monitor != prev_rts_monitor)
            {
                std::cout << "EVENT_MONITOR: rts ";
                if (rts_monitor == RTS_DEACTIVATED)
                {
                    rts_deactivated.notify();
                    std::cout << "DEACTIVATED" << std::endl;
                }
                else
                {
                    rts_activated.notify();
                    std::cout << "ACTIVATED" << std::endl;
                }
            }
            wait(SC_ZERO_TIME);
        }
    }

    // Thread for monitoring txd
    void tx_read()
    {
        while(1)
        {
            bool tx_bit;
            txd->read(tx_bit);
            if (!tx_transmitting)
            {
                check_print_error((tx_bit == STOP_BIT), "TX did not send stop bit when not transmitting.");
                tx_num_bits_received = 0;
            }
            else
            {
                if (!tx_num_bits_received)
                {
                    check_print_error((tx_bit == START_BIT), "Incorrect TX start bit.");
                    tx_num_bits_received++;
                    tx_transmitted_data = 0;
                }
                else if (tx_num_bits_received <= UART_DATA_LENGTH)
                {
                    if (tx_bit)
                    {
                        tx_transmitted_data |= (1 << (tx_num_bits_received-1));
                    }
                    tx_num_bits_received++;
                }
                else
                {
                    // done receiving data bits
                    if (tx_num_bits_received == UART_DATA_LENGTH + 1)
                    {
                        tx_num_bits_received++;
                        if (parity)
                        {
                            check_print_error((tx_bit == (odd_parity ? !bits_xor(tx_transmitted_data) : bits_xor(tx_transmitted_data))), "Incorrect TX parity.");
                        }
                        else
                        {
                            check_print_error((tx_bit == STOP_BIT), "Incorrect TX stop bit.");
                            if (!two_stop_bits)
                            {
                                tx_num_bits_received = 0;
                            }
                        }
                    }
                    else if (tx_num_bits_received == UART_DATA_LENGTH + 2)
                    {
                        check_print_error((tx_bit == STOP_BIT), "Incorrect TX stop bit.");
                        if (parity ^ two_stop_bits)
                        {
                            tx_num_bits_received = 0;
                        }
                        else if (parity && two_stop_bits)
                        {
                            tx_num_bits_received++;
                        }
                    }
                    else
                    {
                        check_print_error((tx_bit == STOP_BIT), "Incorrect TX stop bit.");
                        tx_num_bits_received = 0;
                    }
                }
            }
        }
    }

    // Thread for data_in synchronization
    void tx_write_sync()
    {
        bool data_out_sync_msg, data_out_sync_msg_valid;
        while(true)
        {
            tx_data_out_sync->slave_read(data_out_sync_msg, data_out_sync_msg_valid);
            if (data_out_sync_msg_valid)
            {
                event_data_out_sync.notify();
            }
            wait(SC_ZERO_TIME);
        }
    }

    // Thread for generating rxd stimuli
    void rx_write()
    {
        while(1)
        {
            if (rx_transmitting)
            {
                if (!rx_num_bits_transmitted)
                {
                    // We have not yet started the transmission
                    rxd->write(START_BIT);
                    rx_num_bits_transmitted++;
                }
                else if (rx_num_bits_transmitted <= UART_DATA_LENGTH)
                {
                    bool next_bit;
                    next_bit = rx_transmit_data & (1 << (rx_num_bits_transmitted-1));
                    rxd->write(next_bit);
                    rx_num_bits_transmitted++;
                }
                else if (rx_num_bits_transmitted == UART_DATA_LENGTH + 1)
                {
                    if (parity)
                    {
                        bool next_bit;
                        next_bit = insert_parity_error ? !bits_xor(rx_transmit_data) : bits_xor(rx_transmit_data);
                        next_bit = (odd_parity ? !next_bit : next_bit);
                        rxd->write(next_bit);
                        rx_num_bits_transmitted++;
                        if (insert_parity_error) std::cout << "Inserted parity error" << std::endl;
                    }
                    else
                    {
                        if (insert_framing_error) rxd->write(START_BIT);
                        else rxd->write(STOP_BIT);
                        if (two_stop_bits)
                        {
                            rx_num_bits_transmitted++;
                        }
                        else
                        {
                            rx_num_bits_transmitted = 0;
                            rx_transmitting = false;
                        }
                    }
                }
                else if (rx_num_bits_transmitted == UART_DATA_LENGTH + 2)
                {
                    rxd->write(STOP_BIT);
                    if (parity ^ two_stop_bits)
                    {
                        rx_num_bits_transmitted = 0;
                        rx_transmitting = false;
                    }
                    else if (parity && two_stop_bits)
                    {
                        rx_num_bits_transmitted++;
                    }
                }
                else
                {
                    rxd->write(STOP_BIT);
                    rx_num_bits_transmitted = 0;
                    rx_transmitting = false;
                }
            }
            else
            {
//                rxd->write(STOP_BIT);
                rx_num_bits_transmitted = 0;
            }
            wait(SC_ZERO_TIME);
        }
    }

private:

    void check_print_error(bool expr, const std::string& msg)
    {
        if (!expr)
        {
            std::cout << "ERROR: " << msg << std::endl;
            std::cout << "UART status:" << std::endl;
            std::cout << "    CONFIG:" << std::endl;
            std::cout << "      TWO_STOP_BITS " << (two_stop_bits ? "true" : "false") << std::endl;
            std::cout << "      PARITY "        << (parity ? "true" : "false")        << std::endl;
            std::cout << "      ODD PARITY "    << (odd_parity ? "true" : "false")    << std::endl;
            std::cout << "      HWFC "          << (hwfc ? "true" : "false")          << std::endl;
            std::cout << "    RX ";
            if (!rx_transmitting) std::cout << "not transmitting. Last transmitted ";
            std::cout << "data: " << rx_transmit_data << std::endl;
            std::cout << "    TX ";
            if (!tx_transmitting) std::cout << "not transmitting. Last transmitted ";
            std::cout << "data: " << tx_transmit_data << std::endl;

            sc_stop();
        }
    }

    void enable_uart()
    {
        bus_stimuli.addr = ADDR_ENABLE;
        bus_stimuli.data = UART_ENABLE;
        bus_stimuli.trans_type = WRITE;
        bus_out->master_write(bus_stimuli);
//        std::cout << "Write " << bus_stimuli.data << " into register " << get_reg_name(bus_stimuli.addr) << std::endl;
        assert(check_register(ADDR_ENABLE, UART_ENABLE));
    }

    void disable_uart()
    {
        bus_stimuli.addr = ADDR_ENABLE;
        bus_stimuli.data = UART_DISABLE;
        bus_stimuli.trans_type = WRITE;
        bus_out->master_write(bus_stimuli);
        assert(check_register(ADDR_ENABLE, UART_DISABLE));
    }

    void start_tx(task_channel_t ch)
    {
        if (ch == BUS)
        {
            bus_stimuli.addr = ADDR_TASKS_START_TX;
            bus_stimuli.data = UART_ENABLE;
            bus_stimuli.trans_type = WRITE;
//            std::cout << "Write " << bus_stimuli.data << " into register " << get_reg_name(bus_stimuli.addr) << std::endl;
            bus_out->master_write(bus_stimuli);
        }
        else if (ch == TASK)
        {
            tasks_t tasks { start_rx: NO_EVENT,
                            stop_rx : NO_EVENT,
                            start_tx: EVENT,
                            stop_tx : NO_EVENT};
            tasks_out->master_write(tasks);
        }
    }
    void start_rx(task_channel_t ch)
    {
        if (ch == BUS)
        {
            bus_stimuli.addr = ADDR_TASKS_START_RX;
            bus_stimuli.data = UART_ENABLE;
            bus_stimuli.trans_type = WRITE;
            bus_out->master_write(bus_stimuli);
        }
        else if (ch == TASK)
        {
            tasks_t tasks { start_rx: EVENT,
                            stop_rx : NO_EVENT,
                            start_tx: NO_EVENT,
                            stop_tx : NO_EVENT};
            tasks_out->master_write(tasks);
        }


    }
    void stop_tx(task_channel_t ch)
    {
        if (ch == BUS)
        {
            bus_stimuli.addr = ADDR_TASKS_STOP_TX;
            bus_stimuli.data = UART_ENABLE;
            bus_stimuli.trans_type = WRITE;
            bus_out->master_write(bus_stimuli);
        }
        else if (ch == TASK)
        {
            tasks_t tasks { start_rx: NO_EVENT,
                            stop_rx : NO_EVENT,
                            start_tx: NO_EVENT,
                            stop_tx : EVENT};
            tasks_out->master_write(tasks);
        }

    }
    void stop_rx(task_channel_t ch)
    {
        if (ch == BUS)
        {
            bus_stimuli.addr = ADDR_TASKS_STOP_RX;
            bus_stimuli.data = UART_ENABLE;
            bus_stimuli.trans_type = WRITE;
            bus_out->master_write(bus_stimuli);
        }
        else if (ch == TASK)
        {
            tasks_t tasks { start_rx: NO_EVENT,
                            stop_rx : EVENT,
                            start_tx: NO_EVENT,
                            stop_tx : NO_EVENT};
            tasks_out->master_write(tasks);
        }
    }

    bool tx_stimuli(unsigned int number)
    {

      data_t data_out_msg;
      data_out_msg.valid = true;
      data_out_msg.data = number;
      tx_data_out->set(data_out_msg);

      wait(event_data_out_sync);

      tx_transmitting = true;
      data_out_msg.valid = false;
      tx_data_out->set(data_out_msg);

/*
        data_t data_out_msg;
        data_out_msg.data = number;
        data_out_msg.valid = true;
        tx_data_out->set(data_out_msg);
        data_out_msg.valid = false;
        sc_time start_time(sc_time_stamp());
        sc_time tx_timeout_delay(1, SC_NS);
        wait(sc_time(1, SC_PS));
        wait(sc_time(1, SC_NS), event_data_out_sync);
        if (sc_time_stamp() - start_time == tx_timeout_delay)
        {
            std::cout << "Stimuli func::tx_stimuli timed out after 1 ns." << std::endl;
            return false;
        }
        else
        {
            tx_data_out->set(data_out_msg);
            tx_transmit_data = number;
            tx_transmitting = true;
            return true;
        }
*/
    }

    void tx_no_stimuli()
    {
        data_t data_out_msg;
        data_out_msg.valid = false;
        tx_data_out->set(data_out_msg);
    }


    void rx_stimuli(int data)
    {
        rx_transmit_data = data;
        rx_transmitting = true;
    }

    bool read_rx(unsigned int data)
    {
        data_t rx_data_in_msg;
        rx_data_ready = false;
        unsigned int result;
        rx_data_in->get(rx_data_in_msg);
        while (!rx_data_in_msg.valid)
        {
            wait(SC_ZERO_TIME);
            rx_data_in->get(rx_data_in_msg);
        }
        rx_data_in_notify->set(true);
        while (rx_data_in_msg.valid)
        {
            wait(SC_ZERO_TIME);
            rx_data_in->get(rx_data_in_msg);
        }
        rx_data_in_notify->set(false);
        return (rx_data_in_msg.data & DATA_MASK) == data;
    }

    void configure_uart(int two_stop_bits, int parity, int hwfc, int odd_parity)
    {
        bus_req_t trans;
        trans.addr = ADDR_CONFIG;
        trans.data = 0;
        if (two_stop_bits)
        {
            trans.data |= CONFIG_STOP_MASK;
        }
        if (parity)
        {
            trans.data |= CONFIG_PARITY_MASK;
        }
        if (hwfc)
        {
            trans.data |= CONFIG_HWFC_MASK;
        }
        if (odd_parity)
        {
            trans.data |= CONFIG_ODD_PARITY_MASK;
        }
        trans.trans_type = WRITE;
//        std::cout << "Write " << trans.data << " into register " << get_reg_name(trans.addr) << std::endl;
        bus_out->master_write(trans);
        this->two_stop_bits = two_stop_bits;
        this->parity        = parity;
        this->hwfc          = hwfc;
        this->odd_parity    = odd_parity;
    }

    void write_register(unsigned int addr, int value)
    {
        bus_req_t trans;
        trans.addr = addr;
        trans.data = value;
        trans.trans_type = WRITE;
        bus_out->master_write(trans);
    }

    bool check_register(int addr, int value)
    {
        bus_req_t trans;
        bus_resp_t response;
        trans.addr = addr;
        trans.trans_type = READ;
        bus_out->master_write(trans);
        bus_in->master_read(response);
        while (!response.valid)
        {
            bus_in->master_read(response);
        }

//        std::cout << "Stimuli check_register: Response: " << response.data << std::endl;
//        std::cout << "Read from register " << get_reg_name(addr) << " returned " << response.data << std::endl;
        return response.data == value;
    }

    void suspend_uart()
    {
        stop_rx(BUS);
        stop_tx(BUS);
    }

};

void Stimuli::stimuli_generation()
{
    test_tx();

    test_rx();

    sc_stop();

}

void Stimuli::test_tx()
{

    std::cout << "\n-------- Testing UART TX ---------" << std::endl;

    // Reset TX Stimuli
    tx_no_stimuli();

    // Enable UART
    if (!check_register(ADDR_ENABLE, UART_ENABLE))
    {
        enable_uart();
    }

    // Test all possible configurations
    std::cout << "Starting TX via System Bus\n";
    start_tx(BUS);
    for (int i = 0; i < 6; i++)
    {
        bool two_stop_bits = i & 0b1;
        bool parity_bit    = (i >= 2);
        bool odd_parity    = (i >= 4);
        configure_uart(two_stop_bits, parity_bit, NO_HWFC, odd_parity);
        std::cout << "--- Testing TX Config: ";
        std::cout << "Stop bits: " << two_stop_bits+1;
        std::cout << ", Parity: " << (parity?(odd_parity?"Odd":("Even")):"None");
        std::cout << " --- ";

        for (int j = 0; j < 256; j++)
        {
            tx_stimuli(j);
        }

        std::cout << "Pass\n";
    }
    std::cout << "Stopping TX via System Bus\n";
    stop_tx(BUS);

    // Test TX Transmissions while starting and stopping it with Tasks
    std::cout << "Starting TX with a Task\n";
    start_tx(TASK);
    std::cout << "--- Testing TX --- ";
    for (int i = 0; i < 256; i++)
    {
        tx_stimuli(i);
        if ((i % 11) == 0)
        {
            stop_tx(TASK);
            while(tx_transmitting) wait(SC_ZERO_TIME);
            start_tx(TASK);
        }
    }
    std::cout << "Pass\n";
    std::cout << "Stopping TX with a Task\n";
    stop_tx(TASK);

    std::cout << "-------- Finished Testing UART TX ---------\n\n";

}

void Stimuli::test_rx()
{
    std::cout << "-------- Testing UART RX ---------\n";

    // Enable UART
    if (!check_register(ADDR_ENABLE, UART_ENABLE))
    {
        enable_uart();
    }

    // Test all possible configurations
    std::cout << "Starting RX via System Bus\n";
    start_rx(BUS);
    for (int i = 0; i < 6; i++)
    {
        bool two_stop_bits = i & 0b1;
        bool parity_bit    = (i >= 2);
        bool odd_parity    = (i >= 4);
        configure_uart(two_stop_bits, parity_bit, NO_HWFC, odd_parity);

        std::cout << "--- Testing RX Config: ";
        std::cout << "Stop bits: " << two_stop_bits+1;
        std::cout << ", Parity: " << (parity?(odd_parity?"Odd":("Even")):"None");
        std::cout << " --- ";

        for (int j = 0; j < 256; j++)
        {
            rx_stimuli(j);
            while (!rx_data_ready) wait(SC_ZERO_TIME);
            check_print_error(read_rx(j), "RX read wrong data.");
        }
        std::cout << "Pass\n";
    }
    stop_rx(BUS);

    // Wait for Timeout
    while (!rx_timeout) wait(SC_ZERO_TIME);
    rx_timeout = false;

    std::cout << "-------- Finished Testing UART RX ---------\n\n";
}

void Stimuli::test_rx_error()
{
    sc_time start_time;
    sc_time error_delay;
    std::cout << "\n-------- Testing RX Error Generation --------" << std::endl;
    if (!check_register(ADDR_ENABLE, UART_ENABLE)) enable_uart();

    // Insert parity error in RX
    start_rx(BUS);
    configure_uart(ONE_STOP_BIT, PARITY_BIT, NO_HWFC, EVEN_PARITY);
    std::cout << "INSERTING PARITY ERROR" << std::endl;
    insert_parity_error = true;
    rx_stimuli(0x33);
    start_time = sc_time_stamp();
    error_delay = sc_time(1, SC_NS);
    wait(error_delay, event_error);
    assert(sc_time_stamp() - start_time < error_delay);
    assert(check_register(ADDR_ERROR_SRC, ERROR_PARITY_MASK));

    write_register(ADDR_ERROR_SRC, ERROR_PARITY_MASK);
    assert(check_register(ADDR_ERROR_SRC, 0));

    while (!rx_data_ready) wait(SIM_WAIT_TIME, SC_PS);
    assert(read_rx(0x33));

    rx_stimuli(0x34);
    start_time = sc_time_stamp();
    error_delay = sc_time(1, SC_NS);
    wait(error_delay, event_error);
    assert(sc_time_stamp() - start_time < error_delay);
    assert(check_register(ADDR_ERROR_SRC, ERROR_PARITY_MASK));
    write_register(ADDR_ERROR_SRC, ERROR_PARITY_MASK);
    assert(check_register(ADDR_ERROR_SRC, 0));

    while (!rx_data_ready) wait(SIM_WAIT_TIME, SC_PS);
    assert(read_rx(0x34));

    configure_uart(TWO_STOP_BITS, NO_PARITY_BIT, HWFC, EVEN_PARITY);

    insert_parity_error = false;
    rx_stimuli(0xFF);
    while (!rx_data_ready) wait(SIM_WAIT_TIME, SC_PS);
    assert(read_rx(0xFF));


    std::cout << "INSERTING FRAMING ERROR" << std::endl;
    insert_framing_error = true;
    rx_stimuli(0x33);
    start_time = sc_time_stamp();
    error_delay = sc_time(1, SC_NS);
    wait(error_delay, event_error);
    assert(sc_time_stamp() - start_time < error_delay);
    check_print_error(check_register(ADDR_ERROR_SRC, ERROR_FRAMING_MASK), "ERROR_SRC not correct");
    write_register(ADDR_ERROR_SRC, ERROR_FRAMING_MASK);
    assert(check_register(ADDR_ERROR_SRC, 0));
    while (!rx_data_ready) wait(SIM_WAIT_TIME, SC_PS);
    assert(read_rx(0x33));
    insert_framing_error = false;

    stop_rx(BUS);
}

void Stimuli::test_disabled()
{
    std::cout << "\n-------- Testing UART while disabled ---------" << std::endl;
    std::cout << "Stimuli: disabling UART" << std::endl;
    disable_uart();

    std::cout << "Stimuli: starting TX with BUS while disabled" << std::endl;
    start_tx(BUS);
    //tx_stimuli();
    std::cout << "Stimuli: enabling UART" << std::endl;
    enable_uart();
}

void Stimuli::test_hwfc()
{

    std::cout << "\n-------- Testing Hardware Flow Control --------" << std::endl;
    if (!check_register(ADDR_ENABLE, UART_ENABLE)) enable_uart();
    std::cout << "Starting TX with Hardware Flow Control enabled" << std::endl;
    configure_uart(TWO_STOP_BITS, NO_PARITY_BIT, HWFC, EVEN_PARITY);
    cts_out->master_write(CTS_ACTIVATED);
    tx_stimuli(0xCD);
    wait(SIM_WAIT_TIME, SC_PS);
    std::cout << "Stopping TX with CTS" << std::endl;
    cts_out->master_write(CTS_DEACTIVATED);
    while (tx_transmitting) wait(1, SC_PS);
    std::cout << "Give stimuli when stopped" << std::endl;
    assert(!tx_stimuli(90));
    std::cout << "Resume TX with CTS" << std::endl;
    cts_out->master_write(CTS_ACTIVATED);
    tx_stimuli(100);
    while (tx_transmitting) wait(1, SC_PS);
    std::cout << "Suspend UART" << std::endl;
    disable_uart();
}

std::string Stimuli::get_reg_name(unsigned int addr){
  switch (addr) {
    case ADDR_TASKS_START_RX: return "TASK_START_RX"; break;
    case ADDR_TASKS_STOP_RX:  return "TASK_STOP_RX";  break;
    case ADDR_TASKS_START_TX: return "TASK_START_TX"; break;
    case ADDR_TASKS_STOP_TX:  return "TASK_STOP_TX";  break;
    case ADDR_ENABLE:         return "ENABLE";        break;
    case ADDR_CONFIG:         return "CONFIG";        break;
    default:                  return "UNKNOWN";       break;
  }
}
