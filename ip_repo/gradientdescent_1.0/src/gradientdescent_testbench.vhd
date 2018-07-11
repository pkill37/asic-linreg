library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Types.all;


entity MiniBatchGradientDescentTest is
end MiniBatchGradientDescentTest;

architecture Stimulus of MiniBatchGradientDescentTest is
    signal tb_X : matrix(5 downto 0, 1 downto 0) := (
        (X"00000800", X"000012B8"),
        (X"00000800", X"00001E28"),
        (X"00000800", X"00002451"),
        (X"00000800", X"00002E7A"),
        (X"00000800", X"000030F5"),
        (X"00000800", X"00002814")
    );
    
    signal tb_Y : vector(5 downto 0) := (
        (X"000020F5"),
        (X"00001851"),
        (X"00001985"),
        (X"000032CC"),
        (X"000025D7"),
        (X"00003628")
    );
    
    signal tb_theta : vector(1 downto 0) := (
        X"00000814",
        X"00001028"
    );
    
    signal tb_alpha : std_logic_vector(WORD_SIZE-1 downto 0) := X"00000014";
    
    signal tb_theta_new : vector(1 downto 0);
begin
    uut: entity work.MiniBatchGradientDescent(Behavioral)
        generic map(
            m => 6,
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