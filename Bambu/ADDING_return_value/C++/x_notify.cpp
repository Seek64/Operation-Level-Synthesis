#include "ap_int.h"
#include "ADDING_data_types.h"

bool x_notify(
//	int x_sig,
//	int z_sig,
	bool x_notify,
	bool z_notify,
	operation active_operation
)
{
//	static int z_sig_reg = 0;
//	static bool x_notify_reg = true;		// could remove these
//	static bool z_notify_reg = false;


//	z_sig = z_sig_reg;
//	x_notify = x_notify_reg;
//	z_notify = z_notify_reg;
	x_notify = true;
	z_notify =false;

	switch (active_operation) {
	case x_1_1:
//		z_sig_reg = (2 * x_sig);
		x_notify = false;
//		z_notify_reg = true;
		break;
	case z_2_2:
		x_notify = true;
//		z_notify_reg = false;
		break;
	case state_wait:
		break;

	}
return x_notify;
}
