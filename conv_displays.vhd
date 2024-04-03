----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:02:58 11/24/2021 
-- Design Name: 
-- Module Name:    conv_displays - Behavioral 
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

entity conv_displays is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  modo_inc : in STD_LOGIC;
           min_u : in  integer range 0 to 9;
           min_d : in  integer range 0 to 5;
           hour_u : in  integer range 0 to 9;
           hour_d : in  integer range 0 to 2;
           i_min_u : in  integer range 0 to 9;
           i_min_d : in  integer range 0 to 5;
           i_hour_u : in  integer range 0 to 9;
           i_hour_d : in  integer range 0 to 2;
           an3 : out  STD_LOGIC;
           an2 : out  STD_LOGIC;
           an1 : out  STD_LOGIC;
           an0 : out  STD_LOGIC;
			  lug_in_1 : in STD_LOGIC;
			  modo_relogio : in STD_LOGIC;
			  c_in_1_u : in integer range 0 to 9;
			  c_in_1_d : in integer range 0 to 9;
			  c_in_2_u : in integer range 0 to 9;
			  c_in_2_d : in integer range 0 to 9;
			  c_out_1_u : in integer range 0 to 9;
			  c_out_1_d : in integer range 0 to 9;
			  c_out_2_u : in integer range 0 to 9;
			  c_out_2_d : in integer range 0 to 9;
			  c_lot_1_u : in integer range 0 to 9;
			  c_lot_1_d : in integer range 0 to 9;
			  c_lot_2_u : in integer range 0 to 9;
			  c_lot_2_d : in integer range 0 to 9;
			  sw0 : in STD_LOGIC;
			  sw1 : in STD_LOGIC;
			  sw2 : in STD_LOGIC;
			  sw3 : in STD_LOGIC;
           algarismo : out  STD_LOGIC_VECTOR (7 downto 0));
end conv_displays;

architecture Behavioral of conv_displays is

signal alg : integer range 0 to 9; 
signal cont_clock : integer range 0 to 499999; 
signal num_alg : std_logic_vector(1 downto 0);

begin


co: process (clk, reset) 
begin 
	if reset = '1' then 
		cont_clock <= 0; 
	elsif clk'event and clk = '1' then 
		if cont_clock = 499999 then 
			cont_clock <= 0; 
			num_alg <= "00"; 
		else 
			if cont_clock = 124999 then 
				num_alg <= "01"; 
			elsif cont_clock = 249999 then 
				num_alg <= "10"; 
			elsif cont_clock = 374999 then 
				num_alg <= "11"; 
			end if; 
			cont_clock <= cont_clock + 1; 
		end if; 
	end if; 
end process;

an : process(clk, reset) 
begin 
	if reset = '1' then 
		an3 <= '0'; 
		an2 <= '0'; 
		an1 <= '0'; 
		an0 <= '0'; 
		alg <= 0; 
		algarismo(7) <= '1';
	elsif clk'event and clk = '1' then 
		if num_alg = "00" then 
			an3 <= '1'; 
			an2 <= '1'; 
			an1 <= '1'; 
			an0 <= '0'; 
			
			if modo_relogio = '1' then
				if modo_inc = '0' then
					alg <= min_u;
					if sw0 = '1' then
						alg <= c_in_1_u;
					elsif sw1 = '1' then
						alg <= c_out_1_u;
					elsif sw2 = '1' then
						alg <= c_in_2_u;
					elsif sw3 = '1' then
						alg <= c_out_2_u;
					end if;
				else
					alg <= i_min_u;
				end if;
			else
				if lug_in_1 = '1' then
					alg <= c_lot_1_u;
				else
					alg <= c_lot_2_u;
				end if;
			end if;
			
			algarismo(7) <= '1'; 
		elsif num_alg = "01" then 
			an3 <= '1'; 
			an2 <= '1'; 
			an1 <= '0'; 
			an0 <= '1';
			
			if modo_relogio = '1' then
				if modo_inc = '0' then
					alg <= min_d;
					if sw0 = '1' then
						alg <= c_in_1_d;
					elsif sw1 = '1' then
						alg <= c_out_1_d;
					elsif sw2 = '1' then
						alg <= c_in_2_d;
					elsif sw3 = '1' then
						alg <= c_out_2_d;
					end if;
				else
					alg <= i_min_d;
				end if; 
			else
				if lug_in_1 = '1' then
					alg <= c_lot_1_d;
				else
					alg <= c_lot_2_d;
				end if;
			end if;
			
			algarismo(7) <= '1'; 
		elsif num_alg = "10" then
			an3 <= '1'; 
			an2 <= '0'; 
			an1 <= '1'; 
			an0 <= '1'; 
			
			if modo_relogio = '1' then
				if modo_inc = '0' then
					alg <= hour_u;
					if sw0 = '1' or sw1 = '1' or sw2 = '1' or sw3 = '1' then
						alg <= 0;
					end if;
				else
					alg <= i_hour_u;
				end if;
			else
				alg <= 0;
			end if;
			algarismo(7) <= '0'; 
		elsif num_alg = "11" then 
			an3 <= '0';
			an2 <= '1'; 
			an1 <= '1'; 
			an0 <= '1';
			
			if modo_relogio = '1' then
				if modo_inc = '0' then
					alg <= hour_d;
					if sw0 = '1' or sw1 = '1' or sw2 = '1' or sw3 = '1' then
						alg <= 0;
					end if;
				else
					alg <= i_hour_d;
				end if;
			else
				if lug_in_1 = '1' then
					alg <= 4;
				else
					alg <= 6;
				end if;
			end if;
			algarismo(7) <= '1';
		end if; 
	end if; 
end process;

al : process(clk, reset) 
begin 
	if reset = '1' then 
		algarismo(6 downto 0) <= "0000001"; 
	elsif clk'event and clk = '1' then 
		case alg is 
			when 0 => algarismo(6 downto 0) <= "0000001"; 
			when 1 => algarismo(6 downto 0) <= "1001111"; 
			when 2 => algarismo(6 downto 0) <= "0010010"; 
			when 3 => algarismo(6 downto 0) <= "0000110"; 
			when 4 => algarismo(6 downto 0) <= "1001100"; 
			when 5 => algarismo(6 downto 0) <= "0100100"; 
			when 6 => algarismo(6 downto 0) <= "0100000";
			when 7 => algarismo(6 downto 0) <= "0001111"; 
			when 8 => algarismo(6 downto 0) <= "0000000"; 
			when 9 => algarismo(6 downto 0) <= "0000100"; 
--			when 10 => algarismo(6 downto 0) <= "0111000"; --F
--			when 11 => algarismo(6 downto 0) <= "1000010"; --U
--			when 12 => algarismo(6 downto 0) <= "1110001"; --L
			when others => algarismo(6 downto 0) <= "0111000";
		end case; 
	end if; 
end process; 


end Behavioral;

