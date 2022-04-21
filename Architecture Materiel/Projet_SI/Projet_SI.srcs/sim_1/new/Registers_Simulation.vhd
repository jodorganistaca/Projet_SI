----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 10:29:16
-- Design Name: 
-- Module Name: Registers_Simulation - Behavioral
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
entity Registers_Simulation is
end Registers_Simulation;
architecture Behavioral of Registers_Simulation is
COMPONENT Registers
    Port (
    addA : in STD_LOGIC_VECTOR (3 downto 0);
               addB : in STD_LOGIC_VECTOR (3 downto 0);
               addW : in STD_LOGIC_VECTOR (3 downto 0);
               W : in STD_LOGIC;
               DATA : in STD_LOGIC_VECTOR (7 downto 0);
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               QA : out STD_LOGIC_VECTOR (7 downto 0);
               QB : out STD_LOGIC_VECTOR (7 downto 0));
               
end COMPONENT;
--inputs
signal Test_addA : STD_LOGIC_VECTOR (3 downto 0):= ( others => '0');-- instancier à 0
signal Test_addB :  STD_LOGIC_VECTOR (3 downto 0):= ( others => '0');
signal  Test_addW : STD_LOGIC_VECTOR (3 downto 0):= ( others => '0');
signal   Test_W :  STD_LOGIC:='0';
signal  Test_DATA :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal  Test_RST :  STD_LOGIC:='1';
signal Test_CLK :  STD_LOGIC:='0';
signal Test_QA :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal Test_QB :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');

begin
Label_uut: Registers PORT MAP (
    addA => Test_addA,
    addB => Test_addB, 
    addW => Test_addW, 
    W => Test_W ,
    DATA => Test_DATA,
    RST => Test_RST,
    CLK => Test_CLK,
    QA => Test_QA,
    QB=>Test_QB
    );
    process
    begin
    end process;
 end Behavioral;   