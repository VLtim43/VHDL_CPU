-- File: and_gate.vhd
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY and_gate IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        O : OUT STD_LOGIC
    );

END ENTITY and_gate;

ARCHITECTURE hardware OF and_gate IS

BEGIN
    O <= A AND B;

END ARCHITECTURE hardware;
