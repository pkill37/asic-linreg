library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.Types.all;

entity vector_multiply_by_scalar is
    generic(
        m: integer
    );
    port(
        a: in vector(m-1 downto 0);
        scalar: in integer;
        c: out vector(m-1 downto 0)
    );
end vector_multiply_by_scalar;

architecture Behavioral of vector_multiply_by_scalar is
    signal s_c : vector(m-1 downto 0) := (others => 0);
begin
    iii: for i in 0 to m-1 generate
        s_c(i) <= element_multiply(a(i), scalar);
    end generate;
    
    c <= s_c;
end Behavioral;