-- File: xor_gate.vhd
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY xor_gate IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        O : OUT STD_LOGIC
    );
END xor_gate;

ARCHITECTURE hardware OF xor_gate IS
BEGIN

    O <= A XOR B;

END hardware;
