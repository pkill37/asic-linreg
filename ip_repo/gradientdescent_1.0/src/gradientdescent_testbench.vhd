library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Types.all;


entity MiniBatchGradientDescentTest is
end MiniBatchGradientDescentTest;

architecture Stimulus of MiniBatchGradientDescentTest is
    signal tb_X : matrix(9 downto 0, 1 downto 0) := (
        (2048, 4792),
        (2048, 7720),
        (2048, 9297),
        (2048, 11898),
        (2048, 12533),
        (2048, 10260),
        (2048, 6328),
        (2048, 8478),
        (2048, 3031),
        (2048, 4505)
    );

    signal tb_Y : vector(9 downto 0) := (
        8437,
        6225,
        6533,
        13004,
        9687,
        13864,
        2846,
        11796,
        6696,
        5775
    );
    
    signal tb_theta : vector(1 downto 0) := (2068, 4136);
--    signal tb_theta : vector(1 downto 0) := (1048, -446);
--    signal tb_theta : vector(1 downto 0) := (2032, 3776);
    
    signal tb_alpha : integer := 225;
    
    signal tb_theta_new : vector(1 downto 0);

--    signal tb_X : matrix(2 downto 0, 2 downto 0) := (
--        (2048, 4096, 10240),
--        (2048, 6144, 12288),
--        (2048, 8192, 14336)
--    );

--    signal tb_Y : vector(2 downto 0) := (
--        0,
--        2048,
--        4096
--    );
    
--    signal tb_theta : vector(2 downto 0) := (2048, 4096, 4096);
--    signal tb_theta : vector(2 downto 0) := (-108544, -339968, -671744);
--    signal tb_theta : vector(2 downto 0) := (15374336, 48136192, 94253056);
--    signal tb_alpha : integer := 6144;
    
--    signal tb_theta_new : vector(2 downtso 0);
begin
    uut: entity work.MiniBatchGradientDescent(Behavioral)
        generic map(
            m => 10,
            n => 2
        )
        port map(
            X => tb_X,
            Y => tb_Y,
            alpha => tb_alpha,
            theta => tb_theta,
            theta_new => tb_theta_new
        );
end Stimulus;