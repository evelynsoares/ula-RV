library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_genImm32 is
end tb_genImm32;

architecture sim of tb_genImm32 is
    -- DUT (Design Under Test) Component Declaration
    component genImm32
        port (
            instr : in std_logic_vector(31 downto 0);
            imm32 : out signed(31 downto 0)
        );
    end component;

    -- Signals for Testbench
    signal tb_instr : std_logic_vector(31 downto 0);
    signal tb_imm32 : signed(31 downto 0);

begin
    -- Instantiate DUT
    uut: genImm32
        port map (
            instr => tb_instr,
            imm32 => tb_imm32
        );

    -- Testbench Process
    process
    begin
        tb_instr <= "00000000000000000000001010110011";  
        wait for 10 ns;
        assert tb_imm32 = (others => '0') report "Test failed for R-type!" severity error;
        tb_instr <= "00000001000000000010001010000011"; 
        wait for 10 ns;
        assert tb_imm32 = "00000000000000000000000000000011" report "Test failed for I-I-type0!" severity error;
        tb_instr <= "11111001110000000000001100010011"; 
        wait for 10 ns;
        assert tb_imm32 = (others => '0') report "Test failed for I-type1!" severity error;
        tb_instr <= "11111111111100101100001010010011"; 
        wait for 10 ns;
        assert tb_imm32 = (others => '0') report "Test failed for I-type1!" severity error;
        tb_instr <= "00010110001000000000001100010011"; 
        wait for 10 ns;
        assert tb_imm32 = (others => '0') report "Test failed for I-type1!" severity error;
        tb_instr <= "00000001100000000000000001100111";  
        wait for 10 ns;
        assert tb_imm32 = (others => '0') report "Test failed for I-type2!" severity error;
        tb_instr <= "01000000101000111101001100010011";  
        wait for 10 ns;
        assert tb_imm32 = (others => '0') report "Test failed for I-type*!" severity error;
        tb_instr <= "00000000000000000010010000110111"; 
        wait for 10 ns;
        assert tb_imm32 = (others => '0') report "Test failed for U-type!" severity error;
        tb_instr <= "00000010010101000010111000100011"; 
        wait for 10 ns;
        assert tb_imm32 = (others => '0') report "Test failed for S-type!" severity error;
        tb_instr <= "11111110010100101001000011100011"; 
        wait for 10 ns;
        assert tb_imm32 = (others => '0') report "Test failed for SB-type!" severity error;
        tb_instr <= "00000000110000000000000011101111"; 
        wait for 10 ns;
        assert tb_imm32 = (others => '0') report "Test failed for UJ-type!" severity error;
        wait;
    end process;

end sim;
