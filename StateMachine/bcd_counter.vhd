library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity bcd_counter is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        count : out std_logic_vector(3 downto 0)
    );
end bcd_counter;

architecture state_machine of bcd_counter is 
    type state_type is (zero, one, two, three, four, five, six, seven, eight, nine);    -- 상태 선언
    signal state : state_type;  -- 상태 대입
begin
    state_move : process(nRst, clk)
    begin
        if(nRst = '0') then
            state <= zero; -- 기본 zero 상태
        elsif rising_edge(clk) then
            case state is  -- 상태 동작
                when zero =>
                    state <= one;
                when one =>
                    state <= two;
                when two =>
                    state <= three; 
                when three =>
                    state <= four;
                when four =>
                    state <= five;
                when five =>
                    state <= six;
                when six =>
                    state <= seven;
                when seven =>
                    state <= eight;
                when eight =>
                    state <= nine;
                when nine =>
                    state <= zero;
                when others =>      
                    state <= zero;
            end case;
        end if;
    end process;
        
    count <= "0000" when state = zero else  -- count 포트와 물리적으로 연결
             "0001" when state = one else
             "0010" when state = two else
             "0011" when state = three else
             "0100" when state = four else
             "0101" when state = five else
             "0110" when state = six else
             "0111" when state = seven else
             "1000" when state = eight else
             "1001" when state = nine else
             "0000";
end state_machine;
    