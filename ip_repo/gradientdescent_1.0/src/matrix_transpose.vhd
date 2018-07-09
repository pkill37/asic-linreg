library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Types.all;

entity matrix_transpose is
    generic(
        m: integer;
        n: integer
    );
    port(
        a: in matrix(m-1 downto 0, n-1 downto 0);
        c: out matrix(n-1 downto 0, m-1 downto 0)
    );
end matrix_transpose;

architecture Behavioral of matrix_transpose is
    signal s_c : matrix(n-1 downto 0, m-1 downto 0) := (others => (others => 0));
begin
    iii: for i in 0 to m-1 generate
        jjj: for j in 0 to n-1 generate
            s_c(j,i) <= a(i,j);
        end generate;
    end generate;

    c <= s_c;
end Behavioral;
