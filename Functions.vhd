----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:27:16 01/13/2022 
-- Design Name: 
-- Module Name:    Functions - Behavioral 
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

entity Functions is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  carro_IN_Piso1 : in STD_LOGIC;
			  carro_IN_1_Piso2 : in STD_LOGIC;
			  carro_IN_2_Piso2 : in STD_LOGIC;
			  carro_OUT_Piso1 : in STD_LOGIC;
			  carro_OUT_1_Piso2 : in STD_LOGIC;
			  carro_OUT_2_Piso2 : in STD_LOGIC;
			  conta_IN_Piso1_mu : out integer range 0 to 9;
			  conta_IN_Piso1_md : out integer range 0 to 9;
			  conta_IN_Piso2_mu : out integer range 0 to 9;
			  conta_IN_Piso2_md : out integer range 0 to 9;
			  conta_OUT_Piso1_mu : out integer range 0 to 9;
			  conta_OUT_Piso1_md : out integer range 0 to 9;
			  conta_OUT_Piso2_mu : out integer range 0 to 9;
			  conta_OUT_Piso2_md : out integer range 0 to 9;
			  conta_lot_1_mu: out integer range 0 to 9;
			  conta_lot_1_md: out integer range 0 to 9;
			  conta_lot_2_mu: out integer range 0 to 9;
			  conta_lot_2_md: out integer range 0 to 9;
			  carro_12: in STD_LOGIC;
			  carro_21: in STD_LOGIC
			);
end Functions;

architecture Behavioral of Functions is

signal cont_in_1_mu, cont_in_2_mu, cont_out_1_mu, cont_out_2_mu: integer range 0 to 9;
signal cont_in_1_md, cont_in_2_md, cont_out_1_md, cont_out_2_md: integer range 0 to 9;
signal cont_lot_1_mu, cont_lot_1_md, cont_lot_2_mu, cont_lot_2_md: integer range 0 to 9;
signal in_md, in_2_md, lot_1_d, lot_1_u, lot_2_u, lot_2_d : STD_LOGIC;
signal out_md, out_2_md: STD_LOGIC;

begin

--carro_in_Piso1

process (clk, reset) 
begin 
	if reset = '1' then 
		cont_in_1_mu <= 0;	
	elsif clk'event and clk = '1' then 
		if carro_IN_Piso1 = '1' then
			if cont_in_1_mu = 9 then 
				cont_in_1_mu <= 0; 
			else cont_in_1_mu <= cont_in_1_mu + 1; 
			end if; 
		end if; 
	end if; 
end process;

in_md <= '1' when cont_in_1_mu = 9 and carro_IN_Piso1 = '1' else '0'; 
conta_IN_Piso1_mu <= cont_in_1_mu;

process (clk, reset) 
begin 
	if reset = '1' then 
		cont_in_1_md <= 0;	
	elsif clk'event and clk = '1' then 
		if in_md = '1' then
			if cont_in_1_md = 9 then 
				cont_in_1_md <= 0; 
			else cont_in_1_md <= cont_in_1_md + 1; 
			end if; 
		end if; 
	end if; 
end process;
 
conta_IN_Piso1_md <= cont_in_1_md;

--carro_in_Piso2

process (clk, reset) 
begin 
	if reset = '1' then 
		cont_in_2_mu <= 0;	
	elsif clk'event and clk = '1' then 
		if carro_IN_1_Piso2 = '1' or carro_IN_2_Piso2 = '1' then
			if cont_in_2_mu = 9 then 
				cont_in_2_mu <= 0; 
			else cont_in_2_mu <= cont_in_2_mu + 1; 
			end if; 
		end if; 
	end if; 
end process;

in_2_md <= '1' when cont_in_2_mu = 9 and (carro_IN_1_Piso2 = '1' or carro_IN_2_Piso2 = '1') else '0'; 
conta_IN_Piso2_mu <= cont_in_2_mu; -- cont_in_1_mu

process (clk, reset) 
begin 
	if reset = '1' then 
		cont_in_2_md <= 0;	
	elsif clk'event and clk = '1' then 
		if in_2_md = '1' then
			if cont_in_2_md = 9 then 
				cont_in_2_md <= 0; 
			else cont_in_2_md <= cont_in_2_md + 1; 
			end if; 
		end if; 
	end if; 
end process;
 
conta_IN_Piso2_md <= cont_in_2_md;

--Carro_out_Piso1

process (clk, reset) 
begin 
	if reset = '1' then 
		cont_out_1_mu <= 0;	
	elsif clk'event and clk = '1' then 
		if carro_OUT_Piso1 = '1' then
			if cont_out_1_mu = 9 then 
				cont_out_1_mu <= 0; 
			else cont_out_1_mu <= cont_out_1_mu + 1; 
			end if; 
		end if; 
	end if; 
end process;

out_md <= '1' when cont_out_1_mu = 9 and carro_OUT_Piso1 = '1' else '0'; 
conta_OUT_Piso1_mu <= cont_out_1_mu;

process (clk, reset) 
begin 
	if reset = '1' then 
		cont_out_1_md <= 0;	
	elsif clk'event and clk = '1' then 
		if out_md = '1' then -- in_md
			if cont_out_1_md = 9 then 
				cont_out_1_md <= 0; 
			else cont_out_1_md <= cont_out_1_md + 1; 
			end if; 
		end if; 
	end if; 
end process;
 
conta_OUT_Piso1_md <= cont_OUT_1_md;

--Carro_out_Piso2

process (clk, reset) 
begin 
	if reset = '1' then 
		cont_out_2_mu <= 0;	
	elsif clk'event and clk = '1' then 
		if carro_OUT_1_Piso2 = '1' or carro_OUT_2_Piso2 = '1' then
			if cont_out_2_mu = 9 then 
				cont_out_2_mu <= 0; 
			else cont_out_2_mu <= cont_out_2_mu + 1; 
			end if; 
		end if; 
	end if; 
end process;

out_2_md <= '1' when cont_out_2_mu = 9 and (carro_OUT_1_Piso2 = '1' or carro_OUT_2_Piso2 = '1') else '0'; 
conta_OUT_Piso2_mu <= cont_out_2_mu;

process (clk, reset) 
begin 
	if reset = '1' then 
		cont_out_2_md <= 0;	
	elsif clk'event and clk = '1' then 
		if out_2_md = '1' then
			if cont_out_2_md = 9 then 
				cont_out_2_md <= 0; 
			else cont_out_2_md <= cont_out_2_md + 1; 
			end if; 
		end if; 
	end if; 
end process;

conta_OUT_Piso2_md <= cont_out_2_md;

--lotacao Piso1
process (clk, reset)
begin
	if reset = '1' then 
		cont_lot_1_mu <= 0;	
	elsif clk'event and clk = '1' then 
		if carro_IN_Piso1 = '1' or carro_21 = '1' then
			if cont_lot_1_mu = 9 then 
				cont_lot_1_mu <= 0; 
			else cont_lot_1_mu <= cont_lot_1_mu + 1;
			end if;
		elsif carro_OUT_Piso1 = '1' or carro_12 = '1' then
			if cont_lot_1_mu = 0 then 
				cont_lot_1_mu <= 9; 
			else cont_lot_1_mu <= cont_lot_1_mu - 1;
			end if; 
		end if; 
	end if;
end process;

lot_1_d <= '1' when cont_lot_1_mu = 9 and (carro_21 = '1' or carro_IN_Piso1 = '1') else '0';
lot_1_u <= '1' when cont_lot_1_mu = 0 and (carro_12 = '1' or carro_OUT_Piso1 = '1') else '0';
conta_lot_1_mu <= cont_lot_1_mu;

process (clk, reset)
begin
	if reset = '1' then 
		cont_lot_1_md <= 0;	
	elsif clk'event and clk = '1' then 
		if lot_1_d = '1' then
			if cont_lot_1_md = 9 then 
				cont_lot_1_md <= 0; 
			else cont_lot_1_md <= cont_lot_1_md + 1;
			end if;
		elsif lot_1_u = '1' then
			if cont_lot_1_md = 0 then 
				cont_lot_1_md <= 0; 
			else cont_lot_1_md <= cont_lot_1_md - 1;
			end if; 
		end if; 
	end if;
end process;

conta_lot_1_md <= cont_lot_1_md;

--lotacao Piso2
process (clk, reset)
begin
	if reset = '1' then 
		cont_lot_2_mu <= 0;	
	elsif clk'event and clk = '1' then 
		if carro_IN_1_Piso2 = '1' or carro_IN_2_Piso2 = '1' or carro_12 = '1' then
			if cont_lot_2_mu = 9 then 
				cont_lot_2_mu <= 0; 
			else cont_lot_2_mu <= cont_lot_2_mu + 1;
			end if;
		elsif carro_OUT_1_Piso2 = '1' or carro_OUT_2_Piso2 = '1' or carro_21 = '1' then
			if cont_lot_2_mu = 0 then 
				cont_lot_2_mu <= 9; 
			else cont_lot_2_mu <= cont_lot_2_mu - 1;
			end if; 
		end if; 
	end if;
end process;

lot_2_d <= '1' when cont_lot_2_mu = 9 and (carro_IN_1_Piso2 = '1' or carro_IN_2_Piso2 = '1' or carro_12 = '1') else '0';
lot_2_u <= '1' when cont_lot_2_mu = 0 and (carro_OUT_1_Piso2 = '1' or carro_OUT_2_Piso2 = '1' or carro_21 = '1') else '0';
conta_lot_2_mu <= cont_lot_2_mu;

process (clk, reset)
begin
	if reset = '1' then 
		cont_lot_2_md <= 0;	
	elsif clk'event and clk = '1' then 
		if lot_2_d = '1' then
			if cont_lot_2_md = 9 then 
				cont_lot_2_md <= 0; 
			else cont_lot_2_md <= cont_lot_2_md + 1;
			end if;
		elsif lot_2_u = '1' then
			if cont_lot_2_md = 0 then 
				cont_lot_2_md <= 0; 
			else cont_lot_2_md <= cont_lot_2_md - 1;
			end if; 
		end if; 
	end if;
end process;

conta_lot_2_md <= cont_lot_2_md;

end Behavioral;

