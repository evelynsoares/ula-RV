library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  
entity ulaRV is
    generic (WSIZE: natural := 32);
    port (
        opcode: in  std_logic_vector(3 downto 0);
        A, B:   in  std_logic_vector(WSIZE-1 downto 0);
        Z:      out std_logic_vector(WSIZE-1 downto 0);
        zero:   out std_logic
    );
end ulaRV;

architecture behavioral of ulaRV is
begin
    process (A, B, opcode) 
    begin
    zero <= '0';
        case opcode is
        	--ADD
            when "0000" => Z <= std_logic_vector(signed(A) + signed(B));
            --SUB
            when "0001" => Z <= std_logic_vector(signed(A) - signed(B));
            --AND
            when "0010" => Z <= (A and B);
            --OR
            when "0011" => Z <= (A or B);
            --XOR
            when "0100" => Z <= (A xor B);
            --SLL
            when "0101" => Z <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
            --SRL
            when "0110" => Z <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));
            --SRA
            when "0111" => Z <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));
            --SLT
            when "1000" =>
				if(signed(A) < signed(B)) then
					Z <= x"00000001";
				else
					Z <= x"00000000";
				end if;
            --SLTU
            when "1001" =>
				if(unsigned(A) < unsigned(B)) then
					Z <= x"00000001";
				else
					Z <= x"00000000";
				end if;
			--SGE
           	when "1010" =>		
				if(signed(A) >=signed(B)) then
					Z <= x"00000001";
				else
					Z <= x"00000000";
				end if;
			--SGEU
            when "1011" =>		
				if(unsigned(A) >= unsigned(B)) then
					Z <= x"00000001";
				else
					Z <= x"00000000";
				end if;
            --SEQ
            when "1100" =>		
				if(signed(A) = signed(B)) then
					Z <= x"00000001";
				else
					Z <= x"00000000";
				end if;
            --SNE
            when "1101" =>		
				if(signed(A) /= signed(B)) then
					Z <= x"00000001";
				else
					Z <= x"00000000";
				end if;
            when others => Z <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
        end case;
    end process;
end behavioral;