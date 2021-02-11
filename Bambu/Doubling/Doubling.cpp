#include "ap_int.h"
#include "doubling_data_types.h"

void ADDING_operations(
	int   x_sig,
	int  *z_sig,
	bool *x_notify,
	bool *z_notify,
	operation active_operation
	)
	{
 *z_sig = 0;
 *x_notify = true;
 *z_notify = false;


switch (active_operation) {
		case x_1_1:
			*z_sig = (2 * x_sig);
			*x_notify = false;
			*z_notify = true;
			break;
		case z_2_2:
			*x_notify = true;
			*z_notify = false;
			break;
		case state_wait:
			break;
			}
	}