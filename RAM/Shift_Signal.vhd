library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity Shift_Signal is
    port(
        clk: in std_logic;  -- 클럭 input
        din: in std_logic;  -- 시프트 시킬 input
        dout: out std_logic -- 시프트된 최종 값 output
    );
end Shift_Signal;

architecture BEH of Shift_Signal is
    signal a, b, c : std_logic; -- din을 시프트시킬 때 사용할 연결
begin
    process(clk)
    begin
        if rising_edge(clk) then -- clk의 rising edge일 때 실행
            a <= din;   -- din 과 a를 연결
            b <= a;     -- a와 b를 연결
            c <= b;     -- b와 c를 연결
            dout <= c;  -- c와 dout을 연결
        end if;
    end process;
    end BEH;
