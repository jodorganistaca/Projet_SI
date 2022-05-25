----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 08:50:33
-- Design Name: 
-- Module Name: Register - Behavioral
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

---A rename
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
-- VOIR GENERIC OPTION generic (N:integer : = 8); port ( E in std_logic_vector (N-1 downto 0); S : out std_logic_vector (N-1 DOWNTO 0)); end register;

entity Registers is
    Port ( addA : in STD_LOGIC_VECTOR (3 downto 0); 
           addB : in STD_LOGIC_VECTOR (3 downto 0);
           addW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC; --Vecteur 0/1 1 bit
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC; --Vecteur 0/1 1bit
           CLK : in STD_LOGIC; --same
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Registers;


architecture Behavioral of Registers is
type registersArray is array (0 to 15) of std_logic_vector(7 downto 0);
signal BankRegisters : registersArray := (others=> ( others => '0'));
signal ValueA: STD_LOGIC_VECTOR (3 downto 0);
signal ValueB: STD_LOGIC_VECTOR (3 downto 0);
-- A 0 -> 31 
-- B 32 -> 63
-- W 64 - 95
-- Data 96 - 103
-- W - 104
-- RST -105
-- 
begin
    
process --(addA,addB,DATA,RST,W)
begin
-- HORLOGE A METTRE
    wait until CLK'Event and CLK='1';
    
    if(RST/='0') then 
        if(W='1') then 
          --  if (addW = addA or addW = addB) then ValueA<=DATA; --Lecture en même temps que registre => Lecture donne DATA
           -- else
                BankRegisters(to_integer(unsigned(addW)))<= DATA;
                ValueA<=addA;
                ValueB<=addB;
          --  end if;
           --- BankRegisters(to_integer(unsigned(addA)))<= DATA;
           -- BankRegisters(to_integer(unsigned(addB)))<= DATA;
           -- Value <= DATA;
         
         
        end if;
    else --RST à 0
        for i in 0 to 15 loop
             BankRegisters(i) <= ( others => '0');   
        end loop;
        
    end if;

end process;


QA<=BankRegisters(to_integer(unsigned(ValueA)));
QB<=BankRegisters(to_integer(unsigned(ValueB)));
end Behavioral;
