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
signal DataI : dataInstructArray :=  
    (0=> x"01060800", -- AFC 01 02
     1=> x"02080100", -- STORE 02 01
     2=> x"03070200", -- LOAD 03 02
     --1=> x"02060400", -- AFC 02 04
     --2=> x"03060600", -- AFC 03 06
     --3=> x"04050100", -- COP 04 01
     --4=> x"05050700", -- COP 05 02
     --5=> x"06050300", -- COP 06 03
     --6=> x"07050100", -- COP 07 01
     --7=> x"08010102", -- ADD 08 01 02
     --8=> x"09020102", -- MUL 09 01 02
     --9=> x"10030201", -- SOU 10 02 01
    --10=> x"11040301", -- DIV 11 03 01
    --11=> x"12080200", -- STORE 12 02 
    --12=> x"13071200", -- LOAD 13 12
     others => x"00000000");
begin
-- A : 31 downto 24
-- Op : 23 down to 16
-- B : 15 down to 8 addA
-- C : 7 down to 0 addB
--DataI <= (others =>((31 downto 24) => X"AF"));
--
process --(addA,addB,DATA,RST,W)
begin
-- HORLOGE A METTRE
    wait until CLK'Event and CLK='1';
        addI<=add;
end process;

OUTPUT<=DataI(to_integer(unsigned(addI)));
end Behavioral;