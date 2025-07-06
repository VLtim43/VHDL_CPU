-- File: ALU_4x2c.vhd
-- 4 bit ALU with only add and sub operations with carry/borrow out

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU_4x2c IS
    PORT (
        A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Input
        S : IN STD_LOGIC; -- Selector (0)ADD or (1)SUB
        O : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Output
        C : OUT STD_LOGIC -- Carry/Borrow bit
    );
END ENTITY;

ARCHITECTURE hardware OF ALU_4x2c IS
    SIGNAL a_u, b_u : UNSIGNED(3 DOWNTO 0);
    SIGNAL result : UNSIGNED(4 DOWNTO 0); -- 5 bit result
BEGIN
    a_u <= UNSIGNED(A);
    b_u <= UNSIGNED(B);

    WITH S SELECT
        result <= ('0' & a_u) + ('0' & b_u) WHEN '0', -- ADD
        ('0' & a_u) - ('0' & b_u) WHEN '1', -- SUB
        (OTHERS => '0') WHEN OTHERS;

    O <= STD_LOGIC_VECTOR(result(3 DOWNTO 0));

    C <= result(4) WHEN S = '0' ELSE
        NOT result(4);
END ARCHITECTURE;
