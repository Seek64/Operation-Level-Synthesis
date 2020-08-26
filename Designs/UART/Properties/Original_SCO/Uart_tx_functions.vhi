-- FUNCTIONS --
macro get_data_bit(data: unsigned;data_count: unsigned) : boolean :=
	(((data and (shift_left(resize(1,32),data_count))) /= resize(0,32)));
end macro;

macro get_even_parity(data: unsigned) : boolean :=
	((((((((((data and resize(1,32)) xor ((shift_right(data,resize(1,32))) and resize(1,32))) xor ((shift_right(data,resize(2,32))) and resize(1,32))) xor ((shift_right(data,resize(3,32))) and resize(1,32))) xor ((shift_right(data,resize(4,32))) and resize(1,32))) xor ((shift_right(data,resize(5,32))) and resize(1,32))) xor ((shift_right(data,resize(6,32))) and resize(1,32))) xor ((shift_right(data,resize(7,32))) and resize(1,32))) = resize(1,32)));
end macro;

