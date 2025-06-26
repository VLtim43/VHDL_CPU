-- File: control.vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY control IS
    PORT (
        opcode : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- instr(15 downto 8)
        -- Sinais de controle:
        ALU_op : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        ALU_src : OUT STD_LOGIC; -- 0=reg–reg, 1=imediato
        Wreg_we : OUT STD_LOGIC; -- escreve em Wreg
        RegFile_we : OUT STD_LOGIC; -- escreve em R0–R3
        MemRead : OUT STD_LOGIC;
        MemWrite : OUT STD_LOGIC;
        IORead : OUT STD_LOGIC;
        IOWrite : OUT STD_LOGIC;
        PC_sel : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- 00=PC+1, 10=salto absoluto, 11=pilha
        PC_we : OUT STD_LOGIC;
        Push : OUT STD_LOGIC; -- empilha PC em CALL
        Pop : OUT STD_LOGIC; -- desempilha em RET
        Skip_en : OUT STD_LOGIC; -- habilita pular próxima instrução
        Flags_we : OUT STD_LOGIC -- habilita atualização de C,Z,V
    );
END control;

ARCHITECTURE Behavioral OF control IS
BEGIN
    control_proc : PROCESS (opcode)
    BEGIN
        -- defaults (nenhum sinal ativo)
        ALU_op <= "000";
        ALU_src <= '0';
        Wreg_we <= '0';
        RegFile_we <= '0';
        MemRead <= '0';
        MemWrite <= '0';
        IORead <= '0';
        IOWrite <= '0';
        PC_sel <= "00";
        PC_we <= '0';
        Push <= '0';
        Pop <= '0';
        Skip_en <= '0';
        Flags_we <= '0';

        CASE opcode IS
                -- Reg–Reg: ADD, SUB, AND, OR, XOR, MOV, etc.
            WHEN "000xxxxx" => -- SUB  (op=000, d=0⟶Wreg)
                ALU_op <= "000";
                Wreg_we <= '1';
                Flags_we <= '1';
            WHEN "001xxxxx" => -- SUBC
                ALU_op <= "001";
                Wreg_we <= '1';
                Flags_we <= '1';
            WHEN "010xxxxx" => -- ADD
                ALU_op <= "010";
                Wreg_we <= '1';
                Flags_we <= '1';
            WHEN "011xxxxx" => -- ADDC
                ALU_op <= "011";
                Wreg_we <= '1';
                Flags_we <= '1';
            WHEN "100xxxxx" => -- AND
                ALU_op <= "100";
                Wreg_we <= '1';
                Flags_we <= '1';
            WHEN "101xxxxx" => -- OR
                ALU_op <= "101";
                Wreg_we <= '1';
                Flags_we <= '1';
            WHEN "110xxxxx" => -- XOR
                ALU_op <= "110";
                Wreg_we <= '1';
                Flags_we <= '1';
            WHEN "111xxxxx" => -- MOV
                ALU_op <= "111";
                Wreg_we <= '1';
                Flags_we <= '1';

                -- Reg–Imed: SUBI, ADDI, ANDI, ORI, XORI, MOVI
            WHEN "01xxyyyy" => -- op em bits [6:4], d em bit 3
                ALU_op <= opcode(6 DOWNTO 4);
                ALU_src <= '1';
                IF opcode(3) = '0' THEN
                    Wreg_we <= '1';
                ELSE
                    RegFile_we <= '1';
                END IF;
                Flags_we <= '1';

                -- Unárias: RL, RR, RLC, RRC, SLL, SRL, SRA, NOT
            WHEN "10xxyyyy" => -- op em bits [6:4], d em bit 5
                ALU_op <= opcode(6 DOWNTO 4);
                ALU_src <= '0';
                IF opcode(5) = '0' THEN
                    Wreg_we <= '1';
                ELSE
                    RegFile_we <= '1';
                END IF;
                -- Z atualizado, C conforme bit de saída; V não muda
                Flags_we <= '1';

                -- Memória: LDM, STM
            WHEN "11000000" => -- LDM
                MemRead <= '1';
                Wreg_we <= '1';
            WHEN "11000001" => -- STM
                MemWrite <= '1';

                -- E/S: INP, OUT
            WHEN "1101x..." => -- op bits [4:3], d em bit 2
                IF opcode(4 DOWNTO 3) = "10" THEN -- INP
                    IF opcode(2) = '0' THEN
                        Wreg_we <= '1';
                    ELSE
                        RegFile_we <= '1';
                    END IF;
                    IORead <= '1';
                ELSIF opcode(4 DOWNTO 3) = "11" THEN -- OUT
                    IF opcode(2) = '0' THEN
                        Wreg_we <= '0';
                    ELSE
                        RegFile_we <= '1';
                    END IF;
                    IOWrite <= '1';
                END IF;

                -- Desvios incondicionais e CALL
            WHEN "1110x000" => -- JMP (op=0)
                PC_sel <= "10";
                PC_we <= '1';
            WHEN "1110x001" => -- CALL (op=1)
                Push <= '1';
                PC_sel <= "10";
                PC_we <= '1';

                -- Saltos condicionais
            WHEN "11110xx0" => -- SKIPC (00)
                Skip_en <= '1' AND C_flag; -- supondo sinal interno C_flag
            WHEN "11110xx1" => -- SKIPZ (01)
                Skip_en <= '1' AND Z_flag;
            WHEN "11111xx0" => -- SKIPV (10)
                Skip_en <= '1' AND V_flag;

                -- RET
            WHEN "11111xx1" => -- RET (11)
                Pop <= '1';
                PC_sel <= "11";
                PC_we <= '1';

                -- NOP e outros
            WHEN OTHERS =>
                NULL;
        END CASE;
    END PROCESS;
END Behavioral;
