library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Types.all;


entity MiniBatchGradientDescentTest is
end MiniBatchGradientDescentTest;

architecture Stimulus of MiniBatchGradientDescentTest is
    signal tb_X : matrix(9 downto 0, 1 downto 0) := (
        (X"00000800", X"000012B8"),
        (X"00000800", X"00001E28"),
        (X"00000800", X"00002451"),
        (X"00000800", X"00002E7A"),
        (X"00000800", X"000030F5"),
        (X"00000800", X"00002814"),
        (X"00000800", X"000018B8"),
        (X"00000800", X"0000211E"),
        (X"00000800", X"00000BD7"),
        (X"00000800", X"00001199")
    );
    
    signal tb_Y : vector(9 downto 0) := (
        (X"000020F5"),
        (X"00001851"),
        (X"00001985"),
        (X"000032CC"),
        (X"000025D7"),
        (X"00003628"),
        (X"00000B1E"),
        (X"00002E14"),
        (X"00001A28"),
        (X"0000168F")
    );
    
    signal tb_theta : vector(1 downto 0) := (
        X"00000814",
        X"00001028"
    );
    
    signal tb_alpha : std_logic_vector(WORD_SIZE-1 downto 0) := X"000000E1";
--    signal tb_X : matrix(2 downto 0, 1 downto 0) := (
--        (X"00000001", X"00000001"),
--        (X"00000001", X"00000002"),
--        (X"00000001", X"00000003")
--    );
    
--    signal tb_Y : vector(2 downto 0) := (
--        (X"00000001"),
--        (X"00000002"),
--        (X"00000003")
--    );
    
--    signal tb_theta : vector(1 downto 0) := (
--        X"00000001",
--        X"00000002"
--    );
    
--    signal tb_alpha : std_logic_vector(WORD_SIZE-1 downto 0) := X"00000003";
    
    signal tb_theta_new : vector(1 downto 0);
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