-- File: stack.vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY stack IS
    PORT (
        clk_in : IN STD_LOGIC; -- Clock Signal
        nrst : IN STD_LOGIC; -- Asynchronous Reset
        stack_in : IN STD_LOGIC_VECTOR(10 DOWNTO 0); -- Data Input

        stack_push : IN STD_LOGIC; -- Push Enable
        stack_pop : IN STD_LOGIC; -- Pop Enable

        stack_out : OUT STD_LOGIC_VECTOR(10 DOWNTO 0) -- Top of Stack Output
    );
END stack;

ARCHITECTURE arch OF stack IS
    TYPE stack_array IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(10 DOWNTO 0);
    SIGNAL stack_reg : stack_array := (OTHERS => (OTHERS => '0')); -- 8 x 11-bit stack
BEGIN

    PROCESS (clk_in, nrst)
    BEGIN
        IF nrst = '0' THEN
            -- Reset all stack positions
            stack_reg <= (OTHERS => (OTHERS => '0'));
        ELSIF rising_edge(clk_in) THEN
            IF stack_push = '1' THEN
                -- Push: shift right, insert new value at top
                stack_reg(7) <= stack_reg(6);
                stack_reg(6) <= stack_reg(5);
                stack_reg(5) <= stack_reg(4);
                stack_reg(4) <= stack_reg(3);
                stack_reg(3) <= stack_reg(2);
                stack_reg(2) <= stack_reg(1);
                stack_reg(1) <= stack_reg(0);
                stack_reg(0) <= stack_in;
            ELSIF stack_pop = '1' THEN
                -- Pop: shift left, fill last with zero
                stack_reg(0) <= stack_reg(1);
                stack_reg(1) <= stack_reg(2);
                stack_reg(2) <= stack_reg(3);
                stack_reg(3) <= stack_reg(4);
                stack_reg(4) <= stack_reg(5);
                stack_reg(5) <= stack_reg(6);
                stack_reg(6) <= stack_reg(7);
                stack_reg(7) <= (OTHERS => '0');
            END IF;
        END IF;
    END PROCESS;

    -- Output always reflects the top of the stack
    stack_out <= stack_reg(0);

END arch;
