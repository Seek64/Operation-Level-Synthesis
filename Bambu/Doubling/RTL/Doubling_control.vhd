library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Doubling_operations;
use work.Doubling_types.all;

entity Doubling is
port(
   clk_i : in std_logic;
   rst_i : in std_logic;

   x_i        : in  std_logic_vector (31 downto 0);
   x_notify_o : out std_logic_vector (0 downto 0);
   x_sync_i   : in  std_logic;

   z_o        : out std_logic_vector (31 downto 0);   
   z_notify_o : out std_logic_vector (0 downto 0);
   z_sync_i   : in  std_logic
);
end Doubling;

architecture Doubling_arch of Doubling is

   signal operation_r :Doubling_operation_t;
   signal state_r : Doubling_state_t;
   signal start_r : std_logic;
   signal done_s  : std_logic;
   signal wait_r  : std_logic;

   signal x_r : std_logic_vector (31 downto 0);

   signal z_sig_s : std_logic_vector (31 downto 0);
   signal z_sig_vld_s : std_logic;
  
   signal z_notify_s : std_logic_vector (0 downto 0);  
   signal z_notify_r : std_logic_vector (0 downto 0);
   signal z_notify_vld_s : std_logic;

   signal x_notify_s : std_logic_vector (0 downto 0); 
   signal x_notify_r : std_logic_vector (0 downto 0); 
   signal x_notify_vld_s : std_logic;
  


   component Doubling_operations is
   port(

      clock            : in std_logic;
      reset            : in std_logic;
      start_port       : in std_logic;
      active_operation : in unsigned (31 downto 0);
      x_sig            : in std_logic_vector (31 downto 0);

      done_port        : out std_logic;
      z_sig            : out std_logic_vector(31 downto 0);
      z_sig_vld        : out std_logic;
      x_notify         : out std_logic_vector(0 downto 0);
      x_notify_vld     : out std_logic;
      z_notify         : out std_logic_vector(0 downto 0);
      z_notify_vld     : out std_logic

   );
   end component;

begin

   Doubling_operations_inst: Doubling_operations
   port map(

      clock            => clk_i,
      reset            => rst_i,
      start_port       => start_r,
      active_operation => operation_r,
      x_sig            => x_r,

      done_port    => done_s,
      z_sig        => z_sig_s,
      z_sig_vld    => z_sig_vld_s,
      x_notify     => x_notify_s,
      x_notify_vld => x_notify_vld_s,
      z_notify     => z_notify_s,
      z_notify_vld => z_notify_vld_s

   );

   -- Control process
   process (clk_i, rst_i)
   begin
      if (rst_i = '0') then -- Active Low
         operation_r <= op_state_wait;
         state_r     <= st_x_1;
         start_r     <= '0';
         wait_r      <= '1';
      elsif (clk_i = '1' and clk_i'event) then
         -- New Operation
         if (wait_r = '1') then
            case state_r is
            when st_x_1 =>
               if (x_sync_i = '1') then
                  operation_r <= op_x_1_1;
                  state_r <= st_z_2;
                  start_r <= '1';
                  wait_r <= '0';
               else
                  operation_r <= op_state_wait;
                  state_r <= state_r;
                  start_r <= '0';
                  wait_r <= '1';
               end if;
            when st_z_2 =>
               if (z_sync_i = '1') then 
                  operation_r <= op_z_2_2;
                  state_r <= st_x_1;
                  start_r <= '1';
                  wait_r <= '0';
               else
                  operation_r <= op_state_wait;
                  state_r <= state_r;
                  start_r <= '0';
                  wait_r <= '1';
               end if;
            end case;
         -- Operation Finished
         elsif (done_s = '1') then
            operation_r <= operation_r;
            state_r <= state_r;
            start_r <= '0';
            wait_r <= '1';
         -- Operation Running
         else
            operation_r <= operation_r;
            state_r <= state_r;
            start_r <= '0';
            wait_r <= '0';
         end if;
      end if;
   end process;

   -- Input Register
   process (clk_i, rst_i)
   begin
      if (rst_i = '0') then
         x_r <= (others => '0');
      elsif (clk_i = '1' and clk_i'event) then
         if (x_sync_i = '1') then
            x_r <= x_i;   
         end if;
      end if;
   end process;

   -- Output Registers
   process (clk_i, rst_i)
   begin
      if (rst_i = '0') then
         z_o <= (others => '0');
      elsif (clk_i = '1' and clk_i'event) then
         if (z_sig_vld_s = '1') then
            z_o <= z_sig_s;   
         end if;
      end if;
   end process;

   -- Notify Registers 
   process (clk_i, rst_i)
   begin
      if (rst_i = '0') then
         x_notify_r <= "1";
      elsif (clk_i = '1' and clk_i'event) then
         if (x_notify_vld_s = '1') then
            x_notify_r <= x_notify_s;   
         end if;
      end if;
   end process;

   process (clk_i, rst_i)
   begin
      if (rst_i = '0') then
         z_notify_r <= "0";
      elsif (clk_i = '1' and clk_i'event) then
         if (z_notify_vld_s = '1') then
            z_notify_r <= z_notify_s;   
         end if;
      end if;
   end process;

   -- Notify Output Logic
   x_notify_o <= x_notify_r when (wait_r = '1') else "0";
   z_notify_o <= z_notify_r when (wait_r = '1') else "0";

end Doubling_arch;
