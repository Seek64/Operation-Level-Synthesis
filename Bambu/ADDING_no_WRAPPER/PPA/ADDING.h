



//
// Created by Abdelsalam on 15.10.20.
//

#include "../../Interfaces/Interfaces.h"

#include "systemc.h"




struct ADDING : public sc_module {

    //In-port
    blocking_in<int> x;
   // blocking_in<int> y;

    //Out-por
    blocking_out<int> z;





    int xx;
    //int yy;
    int zz;

    //Constructor
    SC_HAS_PROCESS(ADDING);

    ADDING(sc_module_name name) :
            x("x"),
            //y("y"),
            z("z"),
	   xx (0)
    {
        SC_THREAD(fsm);
    }

    void fsm() {
        while (true) {

            x->read(xx,"x");
            //y->read(yy,"y");
            zz=xx+xx;
            z->write(zz,"z");

        }
    }
};


//PROJECT_BUS_H

