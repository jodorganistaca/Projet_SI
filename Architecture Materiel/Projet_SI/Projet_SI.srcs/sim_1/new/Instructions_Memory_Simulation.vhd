----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 12:11:49
-- Design Name: 
-- Module Name: Instructions_Memory_Simulation - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instructions_Memory_Simulation is
end Instructions_Memory_Simulation;
architecture Behavioral of Instructions_Memory_Simulation is
COMPONENT Instructions_Memory
    Port ( add : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

--inputs
signal Test_addA : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');-- instancier à 0
signal Test_CLK :  STD_LOGIC:='0';
--output
signal Test_Output :  STD_LOGIC_VECTOR (31 downto 0):= ( others => '0');
constant Clock_period : time := 10 ns;

begin
Label_uut: Instructions_Memory PORT MAP (
    add => Test_addA,
    CLK => Test_CLK, 
    OUTPUT => Test_Output
);
--Clock process definitions
Clock_process : process
begin
    Test_CLK <= not(Test_CLK);
    wait for Clock_period/2;
end process;

 --Stimulus process
 Test_addA  <= X"FF" after 0 ns, X"AA" after 100 ns, X"A0" after 300 ns, X"CA" after 700 ns, X"AB" after 800 ns;
 

end Behavioral;
