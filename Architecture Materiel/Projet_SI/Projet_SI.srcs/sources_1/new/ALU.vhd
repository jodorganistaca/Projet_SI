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
use IEEE.NUMERIC_STD.ALL;

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
signal Value: UNSIGNED(15 downto 0);
signal Value16: STD_LOGIC_VECTOR (15 downto 0) := ( others => '0');
signal Value8: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal a_new: UNSIGNED(15 downto 0) := ( others => '0');
signal b_new: UNSIGNED (15 downto 0) := ( others => '0');
signal flagO: STD_LOGIC:= '0';
signal flagC: STD_LOGIC:='0';
signal flagZ: STD_LOGIC:='0';
signal flagN: STD_LOGIC:='0';
begin 

process(Ctrl_Alu,A,B,a_new,b_new,flagC,Value,flagZ,flagO,flagN)
begin
    a_new <= resize(unsigned(A), 16); --FFFF ?
    b_new <= resize(unsigned(B), 16);
     -- S=0 => Z=1
    -- A+B Addition => S  prendre en compte les carry (C=1) si on a  S> 2^8 => Overflow (O=1)
    if (Ctrl_Alu=X"0") then 
        -- (A||B > 4 &  bit 1 A&B) bit 8  de A || B == 1 & bit 7 A&B = 1 OR bit 8 A & B = 1  => C =1
        
        -- A+B=0 => Z=1 
        Value <= a_new + b_new;
        Value8 <=std_logic_vector(resize(Value,8));
        if (to_integer(unsigned(Value))>255) then flagC<='1';
         else
               flagC<='0'; 
        end if;
        if (unsigned(Value)>255) then flagO<='1'; 
         else
               flagO<='0';
        end if;
        if (unsigned(Value)=0) then flagZ<='1'; --report "The value of 'VALUE' is " & integer'image(to_integer(Value)); 
        else
            flagZ<='0';
        end if;
        --Value<=std_logic_vector(to_signed(to_integer(signed(a_new) + signed(b_new)),16));
        --Value<=std_logic_vector((resize(A,16) + resize(B,16)));
       -- if(to_integer(signed(Value) ) then
            --flagO<='1';
            --flagC  <= '1';
           --flagO<='1';
       --report "The value of 'VALUE' is " & integer'image(to_integer(Value));
       -- end if;
       
    
    elsif  (Ctrl_Alu=X"02") then 
        Value <= a_new - b_new;
        Value8 <=std_logic_vector(resize(Value,8));
        if (unsigned(b_new)>unsigned(a_new)) then flagN<='1'; --report "The value of 'VALUE' is " & integer'image(to_integer(Value)); 
        else
            flagN<='0';
        end if;
        if (unsigned(Value)>255) then flagO<='1'; 
             else
                   flagO<='0';
            end if;
        if (unsigned(Value)=0) then flagZ<='1'; --report "The value of 'VALUE' is " & integer'image(to_integer(Value)); 
        else
            flagZ<='0';
        end if;
    --Value<=std_logic_vector(to_signed(to_integer(signed(A) + signed(B)),16));
   elsif  (Ctrl_Alu=X"01") then
         Value16<=std_logic_vector(to_signed(to_integer(unsigned(A) * unsigned(B)),16));
         Value8 <=std_logic_vector(resize(unsigned(Value16),8));
  --      Value <= a_new * b_new;
       if((signed(A)<0 and signed(B)>0) or (signed(A)>0 and signed(B)<0)) then flagN<='1';
       else
        flagN<='0';
       end if;
       if (unsigned(Value16)>255) then flagO<='1'; 
       else
             flagO<='0';
      end if;
      if (unsigned(Value16)=0) then flagZ<='1'; --report "The value of 'VALUE' is " & integer'image(to_integer(Value)); 
      else
          flagZ<='0';
      end if;
        
   elsif  (Ctrl_Alu=X"3") then 
     --   Value <= a_new / b_new;
      if (unsigned(B)=0) then flagO<='1'; 
         Value8<=std_logic_vector(to_signed(0,8));
      else
        flagO<='0';
                    
        Value8<=std_logic_vector(to_signed(to_integer(unsigned(A) / unsigned(B)),8));
         if((signed(A)<0 and signed(B)>0) or (signed(A)>0 and signed(B)<0)) then flagN<='1';
           else
             flagN<='0';
           end if;
             --      Value <= a_new * b_new;
                 
         if (unsigned(Value8)=0) then flagZ<='1'; --report "The value of 'VALUE' is " & integer'image(to_integer(Value)); 
         else
             flagZ<='0';
         end if;
        end if;
    end if;
    -- A-B soustractiosn S<0 => N=1 
    --Value8 <= std_logic_vector(to_signed(to_integer(signed(Value)),8)); 
    --Value8 <=    
    -- Ctrl _ ALU 0-> 7 Add 0 Mul 1 Sous2  Division 3 Copie 4  AFC 5 LOAD 6 SAVE 7
    
    
end process; 
    S<=Value8;
    C<=flagC;
    O<=flagO;
    Z<=flagZ;
    N<=flagN;
end Behavioral;
