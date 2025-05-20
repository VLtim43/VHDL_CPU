-- File: wreg.vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Wreg IS
    PORT (
        clk_in : IN STD_LOGIC; -- Clock singal
        nrst : IN STD_LOGIC; -- Low level reset
        wr_en : IN STD_LOGIC; -- Write Enable

        d_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data Input
        w_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- Data Output
    );
END Wreg;

ARCHITECTURE Behavioral OF Wreg IS
    SIGNAL reg : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    PROCESS (clk_in, nrst) -- Process triggers whenever clock changes, or it's reset
    BEGIN
        IF nrst = '0' THEN
            reg <= (OTHERS => '0'); -- If reset = 0, all bits of reg are cleared to 0000000
        ELSIF rising_edge(clk_in) THEN -- Else If the clock is on rising edge
            IF wr_en = '1' THEN -- If writing is enable
                reg <= d_in; -- d_in is loaded into the register
            END IF;
        END IF;
    END PROCESS;

    w_out <= reg;

END Behavioral;
