-- file: port_io.vhd
-- ____________________________________________________________
-- |    abus         | wr_en  | rd_en  |    operação         |
-- |-----------------|--------|--------|---------------------|
-- | base_addr       |   1    |   0    | write on port_reg   |
-- | base_addr       |   0    |   1    | read from port_reg  |
-- | base_addr + 1   |   1    |   0    | write on dir_reg    |
-- | base_addr + 1   |   0    |   1    | read from dir_reg   |
-- ------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY port_io IS
    GENERIC (
        base_addr : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0')
    );
    PORT (
        clk_in : IN STD_LOGIC; -- Clock Signal
        nrst : IN STD_LOGIC; -- Reset

        abus : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Address bus input
        dbus : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data bus in/out

        wr_en : IN STD_LOGIC; -- Write enable
        rd_en : IN STD_LOGIC; -- Read enable

        port_io : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- Bidirectional 8-bit I/O port
    );
END ENTITY port_io;

ARCHITECTURE rtl OF port_io IS
    SIGNAL port_reg : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL dir_reg : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL latch : STD_LOGIC_VECTOR(7 DOWNTO 0);
    -- base_addr + 1
    CONSTANT base_addr_plus_one : STD_LOGIC_VECTOR(7 DOWNTO 0) :=
    STD_LOGIC_VECTOR(unsigned(base_addr) + 1);
BEGIN
    gen_port_dir : FOR i IN 0 TO 7 GENERATE
        port_io(i) <= port_reg(i) WHEN dir_reg(i) = '1' ELSE
        'Z';
    END GENERATE;

    -- Synchronous writes to port_reg and dir_reg
    PROCESS (clk_in, nrst)
    BEGIN
        IF nrst = '0' THEN
            port_reg <= (OTHERS => '0');
            dir_reg <= (OTHERS => '0');
            latch <= (OTHERS => '0');
        ELSIF rising_edge(clk_in) THEN
            IF (wr_en = '1') THEN
                IF (abus = base_addr) THEN
                    port_reg <= dbus;
                ELSIF (abus = base_addr_plus_one) THEN
                    dir_reg <= dbus;
                END IF;
            END IF;

            IF (rd_en = '1' AND abus = base_addr) THEN
                FOR i IN 0 TO 7 LOOP
                    IF dir_reg(i) = '0' THEN
                        latch(i) <= port_io(i); -- Capture input
                    ELSE
                        latch(i) <= port_reg(i); -- Output 
                    END IF;
                END LOOP;
            END IF;
        END IF;
    END PROCESS;

    -- Combinational read
    dbus <= latch
        WHEN (rd_en = '1' AND abus = base_addr) ELSE
        dir_reg
        WHEN (rd_en = '1' AND abus = base_addr_plus_one) ELSE
        (OTHERS => 'Z');

END ARCHITECTURE rtl;
