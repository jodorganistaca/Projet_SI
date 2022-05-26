----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 08:46:19
-- Design Name: 
-- Module Name: Instructions_Memory - Behavioral
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

entity Instructions_Memory is
    Port ( add : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
           
end Instructions_Memory;

architecture Behavioral of Instructions_Memory is

signal addI : STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
type dataInstructArray is array (0 to 255) of std_logic_vector(31 downto 0); --VERIFIER LA TAILLE DE DATAINSTRUCT
signal DataI : dataInstructArray := (others=> ( others => '0'));

begin
-- A : 31 downto 24
-- Op : 23 down to 16
-- B : 15 down to 8 addA
-- C : 7 down to 0 addB
--DataI <= (others =>((31 downto 24) => X"AF"));
--DataI <= (x"00050144", x"01058899",x"66738499", others => x"00000000");
process --(addA,addB,DATA,RST,W)
begin
-- HORLOGE A METTRE
    wait until CLK'Event and CLK='1';
        addI<=add;
end process;

OUTPUT<=DataI(to_integer(unsigned(addI)));
end Behavioral;