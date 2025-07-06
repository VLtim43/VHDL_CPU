
-- File: dec_2x4_tb.vhd
-- _____________________________
-- |  E  |  S1 |  S0 |   Y      |
-- |-----|-----|-----|----------|
-- |  0  |  X  |  X  |   0000   |
-- |  0  |  X  |  X  |   0000   |
-- |  0  |  X  |  X  |   0000   |
-- |  0  |  X  |  X  |   0000   |
-- |  1  |  0  |  0  |   0001   |
-- |  1  |  0  |  1  |   0010   |
-- |  1  |  1  |  0  |   0100   |
-- |  1  |  1  |  1  |   1000   |
-- -----------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY dec_2x4_tb IS END;

ARCHITECTURE behavior OF dec_2x4_tb IS

    COMPONENT dec_2x4
        PORT (
            S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            E : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL S_tb : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
    SIGNAL E_tb : STD_LOGIC := '0';
    SIGNAL Y_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    UUT : dec_2x4
    PORT MAP(
        S => S_tb,
        E => E_tb,
        Y => Y_tb
    );

    stim_proc : PROCESS
    BEGIN
        -- Test E=0, S=00
        E_tb <= '0';
        S_tb <= "00";
        WAIT FOR 5 ns;

        -- Test E=0, S=01
        E_tb <= '0';
        S_tb <= "01";
        WAIT FOR 5 ns;

        -- Test E=0, S=10
        E_tb <= '0';
        S_tb <= "10";
        WAIT FOR 5 ns;

        -- Test E=0, S=11
        E_tb <= '0';
        S_tb <= "11";
        WAIT FOR 5 ns;

        -- Test E=1, S=00
        E_tb <= '1';
        S_tb <= "00";
        WAIT FOR 5 ns;

        -- Test E=1, S=01
        E_tb <= '1';
        S_tb <= "01";
        WAIT FOR 5 ns;

        -- Test E=1, S=10
        E_tb <= '1';
        S_tb <= "10";
        WAIT FOR 5 ns;

        -- Test E=1, S=11
        E_tb <= '1';
        S_tb <= "11";
        WAIT;

    END PROCESS stim_proc;

END ARCHITECTURE behavior;
