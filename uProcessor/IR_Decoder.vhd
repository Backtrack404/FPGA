library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity IR_Decoder is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        data_bus : in std_logic_vector(7 downto 0);
        SELA : out std_logic_vector(1 downto 0);
        SELB : out std_logic_vector(1 downto 0);
        SELD : out std_logic_vector(1 downto 0);
        ALU_OP : out std_logic_vector(1 downto 0);
        BUS_Sel : out std_logic
        );
end IR_Decoder;

architecture beh of IR_Decoder is
begin
    process(nRst, clk)
    begin
        if(nRst = '0') then
            SELA <= "ZZ";
            SELB <= "ZZ";
            ALU_OP <= "ZZ";
            BUS_Sel <= 'Z';
        elsif rising_edge(clk)then
            if(data_bus(7 downto 6)="01") then
                SELA <= "ZZ";
                SELB <= "ZZ";
                ALU_OP <= "ZZ";
                SELD <= data_bus(5 downto 4);
                BUS_Sel <= '0';
            elsif (data_bus(7 downto 6)="11") then
                SELA <= "00";
                SELB <= "01";
                SELD <= data_bus(5 downto 4);
                ALU_OP <= data_bus(1 downto 0);
                BUS_Sel <= '1';
            else 
                SELA <= "ZZ";
                SELB <= "ZZ";
                SELD <= "ZZ";
                ALU_OP <= "ZZ";
                BUS_Sel <= '0';
            end if;
        end if ;
    end process;
end beh;