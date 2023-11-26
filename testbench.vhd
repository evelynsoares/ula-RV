LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
 
entity tb_ulaRV is
end tb_ulaRV; 

architecture testbench of tb_ulaRV is
--sinais
signal A: std_logic_vector(31 downto 0);
signal B: std_logic_vector(31 downto 0);
signal Z: std_logic_vector(31 downto 0);
signal zero: std_logic;
signal opcode: std_logic_vector(3 downto 0);

--componentes
component ulaRV is
	generic(WSIZE: natural := 32);
	port(
		opcode: in  std_logic_vector(3 downto 0);
		A, B:	in  std_logic_vector(WSIZE-1 downto 0);
		Z:		out std_logic_vector(WSIZE-1 downto 0);
		zero:	out std_logic);
end component;

begin
  inst_ula: ulaRV port map(A => A, B => B, Z => Z, opcode => opcode, zero => zero);

  process
  begin
 	--ADD
    A <= x"00000002";
    B <= x"00000002";
    opcode <= "0000";
    wait for 1 ns;
    --SUB
    A <= x"00000002";
    B <= x"00000005";
    opcode <= "0001";
    wait for 1 ns;
    --AND
    A <= x"00001111";
    B <= x"00110011";
    opcode <= "0010";
    wait for 1 ns;  
    --OR
    A <= x"00001111";
    B <= x"11110000";
    opcode <= "0011";
    wait for 1 ns;
    --XOR
    A <= x"00001111";
    B <= x"00000101";
    opcode <= "0100";
    wait for 1 ns;
    --SLL
    A <= x"00000001";
    B <= x"00000003";
    opcode <= "0101";
    wait for 1 ns;
    --SRL
    A <= x"0000ffff";
    B <= x"00000002";
    opcode <= "0110";
    wait for 1 ns;
    --SRA
    A <= x"ffff8000";
    B <= x"00000001";
    opcode <= "0111";
    wait for 1 ns;
    --SLT
    A <= x"fffffffe";
    B <= x"0000000f";
    opcode <= "1000";
    wait for 1 ns;
    --SLTU
    A <= x"00110011";
    B <= x"11000011";
    opcode <= "1001";
    wait for 1 ns;
    --SGE
    A <= x"00000001";
    B <= x"00000001";
    opcode <= "1010";
    wait for 1 ns;
    --SGEU
    A <= x"00110011";
    B <= x"11000011";
    opcode <= "1011";
    wait for 1 ns;
    --SEQ
    A <= x"00001111";
    B <= x"00001111";
    opcode <= "1100";
    wait for 1 ns;
    --SNE
    A <= x"ffffffff";
    B <= x"00000010";
    opcode <= "1101";
    wait for 1 ns;
  
    wait;
  end process;
end testbench;