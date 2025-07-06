-- File: mux_4x1.vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mux_4x1 IS
    PORT (
        I : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Inputs
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- Selection   
        O : OUT STD_LOGIC
    );
END ENTITY mux_4x1;

ARCHITECTURE hardware OF mux_4x1 IS
BEGIN

    WITH S SELECT
        O <=
        I(0) WHEN "00",
        I(1) WHEN "01",
        I(2) WHEN "10",
        I(3) WHEN "11",
        'X' WHEN OTHERS;

END hardware;
