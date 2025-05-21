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

        regn_do : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- Data Output

        -- c_flag_in        : IN  STD_LOGIC; 
        -- z_flag_in        : IN  STD_LOGIC; 
        -- v_flag_in        : IN  STD_LOGIC; 
        -- c_flag_wr_ena    : IN  STD_LOGIC; 
        -- z_flag_wr_ena    : IN  STD_LOGIC; 
        -- v_flag_wr_ena    : IN  STD_LOGIC; 
        -- c_flag_out       : OUT STD_LOGIC; 
        -- z_flag_out       : OUT STD_LOGIC; 
        -- v_flag_out       : OUT STD_LOGIC  

    );
END reg_bank;

ARCHITECTURE Hardware OF reg_bank IS
    SIGNAL reg0 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); -- Initializes a 8bit register 
    SIGNAL reg1 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); -- Initializes another 8bit register 
    SIGNAL reg2 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); -- Initializes another 8bit register 
BEGIN
    -- Writing Sequential  Process
    PROCESS (clk_in, nrst) -- Process triggers whenever clock changes, or it's reset
    BEGIN
        IF nrst = '0' THEN -- If reset = 0, all bits are cleated to 00000000
            reg0 <= (OTHERS => '0');
            reg1 <= (OTHERS => '0');
            reg2 <= (OTHERS => '0');

        ELSIF rising_edge(clk_in) THEN -- Else If the clock is on rising edge
            IF regn_wr_ena = '1' THEN -- If writing is enable
                IF regn_wr_sel = "00" THEN -- Select the 00 register for writing
                    reg0 <= regn_di;
                ELSIF regn_wr_sel = "01" THEN -- Select the 01 register for writing
                    reg1 <= regn_di;
                ELSIF regn_wr_sel = "10" THEN -- Select the 10 register for writing
                    reg2 <= regn_di;
                END IF;
                -- Other value (11) does nothing for now
            END IF;
        END IF;
    END PROCESS;

    -- Reading Combinational Assignment
    WITH regn_rd_sel SELECT -- Outputs the selected register value
        regn_do <=
        reg0 WHEN "00",
        reg1 WHEN "01",
        reg2 WHEN "10",
        (OTHERS => '0') WHEN OTHERS;
END Hardware;
