-- File: reg_bank.vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY reg_bank IS
    PORT (
        clk_in : IN STD_LOGIC; -- Clock Signal
        regn_wr_ena : IN STD_LOGIC; -- Write Enable

        nrst : IN STD_LOGIC; -- Reset
        regn_di : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data Input

        regn_wr_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Register Write Select
        regn_rd_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Register Read Select

        c_flag_in : IN STD_LOGIC; -- Flag C input
        z_flag_in : IN STD_LOGIC; -- Flag Z input
        v_flag_in : IN STD_LOGIC; -- Flag V input

        c_flag_wr_ena : IN STD_LOGIC; -- Write enable for C
        z_flag_wr_ena : IN STD_LOGIC; -- Write enable for Z
        v_flag_wr_ena : IN STD_LOGIC; -- Write enable for V

        c_flag_out : OUT STD_LOGIC; -- Flag C output
        z_flag_out : OUT STD_LOGIC; -- Flag Z output
        v_flag_out : OUT STD_LOGIC; -- Flag V output

        regn_do : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- Data Output

    );
END reg_bank;

ARCHITECTURE arch OF reg_bank IS
    SIGNAL reg0 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); -- Initializes first 8bit register 
    SIGNAL reg1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); -- Initializes second 8bit register 
    SIGNAL reg2 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); -- Initializes third 8bit register

    SIGNAL reg3 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); -- Initializes the status register 
BEGIN
    -- Writing Sequential Process
    PROCESS (clk_in, nrst) -- Process triggers whenever clock changes, or it's reset
    BEGIN
        IF nrst = '0' THEN -- If reset = 0, all bits are cleared to 00000000
            reg0 <= (OTHERS => '0');
            reg1 <= (OTHERS => '0');
            reg2 <= (OTHERS => '0');
            reg3 <= (OTHERS => '0');
        ELSIF rising_edge(clk_in) THEN -- Else If the clock is on rising edge

            -- Flag writes have priority over general R3 write
            IF c_flag_wr_ena = '1' THEN -- If writing C flag
                reg3(0) <= c_flag_in;
            END IF;
            IF z_flag_wr_ena = '1' THEN -- If writing Z flag
                reg3(1) <= z_flag_in;
            END IF;
            IF v_flag_wr_ena = '1' THEN -- If writing V flag
                reg3(2) <= v_flag_in;
            END IF;

            IF regn_wr_ena = '1' THEN -- If writing is enabled
                IF regn_wr_sel = "00" THEN -- Select the 00 register for writing
                    reg0 <= regn_di;
                ELSIF regn_wr_sel = "01" THEN -- Select the 01 register for writing
                    reg1 <= regn_di;
                ELSIF regn_wr_sel = "10" THEN -- Select the 10 register for writing
                    reg2 <= regn_di;
                ELSIF regn_wr_sel = "11" THEN -- Select the 11 register for writing
                    -- Only write bits 3 to 7 if flag write is not taking over bits 0 to 2
                    reg3(7 DOWNTO 3) <= regn_di(7 DOWNTO 3);
                    IF c_flag_wr_ena = '0' THEN
                        reg3(0) <= regn_di(0);
                    END IF;
                    IF z_flag_wr_ena = '0' THEN
                        reg3(1) <= regn_di(1);
                    END IF;
                    IF v_flag_wr_ena = '0' THEN
                        reg3(2) <= regn_di(2);
                    END IF;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- Reading Combinational Assignment
    WITH regn_rd_sel SELECT -- Outputs the selected register value
        regn_do <=
        reg0 WHEN "00", -- Outputs reg00 if selected
        reg1 WHEN "01", -- Outputs reg01 if selected
        reg2 WHEN "10", -- Outputs reg10 if selected
        reg3 WHEN "11", -- Outputs reg11 if selected

        (OTHERS => '0') WHEN OTHERS;

    -- Flag outputs
    c_flag_out <= reg3(0); -- Outputs C flag
    z_flag_out <= reg3(1); -- Outputs Z flag
    v_flag_out <= reg3(2); -- Outputs V flag

END arch;
