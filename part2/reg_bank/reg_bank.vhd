-- File: reg_bank.vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY reg_bank IS
    PORT (
        clk_in : IN STD_LOGIC; -- Clock Signal
        nrst : IN STD_LOGIC; -- Reset
        regn_di : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data Input
        regn_wr_ena : IN STD_LOGIC; -- Write Enable

        regn_do : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Data Output
        regn_wr_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Register Write Select
        regn_rd_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0) -- Register Read Select

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
BEGIN
    -- Writing Sequential  Process
    PROCESS (clk_in, nrst) -- Process triggers whenever clock changes, or it's reset
    BEGIN
        IF nrst = '0' THEN
            reg0 <= (OTHERS => '0'); -- If reset = 0, all bits of reg are cleared to 0000000
        ELSIF rising_edge(clk_in) THEN -- Else If the clock is on rising edge
            IF regn_wr_ena = '1' THEN -- If writing is enable
                IF regn_wr_sel = "00" THEN -- Select the 00 register for writing
                    reg0 <= regn_di;
                END IF;
                -- Other values (01, 10, 11) do nothing for now
            END IF;
        END IF;
    END PROCESS;

    -- Reading Combinational Process
    PROCESS (regn_rd_sel, reg0) -- Given the resiter Selected
    BEGIN
        CASE regn_rd_sel IS -- Outputs the selected register value
            WHEN "00" =>
                regn_do <= reg0;
            WHEN OTHERS =>
                regn_do <= (OTHERS => '0');
        END CASE;
    END PROCESS;
END Hardware;
