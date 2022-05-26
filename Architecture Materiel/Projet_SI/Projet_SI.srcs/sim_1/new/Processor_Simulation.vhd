----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2022 11:54:23
-- Design Name: 
-- Module Name: Processor_Simulation - Behavioral
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

entity Processor_Simulation is
--  Port ( );
end Processor_Simulation;

architecture Behavioral of Processor_Simulation is
component Processor
    Port ( IP : in STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC;
           A_Test : out STD_LOGIC_VECTOR (7 downto 0);
           OP_Test : out STD_LOGIC_VECTOR (7 downto 0);
           B_Test : out STD_LOGIC_VECTOR (7 downto 0);
           C_Test : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--COMPONENT Instructions_Memory
--    Port ( add : in STD_LOGIC_VECTOCLKR (7 downto 0);
--           CLK : in STD_LOGIC;
--           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
--end COMPONENT;
--component Registers
--    Port ( addA : in STD_LOGIC_VECTOR (3 downto 0);
--           addB : in STD_LOGIC_VECTOR (3 downto 0);
--           addW : in STD_LOGIC_VECTOR (3 downto 0);
--           W : in STD_LOGIC; --Vecteur 0/1 1 bit
--           DATA : in STD_LOGIC_VECTOR (7 downto 0);
--           RST : in STD_LOGIC; --Vecteur 0/1 1bit
--           CLK : in STD_LOGIC; --same
--           QA : out STD_LOGIC_VECTOR (7 downto 0);
--           QB : out STD_LOGIC_VECTOR (7 downto 0));
--end component;
--- Proccessor
signal Processor_CLK_Test : STD_LOGIC := '1';
signal A_Test : STD_LOGIC_VECTOR (7 downto 0);
signal OP_Test : STD_LOGIC_VECTOR (7 downto 0);
signal B_Test : STD_LOGIC_VECTOR (7 downto 0);
signal C_Test : STD_LOGIC_VECTOR (7 downto 0);
--- Memory instructions
--inputs
signal Instructions_Memory_add_test : STD_LOGIC_VECTOR (31 downto 0):= ( others => '0');-- instancier à 0
signal Instructions_Memory_CLK_test :  STD_LOGIC:='0';
--output
signal Instructions_Memory_Output_test :  STD_LOGIC_VECTOR (31 downto 0):= ( others => '0');

signal Registers_DATA :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal Registers_addW : STD_LOGIC_VECTOR (3 downto 0):= ( others => '0');

constant Clock_period : time := 10 ns;

begin
processor_portmap: Processor PORT MAP (
    IP => Instructions_Memory_add_test,
    CLK => Processor_CLK_Test,
    A_Test => A_Test,
    OP_Test => OP_Test,
    B_Test => B_Test,
    C_Test => C_Test
);


Clock_process : process
begin
    Processor_CLK_Test <= not(Processor_CLK_Test);
    wait for Clock_period/2;
end process;


 --Stimulus process
 --IP   32 bits XX XX XX XX
 --Out 4*8 bits A  OP  B  C    
 --Stimulus process  <= X"00051544" after 0 ns, x"00052244" after 100 ns, x"00052444" after 300 ns;
                                -- COP 01 08           -- COP 02 02               --ADD 00 01 02 
 Instructions_Memory_add_test <= X"01050800" after 0 ns, x"02050200" after 100 ns, x"00000102" after 200 ns;
 --A_Test <= X"00" after 0 ns, X"00" after 100 ns, X"01" after 200 ns, X"02" after 300 ns, X"01" after 400 ns;
 --OP_Test <= X"05" after 0 ns, X"05" after 100 ns, X"05" after 200 ns, X"05" after 300 ns, X"04" after 400 ns;
 --B_Test <= X"01" after 0 ns, X"02" after 100 ns, X"02" after 200 ns, X"00" after 300 ns, X"02" after 400 ns;
 --C_Test <= X"00" after 0 ns, X"AA" after 100 ns, X"A0" after 200 ns, X"01" after 300 ns, X"03" after 400 ns;
 -- FINIR LA CREATION DU STEST AFC 
 


end Behavioral;
