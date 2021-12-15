library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Ternary_567_Counter_Test is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        --q: out std_logic_vector(2 downto 0); --시뮬레이션 체크시에만 사용
        fnd_data: out std_logic_vector(6 downto 0)
    );
end Ternary_567_Counter_Test;

architecture BEH of Ternary_567_Counter_Test is
  signal sig_cnt: std_logic_vector(2 downto 0);
begin
  process(nRst, clk)
  begin
    if(nRst ='0')then
      sig_cnt <= "101";
      fnd_data <= "0010010";
    elsif clk 'event and clk = '1' then
      if(sig_cnt = 7) then
        sig_cnt <= "101";
        fnd_data <= "0010010";
      else
        sig_cnt <= sig_cnt +1;
        if(sig_cnt = 6) then
           fnd_data <= "1011000";
        else
          fnd_data <= "0000010";
        end if;
      end if;
    end if;
  end process;
  --q <= sig_cnt; --시뮬레이션 체크시에만 사용
end BEH;