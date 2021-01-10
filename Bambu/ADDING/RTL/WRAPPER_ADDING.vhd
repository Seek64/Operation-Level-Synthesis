library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.ADDING_operations;
use work.x_notify;
use work.z_notify;
use work.z_sig;

use work.ADDING_types.all;

entity LUCAS is
port(
	x_sig 	: in signed (31 downto 0);
	z_sig_w	: out signed (31 downto 0);
	x_notify_w: out std_logic_vector (0 downto 0);		-- x_notify_wrapper
	z_notify_w: out std_logic_vector (0 downto 0);
	x_sync: in std_logic;
	z_sync: in std_logic;
	clk	: in std_logic;
	rst	: in std_logic;
	start_port_in : in std_logic;
	done_port_out : out std_logic
);
end LUCAS;

architecture LUCAS_arch of LUCAS is
	
	signal active_operation_in_x_notify: unsigned(31 downto 0);
	signal active_operation_in_z_notify: unsigned(31 downto 0);
	signal active_operation_in_z_sig: unsigned(31 downto 0);
	signal return_port_out_x_notify: std_logic_vector(0 downto 0) :="1";
	signal return_port_out_z_notify: std_logic_vector(0 downto 0) :="0";
	signal return_port_out_z_sig: signed(31 downto 0);
	signal x_sig_in: signed (31 downto 0);
	signal oney: std_logic_vector(0 downto 0) :="1";

--	irrelevant signals
	signal X_NOTIFY0_in: std_logic_vector(0 downto 0);
	signal Z_NOTIFY0_in: std_logic_vector(0 downto 0);
	signal Z_SIG0_in: signed(31 downto 0);


	-- Monitor Signals
	signal next_state: ADDING_state_t;
	signal active_operation: ADDING_operation_t;
	signal active_state: ADDING_state_t;

	-- Register signals
	signal x_notify_reg_out1 : std_logic_vector(0 downto 0) := (others => '0');
	signal z_notify_reg_out1 : std_logic_vector(0 downto 0) := (others => '0');
	signal z_sig_reg_out1 	 : signed(31 downto 0) := (others => '0');


	component x_notify is
	port(
		-- IN
		clock : in std_logic;
		reset : in std_logic;
		start_port : in std_logic;
		active_operation : in unsigned (31 downto 0);
		-- OUT
		done_port : out std_logic;
		return_port : out std_logic_vector(0 downto 0)
	);
	end component;

	component z_notify is
	port(
		-- IN
		clock : in std_logic;
		reset : in std_logic;
		start_port : in std_logic;
		active_operation : in unsigned (31 downto 0);
		-- OUT
		done_port : out std_logic;
		return_port : out std_logic_vector(0 downto 0)
	);
	end component;

	component z_sig is
	port(
		-- IN
		clock : in std_logic;
		reset : in std_logic;
		start_port : in std_logic;
		x_sig : in signed (31 downto 0);
		active_operation : in unsigned (31 downto 0);
		-- OUT
		done_port : out std_logic;
		return_port : out signed (31 downto 0)
	);
	end component;


begin

	x_notify_inst: x_notify	-- component port => signals
	port map(
		clock => clk,
		reset => rst,
		start_port => start_port_in,
		active_operation => active_operation_in_x_notify,
		done_port => done_port_out,
		return_port => return_port_out_x_notify
	);

	z_notify_inst: z_notify	-- component port => signals
	port map(
		clock => clk,
		reset => rst,
		start_port => start_port_in,
		active_operation => active_operation_in_z_notify,
		done_port => done_port_out,
		return_port => return_port_out_z_notify
	);

	z_sig_inst: z_sig	-- component port => signals
	port map(
		clock => clk,
		reset => rst,
		start_port => start_port_in,
		x_sig => x_sig_in,
		active_operation => active_operation_in_z_sig,
		done_port => done_port_out,
		return_port => return_port_out_z_sig
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


    process(clk, rst)	-- x_notify register
    begin
      if (rst = '0') then
        x_notify_reg_out1 <= "1";
      else
        if (clk'event and clk = '1') then
          if (active_operation /= op_state_wait) then
            x_notify_reg_out1 <= return_port_out_x_notify;
          end if;
        end if;
      end if;
    end process;

    process(clk, rst)	-- z_notify register
    begin
      if (rst = '0') then
        z_notify_reg_out1 <= "0";
      else
	if(clk'event and clk = '1') then
	  if(active_operation /= op_state_wait) then
            z_notify_reg_out1 <= return_port_out_z_notify;	
          end if;
        end if;
      end if;
    end process;

    process(clk, rst)	-- z_sig register
    begin
      if (rst = '0') then
        z_sig_reg_out1 <= "00000000000000000000000000000000";
      else
        if(clk'event and clk = '1') then
          if(active_operation /= op_state_wait) then
            z_sig_reg_out1 <= return_port_out_z_sig;	
          end if;
        end if;
     end if;
    end process;

----------------------------------------------------------------------------------------------------------------------------------------------------------------

	-- Control process
	process (clk, rst)
	begin
		if (rst = '0') then		-- an active low reset not active high
			active_state <= st_x_1;
		elsif (clk = '1' and clk'event) then
			active_state <= next_state;
		end if;
	end process;

	-- Notify Signals
	x_notify_w <= x_notify_reg_out1;	
	z_notify_w <= z_notify_reg_out1;
	z_sig_w <= z_sig_reg_out1;	

	-- Operation Module Inputs
	active_operation_in_x_notify <= active_operation;
	active_operation_in_z_notify <= active_operation;
	active_operation_in_z_sig <= active_operation;

	x_sig_in <= x_sig;

end LUCAS_arch;
