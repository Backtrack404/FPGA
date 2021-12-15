library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity hour_gen is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        digit_one : out std_logic_vector(3 downto 0);
        digit_ten : out std_logic_vector(3 downto 0)
    );
end hour_gen;


architecture BEH of hour_gen is
    signal cnt : std_logic_vector(3 downto 0);
begin

	 digit_one <= "0010" when cnt = 0 else
	 cnt when (cnt < 10) else cnt-10;
	 digit_ten <= "0001" when ((cnt > 9) or (cnt = 0)) else "0000";
    process(nRst, clk)
    begin
        if(nRst = '0') then
            cnt <= (others => '0'); 
        elsif falling_edge(clk)then
            if(cnt = "1100") then
                cnt <= "0001";
            else
                cnt <= cnt + 1;
            end if;
			
        end if;
    end process;
end BEH;