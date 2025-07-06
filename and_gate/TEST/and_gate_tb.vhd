-- File: and_gate_tb.vhd
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE std.textio.ALL;

ENTITY and_gate_tb IS END;

ARCHITECTURE behavior OF and_gate_tb IS

    COMPONENT and_gate
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            O : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL A_tb : STD_LOGIC := '0';
    SIGNAL B_tb : STD_LOGIC := '0';
    SIGNAL O_tb : STD_LOGIC;

BEGIN

    UUT : and_gate
    PORT MAP(
        A => A_tb,
        B => B_tb,
        O => O_tb
    );

    stim_proc : PROCESS
    BEGIN
        -- Test 00
        A_tb <= '0';
        B_tb <= '0';
        WAIT FOR 10 ns;

        -- Test 01
        A_tb <= '0';
        B_tb <= '1';
        WAIT FOR 10 ns;

        -- Test 10
        A_tb <= '1';
        B_tb <= '0';
        WAIT FOR 10 ns;

        -- Test 11
        A_tb <= '1';
        B_tb <= '1';
        WAIT FOR 10 ns;

        WAIT;
    END PROCESS;

END ARCHITECTURE behavior;
