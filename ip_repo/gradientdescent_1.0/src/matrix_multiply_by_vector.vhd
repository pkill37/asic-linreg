library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.Types.all;

entity matrix_multiply_by_vector is
    generic(
        m: integer;
        n: integer
    );
    port(
        a: in matrix(m-1 downto 0, n-1 downto 0);
        b: in vector(n-1 downto 0);
        c: out vector(m-1 downto 0)
    );
end matrix_multiply_by_vector;

architecture Behavioral of matrix_multiply_by_vector is
    signal s_c : vector(m-1 downto 0) := (others => 0);
begin
    mult: process(a, b)
        variable s_tmp : vector(m-1 downto 0);
    begin
        s_tmp := (others => 0);
        
        for i in 0 to m-1 loop
            for j in 0 to n-1 loop
                s_tmp(i) := s_tmp(i) + element_multiply(a(i,j), b(j));
            end loop;
        end loop;
        
        s_c <= s_tmp;
    end process mult;
    
    c <= s_c;
end Behavioral;