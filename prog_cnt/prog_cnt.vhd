--- File: prog_cnt.vhd
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY prog_cnt IS
    PORT (
        clk_in : IN STD_LOGIC; -- Clock Signal
        nrst : IN STD_LOGIC; -- Reset

        pc_ctrl : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Counter Options
        new_pc_in : IN STD_LOGIC_VECTOR(10 DOWNTO 0); -- Counter input when pc_ctrl = "01"
        from_stack : IN STD_LOGIC_VECTOR(10 DOWNTO 0); -- Counter input when pc_ctrl = "10"

        next_pc_out : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); -- Counter Next value preview Output
        pc_out : OUT STD_LOGIC_VECTOR(10 DOWNTO 0) -- Counter Output
    );
END prog_cnt;

ARCHITECTURE arch OF prog_cnt IS
    SIGNAL pc_reg : STD_LOGIC_VECTOR(10 DOWNTO 0) := (OTHERS => '0'); -- Initializes 11bit vector
    SIGNAL pc_next : STD_LOGIC_VECTOR(10 DOWNTO 0);
BEGIN

    -- Register Sequential Process
    PROCESS (clk_in, nrst)
    BEGIN
        IF nrst = '0' THEN
            pc_reg <= (OTHERS => '0');
        ELSIF rising_edge(clk_in) THEN
            pc_reg <= pc_next;
        END IF;
    END PROCESS;

    -- Combinational Logic: decide next value
    WITH pc_ctrl SELECT -- Select the Counter Option
        pc_next <=
        pc_reg WHEN "00",
        new_pc_in WHEN "01", -- new_pc_in Input
        from_stack WHEN "10", -- from_stack Input

        STD_LOGIC_VECTOR(unsigned(pc_reg) + 1) WHEN OTHERS; -- Increment +1

    -- Outputs
    pc_out <= pc_reg; -- Counter Output
    next_pc_out <= pc_next; -- Counter Preview Output

END arch;
