library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity adc_control is 
    port(
        nRst : in std_logic;
        clk : in std_logic;
        t : in std_logic;
        dr : in std_logic;
        sc : out std_logic;
        oe : out std_logic
    );
end adc_control;

architecture BEH of adc_control is
    type state_type is (IDLE, START, WAIT_CONV, DATA_READ);
    signal state : state_type;
begin
    process(nRst, clk)
    begin
        if(nRst = '0') then
            state <= IDLE;
            sc <= '0';
            oe <= '0';
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if(t = '1')then
                        state <= START;
                        sc <= '1';
                        oe <= '0';
                    else 
                        state <= IDLE;
                        sc <= '0';
                        oe <= '0';
                    end if;
                when START => 
                    state <= WAIT_CONV;
                    sc <= '0';
                    oe <= '0';
                when WAIT_CONV =>
                    if(dr = '1') then
                        state <= DATA_READ;
                        sc <= '0';
                        oe <= '1';
                    else
                        state <= WAIT_CONV;
                        sc <= '0';
                        oe <= '0';
                    end if;
                when DATA_READ => 
                    state <= IDLE;
                    sc <= '0';
                    oe <= '0';
                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;
end BEH ; -- BEH