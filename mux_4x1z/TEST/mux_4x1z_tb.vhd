-- File: mux_4x1z_tb.vhd
-- _________________________________
-- |  E   |   S  |     I   |   O   |
-- |------|------|---------|-------|
-- |  0   |  00  |  XXXX   |   Z   |
-- |  0   |  01  |  XXXX   |   Z   |
-- |  1   |  00  |  0000   |   0   |
-- |  1   |  00  |  0001   |   1   |
-- |  1   |  01  |  0000   |   0   |
-- |  1   |  01  |  0010   |   1   |
-- |  1   |  10  |  0000   |   0   |
-- |  1   |  10  |  0100   |   1   |
-- |  1   |  11  |  0000   |   0   |
-- |  1   |  11  |  1000   |   1   |
-- --------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux_4x1z_tb IS END;

ARCHITECTURE behavior OF mux_4x1z_tb IS

    COMPONENT mux_4x1z
        PORT (
            I : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            E : IN STD_LOGIC;
            O : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL I_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL S_tb : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL E_tb : STD_LOGIC;
    SIGNAL O_tb : STD_LOGIC;

BEGIN

    UUT : mux_4x1z
    PORT MAP(
        I => I_tb,
        S => S_tb,
        E => E_tb,
        O => O_tb
    );

    stim_proc : PROCESS
    BEGIN
        -- Case 1: E = '0', S = "00", I = "XXXX"
        E_tb <= '0';
        S_tb <= "00";
        I_tb <= "ZZZZ";
        WAIT FOR 5 ns;

        -- Case 2: E = '0', S = "01", I = "XXXX"
        E_tb <= '0';
        S_tb <= "01";
        I_tb <= "ZZZZ";
        WAIT FOR 5 ns;

        -- Case 3: E = '1', S = "00", I = "0000"
        E_tb <= '1';
        S_tb <= "00";
        I_tb <= "0000";
        WAIT FOR 5 ns;

        -- Case 4: E = '1', S = "00", I = "0001"
        E_tb <= '1';
        S_tb <= "00";
        I_tb <= "0001";
        WAIT FOR 5 ns;

        -- Case 5: E = '1', S = "01", I = "0000"
        E_tb <= '1';
        S_tb <= "01";
        I_tb <= "0000";
        WAIT FOR 5 ns;

        -- Case 6: E = '1', S = "01", I = "0010"
        E_tb <= '1';
        S_tb <= "01";
        I_tb <= "0010";
        WAIT FOR 5 ns;

        -- Case 7: E = '1', S = "10", I = "0000"
        E_tb <= '1';
        S_tb <= "10";
        I_tb <= "0000";
        WAIT FOR 5 ns;

        -- Case 8: E = '1', S = "10", I = "0100"
        E_tb <= '1';
        S_tb <= "10";
        I_tb <= "0100";
        WAIT FOR 5 ns;

        -- Case 9: E = '1', S = "11", I = "0000"
        E_tb <= '1';
        S_tb <= "11";
        I_tb <= "0000";
        WAIT FOR 5 ns;

        -- Case 10: E = '1', S = "11", I = "1000"
        E_tb <= '1';
        S_tb <= "11";
        I_tb <= "1000";
        WAIT FOR 5 ns;

        WAIT;
    END PROCESS stim_proc;

END ARCHITECTURE behavior;
