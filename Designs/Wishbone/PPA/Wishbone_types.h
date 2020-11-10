//
// Created by ludwig on 18.01.17.
//

#ifndef PROJECT_COMPOUND_BUS_H
#define PROJECT_COMPOUND_BUS_H

enum trans_t {
    SINGLE_READ, SINGLE_WRITE
};

enum ack_t  {
    OK, RTY, ERR
};

struct bus_req_t{
    int addr;
    trans_t trans_type;
    int data;
};

struct bus_resp_t{
    int data;
    ack_t ack;
};

struct master_signals{
    int addr;
    int data;
    bool we;
    bool stb;
    bool cyc;
};

struct slave_signals{
    int data;
    bool ack;
    bool err;
};

#endif //PROJECT_COMPOUND_H
