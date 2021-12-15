library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity Shift_Variable is
    port(
        clk: in std_logic;  -- 클럭 input
        din: in std_logic;  -- 시프트 시킬 input
        dout: out std_logic -- 시프트된 최종 값 output
    );
end Shift_Variable;

architecture BEH of Shift_Variable is
begin
    process(clk)
        variable a, b, c : std_logic; -- a, b, c의 변수 생성
    begin
        if rising_edge(clk) then -- clk의 rising edge일 때 실행
            a := din;   -- a에 din값을 할당
            b := a;     -- b에 a 값을 할당
            c := b;     -- c에 b값을 할당
            dout <= c;  -- dout 에 c값을 할당
        end if;
    end process;
    end BEH;
