-- File: ALU_4x2c_tb.vhd
--  _________________________________________________________________
--  |   A   |   B   | S | Extended (5?bit) |   O   | C (carry/borrow)|
--  |-------|-------|---|------------------|-------|-----------------|
--  | 0011  | 0101  | 0 | 01000            | 1000  | 0               |
--  | 1100  | 1010  | 0 | 10110            | 0110  | 1               |
--  | 0001  | 0010  | 0 | 00011            | 0011  | 0               |
--  | 1111  | 0001  | 0 | 10000            | 0000  | 1               |
--  | 0101  | 0011  | 1 | 00010            | 0010  | 0               |
--  | 0010  | 0110  | 1 | 11100            | 1110  | 1               |
--  | 1111  | 0001  | 1 | 01110            | 1110  | 0               |
--  | 0000  | 0001  | 1 | 11111            | 1111  | 1               |
--  ------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALU_4x2c_tb IS
END ENTITY;

ARCHITECTURE behavior OF ALU_4x2c_tb IS

    COMPONENT ALU_4x2c
        PORT (
            A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Input
            S : IN STD_LOGIC; -- Selector (0)ADD or (1)SUB
            O : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Output
            C : OUT STD_LOGIC -- Carry/Borrow bit
        );
    END COMPONENT;

    SIGNAL A_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL B_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL S_tb : STD_LOGIC;
    SIGNAL O_tb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL C_tb : STD_LOGIC;

BEGIN

    UUT : ALU_4x2c
    PORT MAP(
        A => A_tb,
        B => B_tb,
        S => S_tb,
        O => O_tb,
        C => C_tb
    );

    stim_proc : PROCESS
    BEGIN
        -- 1) 0011 + 0101 = 0 1000   
        A_tb <= "0011";
        B_tb <= "0101";
        S_tb <= '0';
        WAIT FOR 5 ns;

        -- 2) 1100 + 1010 = 1 0110   
        A_tb <= "1100";
        B_tb <= "1010";
        S_tb <= '0';
        WAIT FOR 5 ns;

        -- 3) 0001 + 0010 = 0 0011   
        A_tb <= "0001";
        B_tb <= "0010";
        S_tb <= '0';
        WAIT FOR 5 ns;

        -- 4) 1111 + 0001 = 1 0000   
        A_tb <= "1111";
        B_tb <= "0001";
        S_tb <= '0';
        WAIT FOR 5 ns;

        -- 5) 0101 - 0011 = 0 0010   (borrow = 0)
        A_tb <= "0101";
        B_tb <= "0011";
        S_tb <= '1';
        WAIT FOR 5 ns;

        -- 6) 0010 - 0110 = 1 1100   (borrow = 1)
        A_tb <= "0010";
        B_tb <= "0110";
        S_tb <= '1';
        WAIT FOR 5 ns;

        -- 7) 1111 - 0001 = 0 1110   (borrow = 0)
        A_tb <= "1111";
        B_tb <= "0001";
        S_tb <= '1';
        WAIT FOR 5 ns;

        -- 8) 0000 - 0001 = 1 1111   (borrow = 1)
        A_tb <= "0000";
        B_tb <= "0001";
        S_tb <= '1';
        WAIT FOR 5 ns;

        WAIT;
    END PROCESS;

END ARCHITECTURE;
