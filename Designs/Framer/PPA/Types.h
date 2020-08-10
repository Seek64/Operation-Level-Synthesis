//
// Created by deutschmann on 05.08.20.
//

#ifndef FRAMER_TYPES_H
#define FRAMER_TYPES_H

struct marker_t {
    bool isMarker;
    int markerAlignment;
};

enum Phases {
    INITIALISE, SEARCH, FIND_SYNC, SYNC, MISS
};

#endif //FRAMER_TYPES_H
