-- FUNCTIONS --
macro CONFIG_MASK(frame_config: unsigned) : unsigned :=
	unsigned((frame_config and resize(287,32)));
end macro;

macro ENABLE_MASK(enable: unsigned) : unsigned :=
	unsigned((enable and resize(1,32)));
end macro;

macro ENABLE_SET(enable: unsigned) : boolean :=
	(((enable and resize(1,32)) /= resize(0,32)));
end macro;

macro ERROR_MASK(error_src: unsigned) : unsigned :=
	unsigned((error_src and resize(15,32)));
end macro;

macro HWFC(stop_bit: unsigned) : boolean :=
	(((stop_bit and CONFIG_HWFC_MASK) /= resize(0,32)));
end macro;

macro ODD_PARITY(odd_parity: unsigned) : boolean :=
	(((odd_parity and resize(256,32)) /= resize(0,32)));
end macro;

macro PARITY(parity: unsigned) : boolean :=
	(((parity and resize(14,32)) /= resize(0,32)));
end macro;

macro STOP(stop_bit: unsigned) : boolean :=
	(((stop_bit and CONFIG_STOP_MASK) /= resize(0,32)));
end macro;

macro TASK_MASK(task: unsigned) : boolean :=
	(((task and resize(1,32)) /= resize(0,32)));
end macro;

