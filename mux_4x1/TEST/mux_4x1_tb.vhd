-- File: mux_4x1_tb.vhd
-- __________________________
-- |   S  |     I   |   O   |
-- |------|---------|-------|
-- |  00  |  0000   |       |
-- |  00  |  0001   |       |
-- |  01  |  0000   |       |
-- |  01  |  0010   |       |
-- |  10  |  0000   |       |
-- |  10  |  0100   |       |
-- |  11  |  0000   |       |
-- |  11  |  1000   |       |
-- --------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux_4x1_tb IS END;

ARCHITECTURE behavior OF mux_4x1_tb IS

    COMPONENT mux_4x1
        PORT (
            I : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            O : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL I_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL S_tb : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL O_tb : STD_LOGIC;

BEGIN

    UUT : mux_4x1
    PORT MAP(
        I => I_tb,
        S => S_tb,
        O => O_tb
    );
    stim_proc : PROCESS
    BEGIN
        -- Case 1: I = "0000", S = "00"
        I_tb <= "0000";
        S_tb <= "00";
        WAIT FOR 5 ns;

        -- Case 2: I = "0001", S = "00"
        I_tb <= "0001";
        S_tb <= "00";
        WAIT FOR 5 ns;

        -- Case 3: I = "0000", S = "01"
        I_tb <= "0000";
        S_tb <= "01";
        WAIT FOR 5 ns;

        -- Case 4: I = "0010", S = "01"
        I_tb <= "0010";
        S_tb <= "01";
        WAIT FOR 5 ns;

        -- Case 5: I = "0000", S = "10"
        I_tb <= "0000";
        S_tb <= "10";
        WAIT FOR 5 ns;

        -- Case 6: I = "0100", S = "10"
        I_tb <= "0100";
        S_tb <= "10";
        WAIT FOR 5 ns;

        -- Case 7: I = "0000", S = "11"
        I_tb <= "0000";
        S_tb <= "11";
        WAIT FOR 5 ns;

        -- Case 8: I = "1000", S = "11"
        I_tb <= "1000";
        S_tb <= "11";
        WAIT FOR 5 ns;

        WAIT;

    END PROCESS stim_proc;

END ARCHITECTURE behavior;
