----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:13:07 12/05/2021 
-- Design Name: 
-- Module Name:    inc_st_mach - Behavioral 
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

entity inc_st_mach is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  clear_inc : out STD_LOGIC;
			  button_inc : in STD_LOGIC;
			  button_modo_inc : in STD_LOGIC;
			  button_acerta : in STD_LOGIC;
			  LED_inc_min : out STD_LOGIC;
			  LED_inc_hour : out STD_LOGIC;
           inc : out  STD_LOGIC; --butão de pressão de incrementar
			  min_inc : out STD_LOGIC; --sinal para incrementar minutos
			  hora_inc : out STD_LOGIC; --sinal para incrementar horas
			  modo_inc : in STD_LOGIC;
			  inc_finish : out STD_LOGIC);
end inc_st_mach;

architecture Behavioral of inc_st_mach is

type state_type is (st0, st1, st2, st3, st4, st5, st6); 
signal state, next_state : state_type;
signal contaclock : integer range 0 to 49999999;

begin

CC : process(clk,reset)
	begin

		if reset = '1' then contaclock <= 0;
			elsif clk'event and clk = '1' then
			
					if contaclock = 49999999 then 
						contaclock <= 0;
					else contaclock <= contaclock + 1;
	
					end if;
		end if;

	end process;

SYNC_PROC: process (clk, reset)
   begin
	
	if reset = '1' then state <= st0;
      elsif clk'event and clk = '1' then
			if (contaclock = 12499999 or contaclock = 24999999 or contaclock = 37499999 or contaclock = 49999998) then
					state <= next_state;
			end if;
       end if;              
   end process;
	
	
   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state)
   begin
      
    case (state) is
         when st0 => 
				clear_inc <= '1';
            inc <= '0';
			   min_inc <= '0';
			   hora_inc <= '0';
				inc_finish <= '0';
				LED_inc_min <= '0';
				LED_inc_hour <= '0';
			when st1 =>
            clear_inc <= '0';
            inc <= '0';
			   min_inc <= '0';
			   hora_inc <= '0';
				inc_finish <= '0';
				LED_inc_min <= '1';
				LED_inc_hour <= '0';
			when st2 =>
            clear_inc <= '0';
            inc <= '0';
			   min_inc <= '0';
			   hora_inc <= '0';
				inc_finish <= '0';
				LED_inc_min <= '0';
				LED_inc_hour <= '1';
			when st3 =>
            clear_inc <= '0';
            inc <= '1';
			   min_inc <= '1';
			   hora_inc <= '0';
				inc_finish <= '0';
				LED_inc_min <= '1';
				LED_inc_hour <= '0';
			when st4 =>
				clear_inc <= '0';
            inc <= '1';
			   min_inc <= '0';
			   hora_inc <= '1';
				inc_finish <= '0';
				LED_inc_min <= '0';
				LED_inc_hour <= '1';
			when st5 =>
            clear_inc <= '0';
            inc <= '0';
			   min_inc <= '0';
			   hora_inc <= '0';
				inc_finish <= '1';
				LED_inc_min <= '0';
				LED_inc_hour <= '0';
			when st6 =>
				clear_inc <= '0';
            inc <= '0';
			   min_inc <= '0';
			   hora_inc <= '0';
				inc_finish <= '0';
				LED_inc_min <= '0';
				LED_inc_hour <= '0';
      end case; 
 end process;
 
   NEXT_STATE_DECODE: process (state, button_modo_inc, button_inc, button_acerta, modo_inc)
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
		
         when st0 => if modo_inc = '1' then next_state <= st1;
							end if;
			when st1 => if button_modo_inc = '1' then next_state <= st2;
							elsif button_inc = '1' then next_state <= st3;
							end if;
			when st2 => if button_modo_inc = '1' then next_state <= st5;
							elsif button_inc = '1' then next_state <= st4;
							end if;
			when st3 => next_state <= st1; --incrementa minutos
			when st4 => next_state <= st2; --incrementa horas
			when st5 => if button_acerta = '1' then next_state <= st6;
							end if;
			when st6 => if button_acerta = '0' then next_state <= st0;
							end if;
            
      end case;
	end process;


end Behavioral;

