library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Decimal_Counter is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        q: out std_logic_vector(3 downto 0)
    );
end Decimal_Counter;


architecture BEH of Decimal_Counter is
    signal sig_cnt: std_logic_vector (3 downto 0); 
begin
    process(nRst, clk) -- 플립플롭으로 합성됨
    begin
        if(nRst = '0') then
            sig_cnt <= (others => '0');
        elsif clk 'event and clk = '1' then
            if(sig_cnt = 12) then
                sig_cnt <= (others => '0');
            else
                sig_cnt <= sig_cnt + 1;
            end if;
        end if;
    end process;
    q <= sig_cnt;
end BEH;





