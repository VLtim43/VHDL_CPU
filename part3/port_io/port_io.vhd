-- file: port_io.vhd
-- ____________________________________________________________
-- |    abus       | wr_en  | rd_en  |        operação        |
-- |---------------|--------|--------|------------------------|
-- | base_addr     |   1    |   0    | write on port_reg      |
-- | base_addr     |   0    |   1    | read on latch          |
-- | base_addr + 1 |   1    |   0    | write on dir_reg       |
-- | base_addr + 1 |   0    |   1    | read on dir_reg        |
-- ------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY port_io IS
    GENERIC (
        base_addr : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')
    );
    PORT (
        clk_in  : IN  STD_LOGIC;
        nrst    : IN  STD_LOGIC;

        abus    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        dbus    : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        wr_en   : IN  STD_LOGIC;
        rd_en   : IN  STD_LOGIC;

        port_reg_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)  
    );
END ENTITY port_io;

ARCHITECTURE rtl OF port_io IS
    SIGNAL port_reg : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
BEGIN

    PROCESS (clk_in, nrst)
    BEGIN
        IF nrst = '0' THEN
            port_reg <= (OTHERS => '0');
        ELSIF rising_edge(clk_in) THEN
            IF wr_en = '1' AND abus = base_addr THEN
                port_reg <= dbus;
            END IF;
        END IF;
    END PROCESS;

    port_reg_out <= port_reg;

END ARCHITECTURE rtl;
