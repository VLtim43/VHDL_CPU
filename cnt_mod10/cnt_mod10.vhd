LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY cnt_mod10 IS
    PORT (
        nrst : IN STD_LOGIC; -- reset
        clk : IN STD_LOGIC; -- clock
        cnt_en : IN STD_LOGIC; -- enable count
        dir : IN STD_LOGIC; -- direction

        q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- output
        tc : OUT STD_LOGIC -- final signal
    );
END ENTITY;

ARCHITECTURE rtl OF cnt_mod10 IS
    SIGNAL count : UNSIGNED(3 DOWNTO 0) := (OTHERS => '0');
BEGIN

    PROCESS (clk, nrst)
    BEGIN
        IF nrst = '0' THEN
            count <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF cnt_en = '1' THEN
                IF dir = '1' THEN -- 0 to 9 
                    IF count = 9 THEN
                        count <= (OTHERS => '0');
                    ELSE
                        count <= count + 1;
                    END IF;
                ELSE -- 9 to 0
                    IF count = 0 THEN
                        count <= TO_UNSIGNED(9, 4);
                    ELSE
                        count <= count - 1;
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    q <= STD_LOGIC_VECTOR(count);

    tc <= '1' WHEN (cnt_en = '1' AND ((dir = '1' AND count = 9) OR (dir = '0' AND count = 0)))
        ELSE
        '0';

END ARCHITECTURE;
