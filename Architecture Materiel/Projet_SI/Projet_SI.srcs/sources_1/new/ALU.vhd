----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.04.2022 08:55:14
-- Design Name: 
-- Module Name: ALU - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
signal Value: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
begin 

process(Ctrl_Alu,A,B)
begin

     -- S=0 => Z=1
    -- A+B Addition => S  prendre en compte les carry (C=1) si on a  S> 2^8 => Overflow (O=1)
    if (Ctrl_Alu=X"0") then 
        -- (A||B > 4 &  bit 1 A&B) bit 8  de A || B == 1 & bit 7 A&B = 1 OR bit 8 A & B = 1  => C =1
        
        -- A+B=0 => Z=1 
        Value<=(A+B);
    elsif  (Ctrl_Alu=X"2") then Value<=(A-B);
  --  elsif  (Ctrl_Alu=X"1") then Value<=(A*B);
    --elsif  (Ctrl_Alu=X"3") then Value<=(A/B);
    end if;
    -- A-B soustraction S<0 => N=1 
    
    -- Ctrl _ ALU 0-> 7 Add 0 Mul 1 Sous2  Division 3 Copie 4  AFC 5 LOAD 6 SAVE 7
end process;
   
    S<=Value;
end Behavioral;
