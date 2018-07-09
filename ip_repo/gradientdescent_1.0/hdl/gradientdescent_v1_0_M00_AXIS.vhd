library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity gradientdescent_v1_0_M00_AXIS is
    generic (
        n : integer;
        
        -- Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
        C_M_AXIS_TDATA_WIDTH	: integer	:= 32;
        -- Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
        C_M_START_COUNT	: integer	:= 32
    );
    port (
        -- Linreg ports
        M_LINREG_THETA : in vector(n-1 downto 0);
        M_LINREG_VALID : in std_logic;
        
        -- Global ports
        M_AXIS_ACLK	    : in std_logic;
        M_AXIS_ARESETN	: in std_logic;
        
        -- Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
        M_AXIS_TVALID	: out std_logic;
        -- TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
        M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
        -- TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
        M_AXIS_TSTRB	: out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
        -- TLAST indicates the boundary of a packet.
        M_AXIS_TLAST	: out std_logic;
        -- TREADY indicates that the slave can accept a transfer in the current cycle.
        M_AXIS_TREADY	: in std_logic
    );
end gradientdescent_v1_0_M00_AXIS;

architecture implementation of gradientdescent_v1_0_M00_AXIS is
    signal s_data  : std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
    signal s_valid : std_logic;
    signal it      : integer := 0;
begin
    process(M_AXIS_ACLK)
    begin
        if (rising_edge (M_AXIS_ACLK)) then
            if (M_AXIS_TREADY = '1' and M_LINREG_VALID = '1') then
                s_data <= std_logic_vector(to_signed(M_LINREG_THETA(it), C_M_AXIS_TDATA_WIDTH));
                s_valid <= '1';
                
                if (s_valid = '1') then
                    it <= (it + 1) rem n;
                end if;
            else
                s_valid <= '0';
            end if;
        end if;
    end process;
    
    M_AXIS_TVALID <= s_valid;
    M_AXIS_TLAST <= '0';
    M_AXIS_TSTRB <= (others => '1');
    M_AXIS_TDATA <= s_data;
end implementation;