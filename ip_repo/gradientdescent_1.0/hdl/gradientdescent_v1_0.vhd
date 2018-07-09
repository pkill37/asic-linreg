library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity gradientdescent_v1_0 is
	generic (
	    m: integer;
        n: integer;

		-- Parameters of Axi Master Bus Interface M00_AXIS
		C_M00_AXIS_TDATA_WIDTH	: integer	:= 32;
		C_M00_AXIS_START_COUNT	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S00_AXIS
		C_S00_AXIS_TDATA_WIDTH	: integer	:= 32
	);
	port (
		-- Ports of Axi Master Bus Interface M00_AXIS
		m00_axis_aclk	: in std_logic;
		m00_axis_aresetn	: in std_logic;
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
		m00_axis_tstrb	: out std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		m00_axis_tlast	: out std_logic;
		m00_axis_tready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S00_AXIS
		s00_axis_aclk	: in std_logic;
		s00_axis_aresetn	: in std_logic;
		s00_axis_tready	: out std_logic;
		s00_axis_tdata	: in std_logic_vector(C_S00_AXIS_TDATA_WIDTH-1 downto 0);
		s00_axis_tstrb	: in std_logic_vector((C_S00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s00_axis_tlast	: in std_logic;
		s00_axis_tvalid	: in std_logic
	);
end gradientdescent_v1_0;

architecture arch_imp of gradientdescent_v1_0 is
    signal s_theta_new : vector(n-1 downto 0);
    signal s_valid: std_logic;
begin
    -- Instantiation of Axi Bus Interface S00_AXIS
    gradientdescent_v1_0_S00_AXIS_inst : entity work.gradientdescent_v1_0_S00_AXIS(arch_imp)
        generic map (
            m => m,
            n => n,
            C_S_AXIS_TDATA_WIDTH	=> C_S00_AXIS_TDATA_WIDTH
        )
        port map (
            S_AXIS_ACLK	    => s00_axis_aclk,
            S_AXIS_ARESETN	=> s00_axis_aresetn,
            
            S_AXIS_TREADY	=> s00_axis_tready,
            S_AXIS_TDATA	=> s00_axis_tdata,
            S_AXIS_TSTRB	=> s00_axis_tstrb,
            S_AXIS_TLAST	=> s00_axis_tlast,
            S_AXIS_TVALID	=> s00_axis_tvalid,
            
            S_LINREG_THETA  => s_theta_new,
            S_LINREG_VALID  => s_valid
        );
    
    -- Instantiation of Axi Bus Interface M00_AXIS
    gradientdescent_v1_0_M00_AXIS_inst : entity work.gradientdescent_v1_0_M00_AXIS(implementation)
        generic map (
            n => n,
            C_M_AXIS_TDATA_WIDTH => C_M00_AXIS_TDATA_WIDTH,
            C_M_START_COUNT	=> C_M00_AXIS_START_COUNT
        )
        port map (
            M_AXIS_ACLK	    => m00_axis_aclk,
            M_AXIS_ARESETN	=> m00_axis_aresetn,
            
            M_AXIS_TVALID	=> m00_axis_tvalid,
            M_AXIS_TDATA	=> m00_axis_tdata,
            M_AXIS_TSTRB	=> m00_axis_tstrb,
            M_AXIS_TLAST	=> m00_axis_tlast,
            M_AXIS_TREADY	=> m00_axis_tready,
            
            M_LINREG_THETA  => s_theta_new,
            M_LINREG_VALID  => s_valid
        );
end arch_imp;