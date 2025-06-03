-- file: Ram_2048x8.vhd

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Ram_2048x8 IS
    PORT (
        clk_in : IN STD_LOGIC; -- Clock Signal
        nrst : IN STD_LOGIC; -- Reset

        addr : IN STD_LOGIC_VECTOR(10 DOWNTO 0); -- 11-bit address (2048 locations)
        dio : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Bidirectional 8-bit data bus

        mem_wr_en : IN STD_LOGIC; -- Memory write enable
        mem_rd_en : IN STD_LOGIC -- Memory read enable
    );
END ENTITY Ram_2048x8;

ARCHITECTURE rtl OF Ram_2048x8 IS
    TYPE ram_type IS ARRAY(0 TO 2047) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL ram : ram_type := (OTHERS => (OTHERS => '0'));
    SIGNAL data_out : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    -- Synchronous write process with asynchronous reset
    PROCESS (clk_in, nrst)
    BEGIN
        IF nrst = '0' THEN
            ram <= (OTHERS => (OTHERS => '0')); -- clear all memory
        ELSIF rising_edge(clk_in) THEN
            IF mem_wr_en = '1' THEN
                ram(to_integer(unsigned(addr))) <= dio;
            END IF;
        END IF;
    END PROCESS;

    -- Combinational read logic
    data_out <= ram(to_integer(unsigned(addr))) WHEN mem_rd_en = '1' ELSE
        (OTHERS => 'Z');

    -- Connect bidirectional port
    dio <= data_out;

END ARCHITECTURE;
