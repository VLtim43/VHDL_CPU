-- File: dec_2x4.vhd
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY dec_2x4 IS
    PORT (
        S : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        E : IN STD_LOGIC;
        Y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY dec_2x4;

ARCHITECTURE hardware OF dec_2x4 IS
    SIGNAL inputs : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN

    inputs <= E & S; -- bundling E and S into a bus

    WITH inputs SELECT
        Y <=
        "0001" WHEN "100",
        "0010" WHEN "101",
        "0100" WHEN "110",
        "1000" WHEN "111",
        "0000" WHEN OTHERS;

END ARCHITECTURE hardware;
