library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.Types.all;

entity vector_subtract is
    generic(
        m: integer
    );
    port(
        a: in vector(m-1 downto 0);
        b: in vector(m-1 downto 0);
        c: out vector(m-1 downto 0)
    );
end vector_subtract;

architecture Behavioral of vector_subtract is
    signal s_c : vector(m-1 downto 0) := (others => X"00000000");
begin
    iii: for i in 0 to m-1 generate
        s_c(i) <= element_subtract(a(i), b(i));
    end generate;
    
    c <= s_c;
end Behavioral;
