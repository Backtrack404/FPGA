library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity min_gen is
  port (
    nRst, clk : in std_logic;
    digit_one : out std_logic_vector(3 downto 0);
    digit_ten : out std_logic_vector(3 downto 0);
    carry : out std_logic
  ) ;
end min_gen;

architecture BEH of min_gen is
    signal cnt_one : std_logic_vector(3 downto 0);
    signal cnt_ten : std_logic_vector(3 downto 0);

begin
    digit_one <= cnt_one;
    digit_ten <= cnt_ten;

    carry <= '1' when ((cnt_ten = 5 ) and (cnt_one =9))else'0';

    process(nRst, clk)
    begin
        if(nRst = '0')then
            cnt_one <= (others => '0');
            cnt_ten <= (others => '0');

        elsif falling_edge(clk)then
            if(cnt_one = 9)then
                cnt_one <= (others => '0');
                if(cnt_ten = 5)then
                    cnt_ten <= (others => '0');
                else
                    cnt_ten <= cnt_ten + 1;
                end if;
            else
                cnt_one <= cnt_one + 1;
            end if;
        end if;
    end process;
end BEH;
