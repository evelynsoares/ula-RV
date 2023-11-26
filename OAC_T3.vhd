library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity genImm32 is
    port (
        instr : in std_logic_vector(31 downto 0);
        imm32 : out signed(31 downto 0)
    );
end genImm32;

architecture Behavioral of genImm32 is
begin
    process(instr)
    begin
        -- Identificação do formato
        case instr(6 downto 0) is
            when "0110011" =>
                -- R-type
                imm32 <= (others => '0');
            when "0000011" =>
                -- I-type 
                imm32 <= signed(resize(unsigned(instr(31 downto 20)), 32)); 
            when "0100011" =>
                -- S-type
                imm32 <= signed(resize(unsigned(instr(31 downto 25) & instr(11 downto 7)), 32));
            when "1100011" =>
                -- SB-type
                imm32 <= signed(resize(unsigned(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8)), 32));
            when "1101111" =>
                -- UJ-type
                imm32 <= signed(resize(unsigned(instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21)), 32));
            when "0110111" =>
                -- U-type
                imm32 <= signed(resize(unsigned(instr(31 downto 12)), 32));
            when others =>
                -- I_type*
                imm32 <= signed(resize(unsigned(instr(11 downto 7) & "00000" & instr(31 downto 5)), 32));
        end case;
    end process;
end Behavioral;
