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
--AFC then COP / STORE then LOAD / LOAD then COP / AFC then ALU OP / ALU then COP / AFC then STORE / ALU then STORE (Alea Cases) 
signal DataI : dataInstructArray :=  
    (--------- UNCOMMENT TO TEST (AFC then COP) ---------
     --0=> x"01061400", -- AFC 01 14
     --1=> x"02060800", -- AFC 02 08
     --2=> x"01061200", -- AFC 01 12
     --3=> x"02050100", -- COP 04 01
     --------- UNCOMMENT TO TEST (STORE then LOAD) ---------
     --0=> x"01061400", -- AFC 01 14
     --1=> x"02080100", -- STORE 02 01
     --2=> x"03070200", -- LOAD 03 02
     --------- UNCOMMENT TO TEST (LOAD then COP) ---------
     --3=> x"00050300", -- COP 00 03
     --------- UNCOMMENT TO TEST (AFC then ALU OP) ---------
     --0=> x"01060200", -- AFC 01 02
     --1=> x"02060400", -- AFC 01 04
     --2=> x"03060800", -- AFC 01 08
     --3=> x"04010102", -- ADD 08 01 02
     --4=> x"04060500", -- AFC 04 05
     --5=> x"05020401", -- MUL 05 04 01
     --6=> x"05060600", -- AFC 05 06
     --7=> x"06040501", -- DIV 06 05 01
     --8=> x"06061400", -- AFC 06 14
     --9=> x"07030601", -- SOU 07 06 01
     --------- UNCOMMENT TO TEST (ALU then COP) ---------
     0=> x"01061200", -- AFC 01 12
     1=> x"02060800", -- AFC 02 08
     2=> x"04010102", -- ADD 04 01 02
     3=> x"03050400", -- COP 03 04
     4=> x"01060200", -- AFC 01 02
     5=> x"05020102", -- MUL 05 01 02
     6=> x"06050400", -- COP 06 05
     7=> x"07040601", -- DIV 07 06 01
     8=> x"08050700", -- COP 08 07
     9=> x"09030208", -- SOU 09 02 08
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