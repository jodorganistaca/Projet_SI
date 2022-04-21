----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 09:51:19
-- Design Name: 
-- Module Name: Simulation_ALU - Behavioral
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

entity Simulation_ALU is
end Simulation_Alu;
architecture Behavioral of Simulation_ALU is
COMPONENT ALU
Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
--  Port ( );
end COMPONENT;
-- inputs
signal A_Test : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal B_Test : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal Ctrl_Alu_Test : STD_LOGIC_VECTOR (2 downto 0):= ( others => '0');
-- out puts
signal S_Test : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal N_Test : STD_LOGIC :='0';
signal O_Test : STD_LOGIC :='0';
signal Z_Test : STD_LOGIC :='0';
signal C_Test : STD_LOGIC :='0';

begin
Label_uut: ALU PORT MAP (
    A => A_Test,
    B => B_Test,
    Ctrl_Alu => Ctrl_Alu_Test,
    S => S_Test,
    N => N_Test,
    O => O_Test,
    Z => Z_Test,
    C => C_Test
    );
   process
   begin
   end process;
 
    --Stimulus process
    Ctrl_Alu_Test <= "011";
    A_Test <= X"FF";
    B_Test <= X"00";
end Behavioral;
