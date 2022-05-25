----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 08:45:19
-- Design Name: 
-- Module Name: RISC_SI - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RISC_SI is
    Port ( add : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end RISC_SI;

architecture Behavioral of RISC_SI is
type dataMemoryArray is array (0 to 255) of std_logic_vector(7 downto 0);
signal DataM : dataMemoryArray;
signal Value: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

begin 
process
begin
    wait until CLK'Event and CLK='1';
    
    if(RST/='0') then
        if(RW='0') then -- écriture
            DataM(to_integer(unsigned(add)))<= INPUT;
           -- Value <= INPUT;
        else -- (RW='1')  lecture 
            Value <= add;
        end if;
    else
        for i in 0 to 255 loop
            DataM(i) <= ( others => '0');   
        end loop;
    end if;
end process;
OUTPUT<=DataM(to_integer(unsigned(Value)));
end Behavioral;