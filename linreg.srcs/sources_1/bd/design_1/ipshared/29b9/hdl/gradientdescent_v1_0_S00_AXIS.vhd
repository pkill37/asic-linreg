library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity gradientdescent_v1_0_S00_AXIS is
    generic(
        m: integer;
        n: integer;
        
        -- Do not modify the parameters beyond this line
        -- AXI4Stream sink: Data Width
        C_S_AXIS_TDATA_WIDTH : integer := 32
    );
    port(
        -- Linreg ports
        S_LINREG_THETA  : out vector(n-1 downto 0);
        S_LINREG_VALID  : out std_logic;  
        
        -- AXI4Stream sink: Clock
        S_AXIS_ACLK : in std_logic;
        -- AXI4Stream sink: Reset
        S_AXIS_ARESETN : in std_logic;
        -- Ready to accept data in
        S_AXIS_TREADY : out std_logic;
        -- Data in
        S_AXIS_TDATA : in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
        -- Byte qualifier
        S_AXIS_TSTRB : in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
        -- Indicates boundary of last packet
        S_AXIS_TLAST : in std_logic;
        -- Data is in valid
        S_AXIS_TVALID : in std_logic
    );
end gradientdescent_v1_0_S00_AXIS;

architecture arch_imp of gradientdescent_v1_0_S00_AXIS is
    signal s_X         : matrix(m-1 downto 0, n-1 downto 0);
    signal s_Y         : vector(m-1 downto 0);
    signal s_theta     : vector(n-1 downto 0);
    signal s_theta_out : vector(n-1 downto 0);
    signal s_valid     : std_logic;
    signal s_alpha     : std_logic_vector(WORD_SIZE-1 downto 0);
begin
    process(S_AXIS_ACLK)
    begin
        if (rising_edge (S_AXIS_ACLK)) then
            if (S_AXIS_ARESETN = '0') then
                s_X     <= (others => (others => X"00000000"));
                s_Y     <= (others => X"00000000");
                s_theta <= (others => X"00000000");
                s_valid <= '0';
                s_alpha <= X"00000000";
            elsif (S_AXIS_TVALID = '1') then
                -- Reset instruction
                if (S_AXIS_TDATA(31 downto 29) = "100") then
                    s_X     <= (others => (others => X"00000000"));
                    s_Y     <= (others => X"00000000");
                    s_theta <= (others => X"00000000");
                    s_valid <= '0';
                    s_alpha <= X"00000000";
                
                -- Store X matrix element instruction
                elsif (S_AXIS_TDATA(31 downto 29) = "000") then
                    s_X(to_integer(unsigned(S_AXIS_TDATA(28 downto 26))), to_integer(unsigned(S_AXIS_TDATA(25 downto 23)))) <= std_logic_vector(resize(signed(S_AXIS_TDATA(22 downto 0)), 32));
                    s_valid <= '0';

                -- Store Y vector element instruction
                elsif (S_AXIS_TDATA(31 downto 29) = "001") then
                    s_Y(to_integer(unsigned(S_AXIS_TDATA(28 downto 26)))) <= std_logic_vector(resize(signed(S_AXIS_TDATA(25 downto 0)), 32));
                    s_valid <= '0';

                -- Store theta vector element instruction
                elsif (S_AXIS_TDATA(31 downto 29) = "010") then
                    s_theta(to_integer(unsigned(S_AXIS_TDATA(28 downto 26)))) <= std_logic_vector(resize(signed(S_AXIS_TDATA(25 downto 0)), 32));
                    s_valid <= '0';
                    
                -- Store alpha instruction
                elsif (S_AXIS_TDATA(31 downto 29) = "101") then
                    s_alpha <= std_logic_vector(resize(unsigned(S_AXIS_TDATA(28 downto 0)), 32));
                    s_valid <= '0';
                    
                -- Compute iteration of gradient descent
                elsif (S_AXIS_TDATA(31 downto 29) = "011") then
                    if (to_integer(unsigned(S_AXIS_TDATA(28 downto 0))) > 1) then
                        s_theta <= s_theta_out;
                    end if;
                    s_valid <= '1';
                end if;
            end if;
        end if;
    end process;

    mini_batch_gradient_descent: entity work.MiniBatchGradientDescent(Behavioral)
    generic map(
        m => m,
        n => n
    )
    port map(
        X         => s_X,
        Y         => s_Y,
        theta     => s_theta,
        alpha     => s_alpha,
        theta_new => s_theta_out
    );

    S_AXIS_TREADY <= '1';
    S_LINREG_VALID <= s_valid;
    S_LINREG_THETA <= s_theta_out;
end arch_imp;