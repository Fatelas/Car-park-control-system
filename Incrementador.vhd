----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:16:25 12/05/2021 
-- Design Name: 
-- Module Name:    Incrementador - Behavioral 
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

entity Incrementador is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  clear_inc : in STD_LOGIC;
           inc : in  STD_LOGIC; --butão de pressão de incrementar
			  min_inc : in STD_LOGIC; --sinal para incrementar minutos
			  hora_inc : in STD_LOGIC; --sinal para incrementar horas
           new_min_u : out  integer range 0 to 9;
           new_min_d : out  integer range 0 to 5;
           new_hora_u : out  integer range 0 to 9;
           new_hora_d : out  integer range 0 to 2
			  );
end Incrementador;

architecture Behavioral of Incrementador is

signal cont_min_u, cont_hora_u : integer range 0 to 9; 
signal cont_min_d : integer range 0 to 5; 
signal cont_hora_d : integer range 0 to 2;
signal cont_clock : integer range 0 to 49999999;

begin

process(clk,reset,clear_inc)
begin

	if reset = '1' or clear_inc = '1' then cont_clock <= 0;
		elsif clk'event and clk = '1' then
			
				if cont_clock = 49999999 then 
					cont_clock <= 0;
				else cont_clock <= cont_clock + 1;
	
			end if;
		end if;

end process;

--incrementa minutos

process (clk, reset, inc, clear_inc, min_inc, cont_min_d, cont_min_u)
	begin
	 if reset = '1' or clear_inc = '1' then
		cont_min_u <= 0;
		cont_min_d <= 0;
	 elsif clk'event and clk = '1' then
		 if min_inc = '1' and inc = '1' and (cont_clock = 12499999 or cont_clock = 24999999 or cont_clock = 37499999 or cont_clock = 49999998) then 
				if cont_min_d = 5 and cont_min_u = 9 then
					cont_min_d <= 0;
					cont_min_u <= 0;
				elsif cont_min_u = 9 then
					cont_min_u <= 0;
					cont_min_d <= cont_min_d + 1;
				else
					cont_min_u <= cont_min_u + 1;
				end if;
		end if;
	 end if;
end process;

new_min_u <= cont_min_u;
new_min_d <= cont_min_d;

--incrementa horas

process (clk, reset, inc, clear_inc, hora_inc, cont_hora_d, cont_hora_u)
	begin
	 if reset = '1' or clear_inc = '1' then
		cont_hora_u <= 0;
		cont_hora_d <= 0;
	 elsif clk'event and clk = '1' then
		 if hora_inc = '1' and inc = '1' and (cont_clock = 12499999 or cont_clock = 24999999 or cont_clock = 37499999 or cont_clock = 49999998) then
				if cont_hora_d = 2 and cont_hora_u = 3 then
					cont_hora_u <= 0;
					cont_hora_d <= 0;
				elsif cont_hora_u = 9 then
					cont_hora_u <= 0;
					cont_hora_d <= cont_hora_d + 1;
				else
					cont_hora_u <= cont_hora_u + 1;
				end if;
		end if;
	 end if;
end process;

new_hora_u <= cont_hora_u;
new_hora_d <= cont_hora_d;

end Behavioral;

