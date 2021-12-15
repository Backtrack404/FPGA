library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Hex_Counter is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        q: out std_logic_vector(3 downto 0)
    );
end Hex_Counter;

architecture BEH of Hex_Counter is
    signal cnt: std_logic_vector (3 downto 0); --변수(변수는 아니지만 이해를 위해)
begin
    process(nRst, clk)  --nRST와 clk를 중심으로 돌아리
    begin
        if(nRst = '0') then --Active Low로 실행
            cnt <= (others => '0');
        elsif rising_edge(clk) then --상승조건
            cnt <= cnt +1;
        end if;
    end process;
    q <= cnt; --
end BEH ; 