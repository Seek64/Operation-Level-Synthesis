library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ADDING_operations;
--use work.x_notify;
--use work.z_notify;
--use work.z_sig;

use work.ADDING_types.all;

entity LUCAS is
port(
	x_sig 	: in std_logic_vector (31 downto 0);
	z_sig_w	: out std_logic_vector (31 downto 0);
	x_notify_w: out std_logic_vector (0 downto 0);		-- x_notify_wrapper
	z_notify_w: out std_logic_vector (0 downto 0);
	--x_notify_vld: out std_logic;
	--z_notify_vld: out std_logic;
	x_sync: in std_logic;
	z_sync: in std_logic;
	clk	: in std_logic;
	rst	: in std_logic
	--start_port_in : in std_logic;
	--done_port_out : out std_logic
);
end LUCAS;

architecture LUCAS_arch of LUCAS is
	
	signal active_operation_in_x_notify: unsigned(31 downto 0);
	signal active_operation_in_z_notify: unsigned(31 downto 0);
	signal active_operation_in_z_sig: unsigned(31 downto 0);
	signal return_port_out_x_notify: std_logic_vector(0 downto 0) ;
	signal return_port_x_notify_vld : std_logic;
	signal return_port_z_notify_vld : std_logic;

	signal return_port_out_z_notify: std_logic_vector(0 downto 0) ;
	signal return_port_out_z_sig: std_logic_vector(31 downto 0);
	signal x_sig_in: std_logic_vector (31 downto 0);
	signal oney: std_logic_vector(0 downto 0);

--	irrelevant signals
	signal X_NOTIFY0_in: std_logic_vector(0 downto 0);
	signal Z_NOTIFY0_in: std_logic_vector(0 downto 0);
	signal Z_SIG0_in: signed(31 downto 0);


	-- Monitor Signals
	signal next_state: ADDING_state_t;
	signal active_operation: ADDING_operation_t;
	signal active_state: ADDING_state_t;

	-- Register signals
	signal x_notify_reg_out1 : std_logic_vector(0 downto 0) ;
	signal z_notify_reg_out1 : std_logic_vector(0 downto 0) ;
	signal z_sig_reg_out1 	 : std_logic_vector(31 downto 0);

        signal start_port_sig : std_logic;
        signal start_port_reg : std_logic;
        signal done_port_sig : std_logic;

	signal x_notify_w_reg: std_logic_vector (0 downto 0);	
	signal z_notify_w_reg: std_logic_vector (0 downto 0);

	signal z_sig_vld_out : std_logic;


	component ADDING_operations is
	port(
		-- IN
		clock : in std_logic;
		reset : in std_logic;
		start_port : in std_logic;
		active_operation : in unsigned (31 downto 0);
		-- OUT
		done_port : out std_logic;
		x_notify_vld : out std_logic;
		z_notify_vld : out std_logic;
		x_sig : in std_logic_vector (31 downto 0);

		x_notify : out std_logic_vector(0 downto 0);
		z_notify : out std_logic_vector(0 downto 0);
		z_sig : out std_logic_vector(31 downto 0);
		z_sig_vld : out std_logic

	);
	end component;

begin

	ADDING_operations_inst: ADDING_operations	-- component port => signals
	port map(
		clock => clk,
		reset => rst,
		start_port => start_port_sig,
		active_operation => active_operation_in_x_notify,
		done_port => done_port_sig,
		x_notify => return_port_out_x_notify,
		x_notify_vld => return_port_x_notify_vld,
		z_notify_vld => return_port_z_notify_vld,
		z_notify => return_port_out_z_notify,
		z_sig => return_port_out_z_sig,
		x_sig => x_sig_in,
		z_sig_vld => z_sig_vld_out


	);
	-- Monitor
	process (active_state, x_sync, z_sync)
	begin
		case active_state is
		when st_x_1 =>
			if (x_sync) = '1' then 
				active_operation <= op_x_1_1;
				next_state <= st_z_2;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		when st_z_2 =>
			if (z_sync) = '1' then 
				active_operation <= op_z_2_2;
				next_state <= st_x_1;
			else
				active_operation <= op_state_wait;
				next_state <= active_state;
			end if;
		end case;
	end process;


   

----------------------------------------------------------------------------------------------------------------------------------------------------------------

	-- Control process
	process (clk, rst)
	begin
		if (rst = '0') then		-- an active low reset not active high
			active_state <= st_x_1;
			--return_port_out_x_notify <= "1";
			--return_port_out_z_notify <= "0";
			--return_port_out_z_sig <= "00000000000000000000000000000000";
			start_port_sig <= '1';
		elsif (clk = '1' and clk'event) then
			active_state <= next_state;
			if (done_port_sig = '1') then
				start_port_sig <= '1';
			else
				start_port_sig <= '0';
			end if;
		end if;
	end process;

	--process (rst, start_port_sig)
	--begin
--		if (rst = '0') then
--			start_port_sig <= "1";
--		elsif (start_port_sig = '1') then
--			start_port_sig <= start_port_reg;
--		else 
--			start_port_sig <= "0";
--		end if;
--	end process;


        process (clk, rst)
        begin
		if (rst = '0') then
			x_notify_w_reg <= "1";
		else
		  if (return_port_x_notify_vld = '1') then
			x_notify_w_reg <= return_port_out_x_notify;	
		  end if;
		end if;
	end process;

	process (rst, start_port_sig)
	begin
		if (rst = '0') then
			x_notify_w <= "1";
		elsif (start_port_sig = '1') then
			x_notify_w <= x_notify_w_reg;
		else 
			x_notify_w <= "0";
		end if;
	end process;

        process (clk, rst)
        begin
		if (rst = '0') then
			z_notify_w_reg <= "0";
		else
		  if (return_port_z_notify_vld = '1') then
			z_notify_w_reg <= return_port_out_z_notify;	
		  end if;
		end if;
	end process;

	process (rst, start_port_sig)
	begin
		if (rst = '0') then
			z_notify_w <= "0";
		elsif (start_port_sig = '1') then
			z_notify_w <= z_notify_w_reg;
		else 
			z_notify_w <= "0";
		end if;
	end process;

        process (clk, rst)
        begin
		if (rst = '0') then
			z_sig_w <= (others => '0');
		else
		  if (z_sig_vld_out = '1') then
			z_sig_w <= return_port_out_z_sig;	
		  end if;
		end if;
	end process;


	--start_port_sig <= '1';

	-- Notify Signals
--	x_notify_w <= return_port_out_x_notify;	
--	x_notify_w <= x_notify_reg_out1;

--	z_notify_w <= return_port_out_z_notify;
--	z_notify_w <= z_notify_reg_out1;

--	z_sig_w <= return_port_out_z_sig;
--	z_sig_w <= z_sig_reg_out1;

	--x_notify_vld <= return_port_x_notify_vld;	
	--z_notify_vld <= return_port_z_notify_vld;	


	

	-- Operation Module Inputs
	active_operation_in_x_notify <= active_operation;
	active_operation_in_z_notify <= active_operation;
	active_operation_in_z_sig <= active_operation;

	x_sig_in <= x_sig;

end LUCAS_arch;
