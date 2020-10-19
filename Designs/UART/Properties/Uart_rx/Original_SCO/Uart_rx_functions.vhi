-- FUNCTIONS --
macro parity_not_correct(data: unsigned;odd_parity: boolean;parity_bit: boolean) : boolean :=
	(((odd_parity /= (((((((((data and resize(1,32)) xor ((shift_right(data,resize(1,32))) and resize(1,32))) xor ((shift_right(data,resize(2,32))) and resize(1,32))) xor ((shift_right(data,resize(3,32))) and resize(1,32))) xor ((shift_right(data,resize(4,32))) and resize(1,32))) xor ((shift_right(data,resize(5,32))) and resize(1,32))) xor ((shift_right(data,resize(6,32))) and resize(1,32))) xor ((shift_right(data,resize(7,32))) and resize(1,32))) = resize(1,32))) /= parity_bit));
end macro;

macro update_data(data: unsigned;data_count: unsigned;rx_bit: boolean) : unsigned :=
	if (rx_bit) then unsigned((data or (shift_left(resize(1,32),data_count))))
	else unsigned((data and not((shift_left(resize(1,32),data_count)))))
end if;
end macro;

