---- File: mux_4x1z.vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux_4x1z IS
    PORT (
        I : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Inputs
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Selection   
        E : IN STD_LOGIC; -- Enable
        O : OUT STD_LOGIC
    );
END ENTITY mux_4x1z;

ARCHITECTURE hardware OF mux_4x1z IS
    SIGNAL aux : STD_LOGIC; -- Aux signal
BEGIN

    WITH S SELECT
        aux <=
        I(0) WHEN "00",
        I(1) WHEN "01",
        I(2) WHEN "10",
        I(3) WHEN "11",
        'X' WHEN OTHERS;
    O <= aux WHEN E = '1' ELSE -- Enable
        'Z'; -- Disable

END hardware;
