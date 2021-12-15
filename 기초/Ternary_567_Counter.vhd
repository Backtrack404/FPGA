library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Ternary_567_Counter is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        q: out std_logic_vector(2 downto 0)
    );
end Ternary_567_Counter;

architecture BEH of Ternary_567_Counter is
  signal sig_cnt: std_logic_vector(2 downto 0);
begin
  process(nRst, clk)
  begin
    if(nRst ='0')then
      sig_cnt <= "101";
    elsif clk 'event and clk = '1' then
      if(sig_cnt = 7) then
        sig_cnt <= "101";
      else
        sig_cnt <= sig_cnt +1;
      end if;
    end if;
  end process;
  q <= sig_cnt;
end BEH;