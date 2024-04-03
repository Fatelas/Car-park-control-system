----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:40:25 12/05/2021 
-- Design Name: 
-- Module Name:    principal_st_mach - Behavioral 
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


entity principal_st_mach is
	Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  button_acerta : in STD_LOGIC; 
			  button_modo_inc : in STD_LOGIC;
			  modo_inc : out STD_LOGIC;
			  inc_finish : in STD_LOGIC;
			  update_time : out STD_LOGIC
			  );
end principal_st_mach;

architecture Behavioral of principal_st_mach is

type state_type is (st0, st1, st2); 
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
	
	SYNC_PROC: process (reset,clk)
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
				modo_inc <= '0';
				update_time <= '0';
			when st1 =>
				modo_inc <= '1';
				update_time <= '0';
			when st2 =>
				modo_inc <= '0';
				update_time <= '1';
      end case; 
 end process;
 
   NEXT_STATE_DECODE: process (state, button_modo_inc, button_acerta, inc_finish)
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
		
         when st0 => if button_modo_inc = '1' and button_acerta = '0' then next_state <= st1;
							end if;
			when st1 => if inc_finish = '1' then
								if button_acerta = '1' then next_state <= st2;
								end if;
							end if;
			when st2 => next_state <= st0; 
            
      end case;      
   end process;

end Behavioral;

