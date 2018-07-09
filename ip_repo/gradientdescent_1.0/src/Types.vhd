library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

package Types is
    type vector is array (integer range <>) of integer;
    type matrix is array (integer range<>, integer range<>) of integer;
    
    function element_multiply(a: integer; b: integer) return integer;
end package;

package body Types is
    function element_multiply(a: integer; b: integer) return integer is variable c : integer;
    begin
        c := to_integer(shift_right(to_signed(a, 32)*to_signed(b, 32), 11));
        return c;
    end element_multiply;
end package body;