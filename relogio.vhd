----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:55:15 11/24/2021 
-- Design Name: 
-- Module Name:    relogio - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity relogio is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           c_min_u : out integer range 0 to 9;
           c_min_d : out integer range 0 to 5; 
           c_hour_u : out integer range 0 to 9;
           c_hour_d : out integer range 0 to 2;
           new_min_u : in integer range 0 to 9;
           new_min_d : in integer range 0 to 5; 
           new_hour_u : in integer range 0 to 9;
           new_hour_d : in integer range 0 to 2;
			  update_time : in STD_LOGIC;
			  aberto_in : out STD_LOGIC;
			  aberto_out : out STD_LOGIC
			  );
end relogio;

architecture Behavioral of relogio is

signal cont_subseg : integer range 0 to 50000000; 
signal cont_seg_u, cont_min_u, cont_hour_u : integer range 0 to 9;
signal cont_seg_d, cont_min_d : integer range 0 to 5;
signal cont_hour_d : integer range 0 to 2; 
signal seg_u, seg_d, min_u, min_d, hour_u, hour_d : std_logic;

begin


process (clk, reset)
begin
	if reset = '1' then
		aberto_in <= '0';
		aberto_out <= '0';
	elsif clk'event and clk = '1' then
			if (cont_hour_d = 0 and cont_hour_u >=8) or (cont_hour_d = 1 and cont_hour_u < 9) then
				aberto_in <= '1';
				aberto_out <= '1';
			elsif (cont_hour_d = 2 and cont_hour_u =0 and cont_min_d = 0 and cont_min_u = 0) or (cont_hour_d = 1 and cont_hour_u = 9) then
				aberto_in <= '0';
				aberto_out <= '1';
			elsif (cont_hour_d = 2 and cont_hour_u >= 0) or (cont_hour_d >= 0 and cont_hour_u < 8) then
				aberto_in <= '0';
				aberto_out <= '0';
			end if;
	end if;
end process;
		
		

--clk
process (clk, reset) 

begin 
	if reset = '1' then 
		cont_subseg <= 0; 
	elsif clk'event and clk = '1' then 
		if cont_subseg = 49999999 then 
			cont_subseg <= 0; 
		else cont_subseg <= cont_subseg + 1; 
		end if; 
	end if; 
end process;

seg_u <= '1' when cont_subseg = 49999999 else '0'; 


--segu
process (clk, reset, update_time) 
begin 
	if reset = '1' then 
		cont_seg_u <= 0; 
	elsif clk'event and clk = '1' then 
		if update_time = '1' then
			cont_seg_u <= 0;
		elsif seg_u = '1' then 
			if cont_seg_u = 9 then 
				cont_seg_u <= 0; 
			else cont_seg_u <= cont_seg_u + 1; 
			end if; 
		end if; 
	end if; 
end process;

seg_d <= '1' when cont_seg_u = 9 and seg_u = '1' else '0'; 

--segd
process (clk, reset, update_time) 
begin 
	if reset = '1' then 
		cont_seg_d <= 0; 
	elsif clk'event and clk = '1' then
		if update_time = '1' then
			cont_seg_d <= 0;
		elsif seg_d = '1' then 
			if cont_seg_d = 5 then 
				cont_seg_d <= 0; 
			else cont_seg_d <= cont_seg_d + 1; 
			end if; 
		end if; 
	end if; 
end process;

min_u <= '1' when cont_seg_d = 5 and seg_d = '1' else '0'; 

--minu
process (clk, reset, update_time, new_min_u) 
begin 
	if reset = '1' then 
		cont_min_u <= 0; 
	elsif clk'event and clk = '1' then 
		if update_time = '1' then
			cont_min_u <= new_min_u;
		elsif min_u = '1' then 
			if cont_min_u = 9 then 
				cont_min_u <= 0; 
			else cont_min_u <= cont_min_u + 1; 
			end if; 
		end if; 
	end if; 
end process;

min_d <= '1' when cont_min_u = 9 and min_u = '1' else '0'; 
c_min_u <= cont_min_u;

--mind
process (clk, reset, update_time, new_min_d) 
begin 
	if reset = '1' then 
		cont_min_d <= 0;
	elsif clk'event and clk = '1' then 
		if update_time = '1' then
			cont_min_d <= new_min_d;
		elsif min_d = '1' then 
			if cont_min_d = 5 then 
				cont_min_d <= 0; 
			else cont_min_d <= cont_min_d + 1; 
			end if; 
		end if; 
	end if; 
end process;

hour_u <= '1' when cont_min_d = 9 and min_d = '1' else '0'; 
c_min_d <= cont_min_d;


--houru
process (clk, reset, update_time)
begin
	if reset = '1' then
		cont_hour_u <= 0;
	elsif clk'event and clk = '1' then
		if update_time = '1' then
			cont_hour_u <= new_hour_u;
		elsif hour_u = '1' then
			if cont_hour_u = 9 then
				cont_hour_u <= 0;
			else cont_hour_u <= cont_hour_u + 1;
			end if;
		end if;
	end if;
end process;

hour_d <= '1' when (cont_hour_u = 9 or (cont_hour_u = 3 and cont_hour_d = 2)) and hour_u = '1' else '0';
c_hour_u <= cont_hour_u;

--hourd
process (clk, reset, update_time)
begin

	if reset = '1' then
		cont_hour_d <= 0;
	elsif clk'event and clk = '1' then
		if update_time = '1' then
			cont_hour_d <= new_hour_d;
		elsif hour_d = '1' then
			if cont_hour_d = 2 and cont_hour_u = 3 then
				cont_hour_d <= 0;
			else cont_hour_d <= cont_hour_d + 1;
			end if;
		end if;
	end if;
end process;

c_hour_d <= cont_hour_d;

			

end Behavioral;

