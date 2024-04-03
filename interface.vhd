----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:28:59 01/01/2022 
-- Design Name: 
-- Module Name:    interface - Behavioral 
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
Use IEEE.STD_LOGIC_ARITH.ALL;
Use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interface is
Port (
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		sw0: in STD_LOGIC;
		sw1: in STD_LOGIC;
		sw2: in STD_LOGIC;
		sw3: in STD_LOGIC;
		sw4: in STD_LOGIC;
		sw5: in STD_LOGIC;
		sw6: in STD_LOGIC;
		sw7: in STD_LOGIC;
		led_0: out STD_LOGIC; -- para cancela de entrada
		led_1: out STD_LOGIC; -- para cancela de saida
		led_2: out STD_LOGIC; -- para o primeiro piso
		led_3: out STD_LOGIC; -- para o segundo piso
		led_4: out STD_LOGIC; -- para a entrada/saida 3 quando se esta no piso 2
		led_5: out STD_LOGIC; -- para ocupacao
		led_6: out STD_LOGIC; -- para ocupacao
		led_7: out STD_LOGIC; -- para ocupacao
		PRES1_IN : OUT STD_LOGIC;
      TICKET_IN : OUT STD_LOGIC;
      PRES2_IN : OUT STD_LOGIC;
      PRESS1_OUT : OUT STD_LOGIC;
      PRESS2_OUT : OUT STD_LOGIC;
      TICKET_OUT : OUT STD_LOGIC;
      AND_21A : OUT STD_LOGIC;
      AND_21B : OUT STD_LOGIC;
      PRESS1_IN_2 : OUT STD_LOGIC;
      PRESS2_IN_2 : OUT STD_LOGIC;
      TICKET_IN_2 : OUT STD_LOGIC;
      PRESS1_OUT_2 : OUT STD_LOGIC;
      PRESS2_OUT_2 : OUT STD_LOGIC;
      TICKET_OUT_2 : OUT STD_LOGIC;
      PRESS1_IN_3 : OUT STD_LOGIC;
      PRESS2_IN_3 : OUT STD_LOGIC;
      TICKET_IN_3 : OUT STD_LOGIC;
      PRESS1_OUT_3 : OUT STD_LOGIC;
      PRESS2_OUT_3 : OUT STD_LOGIC;
      TICKET_OUT_3 : OUT STD_LOGIC;
      AND_12A : OUT STD_LOGIC;
      AND_12B : OUT STD_LOGIC;
      CANC_IN : IN STD_LOGIC;
      CANC_OUT : IN STD_LOGIC;
      CANC_IN_2 : IN STD_LOGIC;
      CANC_OUT_2 : IN STD_LOGIC;
      PISO2_FULL : IN STD_LOGIC;
      PISO1_FULL : IN STD_LOGIC;
      CANC_OUT_3 : IN STD_LOGIC;
      CANC_IN_3 : IN STD_LOGIC;
		pressure_button_1 : IN STD_LOGIC;
		pressure_button_2 : IN STD_LOGIC;
		pressure_button_3 : IN STD_LOGIC;
		b_clock : OUT STD_LOGIC;
		b_modo_inc: OUT STD_LOGIC;
		b_inc: OUT STD_LOGIC;
		inc_min : in STD_LOGIC;
		inc_hour : in STD_LOGIC;
		ocupacao_1 : in integer range 0 to 100;
		ocupacao_2 : in integer range 0 to 100;
		lug_in_1 : out STD_LOGIC;
		modo_relogio : out STD_LOGIC
		);
								
end interface;

architecture Behavioral of interface is

signal clock_count : integer range 0 to 49999999;
signal floor: integer range 0 to 1;

begin

	CC : process(clk,rst)
		begin

			if rst = '1' then clock_count <= 0;
			elsif clk'event and clk = '1' then
					
						if clock_count = 49999999 then 
							clock_count <= 0;
						else clock_count <= clock_count + 1;
			
						end if;
			end if;

	end process; 

	SYNC_PROC: process(rst,clk)
		begin
				if rst = '1' then 
					floor <= 0;
					TICKET_IN <= '0';
					TICKET_IN_2 <= '0';
					TICKET_IN_3 <= '0';
					TICKET_OUT <= '0';
					TICKET_OUT_2 <= '0';
					TICKET_OUT_3 <= '0';
				elsif clk'event and clk ='1' then
					if sw0='0' and (clock_count = 12499999 or clock_count = 24999999 or clock_count = 37499999 or clock_count = 49999998)  then
						if pressure_button_1 = '1' then
							if floor + 1 < 2 then
								floor <= floor + 1;
							else 
								floor <= 0;
							end if;
						else	
							if pressure_button_3 = '1' then
								if floor = 0 then
									TICKET_IN <= '1';
								elsif floor = 1 then
									if sw7 = '0' then
										TICKET_IN_2 <= '1';
									elsif sw7 = '1' then
										TICKET_IN_3 <= '1';
									end if;
								end if;
							else
								TICKET_IN <= '0';
								TICKET_IN_2 <= '0';
								TICKET_IN_3 <= '0';
							end if;
							
							if pressure_button_2 = '1' then
								if floor = 0 then
									TICKET_OUT <= '1';
								elsif floor = 1 then
									if sw7 = '0' then
										TICKET_OUT_2 <= '1';
									elsif sw7 = '1' then
										TICKET_OUT_3 <= '1';
									end if;
								end if;
							else
								TICKET_OUT <= '0';
								TICKET_OUT_2 <= '0';
								TICKET_OUT_3 <= '0';
							end if;	
						end if;
					end if;
				end if;
				
	end process;

	process(clk)
	begin
		if clk'event and clk='1' then
		
			if sw0='1' then
				b_modo_inc <= pressure_button_1;
				b_clock <= sw1; 
				b_inc <= pressure_button_2;
				led_0 <= inc_min;
				led_1 <= inc_hour;
				led_2 <= '0';
				led_3 <= '0';
				led_4 <= '0';
				led_5 <= '0';
				led_6 <= '0';
				led_7 <= '0';
				modo_relogio <= '1';
				lug_in_1 <= '0';
				
			elsif sw0 = '0' then
				modo_relogio <= '0';
				if floor = 0 then
					PRES1_IN <= sw1;
					PRES2_IN <= sw2;
					PRESS1_OUT <= sw3;
					PRESS2_OUT <= sw4;
					AND_12A <= sw5;
					AND_12B <= sw6;	
				   AND_21A <= '0';
					AND_21B <= '0';
					led_0 <= CANC_IN;
					led_1 <= CANC_OUT;
					led_2 <= '1'; 
					led_3 <= '0';
					led_4 <= '0';
					led_5 <= PISO1_FULL;
					lug_in_1 <= '1';
					if ocupacao_1 < 40 and ocupacao_1 >= 20 then
						led_6 <= '1';
						led_7 <= '0';
					else if ocupacao_1 < 20 and ocupacao_1 > 0 then
						led_6 <= '0';
						led_7 <= '1';
					else
						led_6 <= '0';
						led_7 <= '0';
					end if;
					end if;
				else
					PRES1_IN <= '0';
					PRES2_IN <= '0';
					PRESS1_OUT <= '0';
					PRESS2_OUT <= '0';
					AND_12A <= '0';
					AND_12B <= '0';
				end if;
				
				if floor = 1 then
					led_3 <= '1';
					led_2 <= '0';
					led_5 <= PISO2_FULL;
					AND_21A <= sw5;
					AND_21B <= sw6;
					lug_in_1 <= '0';
					if ocupacao_2 < 60 and ocupacao_2 >= 30 then
						led_6 <= '1';
						led_7 <= '0';
					else if ocupacao_2 < 30 and ocupacao_2 > 0 then
						led_6 <= '0';
						led_7 <= '1';
					else
						led_6 <= '0';
						led_7 <= '0';
					end if;
					end if;
					if sw7 = '0' then
						PRESS1_IN_2 <= sw1;
						PRESS2_IN_2 <= sw2;					
						PRESS1_OUT_2 <= sw3;
						PRESS2_OUT_2 <= sw4; 
						led_0 <= CANC_IN_2;
						led_1 <= CANC_OUT_2;
						led_2 <= PISO2_FULL;
						led_4 <= '0';
					end if;
						
					if sw7 = '1' then
						PRESS1_IN_3 <= sw1;
						PRESS2_IN_3 <= sw2;					
						PRESS1_OUT_3 <= sw3;
						PRESS2_OUT_3 <= sw4; 
						led_0 <= CANC_IN_3;
						led_1 <= CANC_OUT_3;
						led_4 <= '1'; -- para mudanca de entrada
					end if;
				end if;
			end if;
		end if;
	end process;



end Behavioral;

