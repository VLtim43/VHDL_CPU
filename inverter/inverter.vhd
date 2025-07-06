-- File: inverter.vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY inverter IS
    PORT (
        a : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
END inverter;

ARCHITECTURE hardware OF inverter IS
BEGIN
    y <= NOT a;
END hardware;
