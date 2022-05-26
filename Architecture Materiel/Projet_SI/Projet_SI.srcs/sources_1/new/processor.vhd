----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2022 10:33:06
-- Design Name: 
-- Module Name: processor - Behavioral
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

-- A : 31 down to 24
-- Op : 23 down to 16
-- B : 15 down to 8 addA
-- C : 7 down to 0 addB


entity processor is
    Port ( IP : in STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC;
           A_Test : out STD_LOGIC_VECTOR (7 downto 0);
           OP_Test : out STD_LOGIC_VECTOR (7 downto 0);
           B_Test : out STD_LOGIC_VECTOR (7 downto 0);
           C_Test : out STD_LOGIC_VECTOR (7 downto 0));
end processor;

architecture Behavioral of processor is

component Instructions_Memory 
    Port ( add : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component Registers
    Port ( addA : in STD_LOGIC_VECTOR (3 downto 0); 
           addB : in STD_LOGIC_VECTOR (3 downto 0);
           addW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC; --Vecteur 0/1 1 bit
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC; --Vecteur 0/1 1bit
           CLK : in STD_LOGIC; --same
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component ALU 
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0); 
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC);
end component;

component RISC_SI
    Port ( add : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Buffer_Pipeline is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
         OP : in STD_LOGIC_VECTOR (7 downto 0);
         B : in STD_LOGIC_VECTOR (7 downto 0);
         C : in STD_LOGIC_VECTOR (7 downto 0);
         CLK : in STD_LOGIC;
         A_Out : out STD_LOGIC_VECTOR (7 downto 0);
         OP_Out : out STD_LOGIC_VECTOR (7 downto 0);
         B_Out : out STD_LOGIC_VECTOR (7 downto 0);
         C_Out : out STD_LOGIC_VECTOR (7 downto 0));
end component;

--- Memory instructions
--inputs
signal Instructions_Memory_add : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');-- instancier à 0
--signal Instructions_Memory_CLK :  STD_LOGIC:='0';
--output
signal Instructions_Memory_Output :  STD_LOGIC_VECTOR (31 downto 0):= ( others => '0');
constant Instructions_Memory_Clock_period : time := 10 ns;

--- Bank of registers
--inputs
signal Registers_addA : STD_LOGIC_VECTOR (3 downto 0):= ( others => '0');-- instancier à 0
signal Registers_addB :  STD_LOGIC_VECTOR (3 downto 0):= ( others => '0');
signal Registers_addW : STD_LOGIC_VECTOR (3 downto 0):= ( others => '0');
signal Registers_W :  STD_LOGIC:='1';
signal Registers_DATA :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal RST :  STD_LOGIC:='1';
--signal Registers_CLK :  STD_LOGIC:='1';
--output
signal Registers_QA :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal Registers_QB :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');

--- UAL
-- inputs
signal ALU_A : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal ALU_B : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal ALU_Ctrl_Alu : STD_LOGIC_VECTOR (2 downto 0):= ( others => '0');
-- out puts
signal ALU_S : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal ALU_N : STD_LOGIC :='0';
signal ALU_O : STD_LOGIC :='0';
signal ALU_Z : STD_LOGIC :='0';
signal ALU_C : STD_LOGIC :='0';

--- Data memory
 --inputs 
signal RISC_SI_add : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal RISC_SI_RW :  STD_LOGIC:='1';
signal RISC_SI_INPUT :  STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
signal RISC_SI_RST :  STD_LOGIC:='1';
--signal RISC_SI_CLK :  STD_LOGIC:='0';
--output
signal RISC_SI_OUTPUT : STD_LOGIC_VECTOR (7 downto 0):= ( others => '0');
--clk      
-- Si 100 MHz
constant Clock_period : time := 10 ns;
--Buffer Pipelines
signal A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0'); -- A : 31 downto 24
signal OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0'); -- Op : 23 down to 16
signal B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0'); -- B : 15 down to 8 addA
signal C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0'); -- C : 7 down to 0 addB

signal LI_DI_A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal LI_DI_OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal LI_DI_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal LI_DI_C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

signal DI_EX_A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal DI_EX_OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal DI_EX_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal DI_EX_C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

signal EX_MEM_A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal EX_MEM_OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal EX_MEM_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal EX_MEM_C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');

signal MEM_RE_A: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal MEM_RE_OP: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal MEM_RE_B: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');
signal MEM_RE_C: STD_LOGIC_VECTOR (7 downto 0) := ( others => '0');


begin

Instructions_Memory_Port_Map:Instructions_Memory  PORT MAP (
    add => Instructions_Memory_add,
    CLK => CLK, 
    OUTPUT => Instructions_Memory_Output
);

LI_DI : Buffer_Pipeline PORT MAP (
    A => A,
    OP => OP,
    B => B,
    C => C,
    CLK => CLK,
    A_Out => LI_DI_A,
    OP_Out => LI_DI_OP,
    B_Out => LI_DI_B,
    C_Out => LI_DI_C
);

Registers_Port_Map: Registers  PORT MAP (
    addA => Registers_addA,
    addB => Registers_addB, 
    addW => Registers_addW,
    W => Registers_W,
    DATA => Registers_DATA,
    RST => RST,
    CLK => CLK,
    QA => Registers_QA,
    QB => Registers_QB
);

DI_EX : Buffer_Pipeline PORT MAP (
    A => LI_DI_A,
    OP => LI_DI_OP,
    B => LI_DI_B,
    C => LI_DI_C,
    CLK => CLK,
    A_Out => DI_EX_A,
    OP_Out => DI_EX_OP,
    B_Out => DI_EX_B,
    C_Out => DI_EX_C
);

ALU_Port_Map: ALU  PORT MAP (
    A => ALU_A,
    B => ALU_A,
    Ctrl_Alu => ALU_Ctrl_Alu,
    S => ALU_S,
    N => ALU_N,
    O => ALU_O,
    Z => ALU_Z,
    C => ALU_C
);

EX_MEM : Buffer_Pipeline PORT MAP (
    A => DI_EX_A,
    OP => DI_EX_OP,
    B => DI_EX_B,
    C => DI_EX_C,
    CLK => CLK,
    A_Out => EX_MEM_A,
    OP_Out => EX_MEM_OP,
    B_Out => EX_MEM_B,
    C_Out => EX_MEM_C
);

Data_Memory_Port_Map: RISC_SI  PORT MAP (
    add => RISC_SI_add,
    INPUT => RISC_SI_INPUT, --(7 downto 0);
    RW => RISC_SI_RW,-- 0/1
    RST => RST, --0/1
    CLK => CLK, --0/1
    OUTPUT => RISC_SI_OUTPUT -- (7 downto 0));
);

MEM_RE : Buffer_Pipeline PORT MAP (
    A => EX_MEM_A,
    OP => EX_MEM_OP,
    B => EX_MEM_B,
    C => EX_MEM_C,
    CLK => CLK,
    A_Out => MEM_RE_A,
    OP_Out => MEM_RE_OP,
    B_Out => MEM_RE_B
);
 
process
begin
    
    A  <= Instructions_Memory_Output(31 downto 24); -- A : 31 downto 24
    OP  <= Instructions_Memory_Output(23 downto 16); -- Op : 23 down to 16
    B  <= Instructions_Memory_Output(15 downto 8); -- B : 15 down to 8 addA
    C  <= Instructions_Memory_Output(7 downto 0); -- C : 7 down to 0 addB
    
    wait until CLK'Event and CLK='1';
        
    --if OP=x"05" then         
    --    Registers_addW <= A(3 downto 0);     
    --    Registers_W <= '1'; --OP AFC so Write (1) / Read (0)  
    --    Registers_DATA <= B;            
    --COP
    --elsif OP=x"04" then
    --    Registers_addW <= A(3 downto 0);
    --    Registers_W <= '1'; --OP COP so Write (1) / Read (0)  
    --    RISC_SI_add <= B;
    --    Registers_DATA <= RISC_SI_OUTPUT;
    --DIV
    --elsif OP=x"03" then
    --    Registers_addW <= A(3 downto 0);
    --    Registers_W <= '1'; --OP COP so Write (1) / Read (0)  
    --    ALU_A <= Registers_QA;
    --    ALU_B <= Registers_QB; 
    --    ALU_Ctrl_Alu <= OP(2 downto 0);
    --    Registers_DATA <= ALU_S;
    --SOU
    --elsif OP=x"02" then
        
    --MUL
    --elsif OP=x"01" then
        
    --ADD
    --elsif OP=x"00" then
        --LI/DI
        --Registers_addA <= B(3 downto 0);
        --Registers_addB <= C(3 downto 0);
        --DI/EX
        --ALU_A <= Registers_QA;
        --ALU_B <= Registers_QB; 
        --ALU_Ctrl_Alu <= OP(2 downto 0);
        --Mem/Re
        --Registers_DATA <= ALU_S;
        --Registers_addW <= A(3 downto 0);
        --Registers_W <= '1'; --OP ADD so Write (1) / Read (0)  
    --end if;
end process;

Registers_addA <= 
    --A(3 downto 0) when OP=x"00" else --ADD
    --A(3 downto 0) when OP=x"01" else --MUL
    --A(3 downto 0) when OP=x"02" else --SOU
    --A(3 downto 0) when OP=x"03" else --DIV
    A(3 downto 0) when OP=x"04" else --COP
    --A(3 downto 0) when OP=x"05" else --AFC
    --A(3 downto 0) when OP=x"06" else --LOAD
    --A(3 downto 0) when OP=x"07" else --STORE
    X"0";

Registers_addB <= 
    --A(3 downto 0) when OP=x"00" else --ADD
    --A(3 downto 0) when OP=x"01" else --MUL
    --A(3 downto 0) when OP=x"02" else --SOU
    --A(3 downto 0) when OP=x"03" else --DIV
    --A(3 downto 0) when OP=x"04" else --COP
    --A(3 downto 0) when OP=x"05" else --AFC
    --A(3 downto 0) when OP=x"06" else --LOAD
    --A(3 downto 0) when OP=x"07" else --STORE
    X"0";
    
Registers_addW <= 
    --A(3 downto 0) when OP=x"00" else --ADD
    --A(3 downto 0) when OP=x"01" else --MUL
    --A(3 downto 0) when OP=x"02" else --SOU
    --A(3 downto 0) when OP=x"03" else --DIV
    --A(3 downto 0) when OP=x"04" else --COP
    A(3 downto 0) when OP=x"05" else --AFC
    --A(3 downto 0) when OP=x"06" else --LOAD
    --A(3 downto 0) when OP=x"07" else --STORE
    X"0";
    
Registers_W <= 
    '1' when OP=x"00" else --ADD
    '1' when OP=x"01" else --MUL
    '1' when OP=x"02" else --SOU
    '1' when OP=x"03" else --DIV
    '1' when OP=x"04" else --COP
    '1' when OP=x"05" else --AFC
    '0' when OP=x"06" else --LOAD
    '0' when OP=x"07" else --STORE
    '0';
        
Registers_DATA <= 
    ALU_S when OP=x"00" else --ADD
    ALU_S when OP=x"01" else --MUL
    ALU_S when OP=x"02" else --SOU
    ALU_S when OP=x"03" else --DIV
    ALU_S when OP=x"04" else --COP
    B when OP=x"05" else --AFC
    ALU_S when OP=x"06" else --LOAD
    ALU_S when OP=x"07" else --STORE
    X"00";
    
ALU_Ctrl_Alu <= 
    OP(2 downto 0) when OP=x"00" else --ADD
    OP(2 downto 0) when OP=x"01" else --MUL
    OP(2 downto 0) when OP=x"02" else --SOU
    OP(2 downto 0) when OP=x"03" else --DIV
    --OP when OP=x"04" else --COP
    --OP when OP=x"05" else --AFC
    --OP when OP=x"06" else --LOAD
    --OP when OP=x"07" else --STORE
    "000";
    
ALU_A <= 
    Registers_QA when OP=x"00" else --ADD
    Registers_QA when OP=x"01" else --MUL
    Registers_QA when OP=x"02" else --SOU
    Registers_QA when OP=x"03" else --DIV
    Registers_QA when OP=x"04" else --COP
    --Registers_QA when OP=x"05" else --AFC
    Registers_QA when OP=x"06" else --LOAD
    Registers_QA when OP=x"07" else --STORE
    X"00";
    
ALU_B <= 
    Registers_QB when OP=x"00" else --ADD
    Registers_QB when OP=x"01" else --MUL
    Registers_QB when OP=x"02" else --SOU
    Registers_QB when OP=x"03" else --DIV
    --Registers_QB when OP=x"04" else --COP
    --Registers_QB when OP=x"05" else --AFC
    --Registers_QB when OP=x"06" else --LOAD
    --Registers_QB when OP=x"07" else --STORE
    X"00";
    
A_Test <= A;
OP_Test <= OP;
B_Test <= B;
C_Test <= C;

end Behavioral;
