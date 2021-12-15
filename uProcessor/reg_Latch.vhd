library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity reg_Latch is 
    port(
        load : in std_logic;
        clk : in std_logic;
        in_data : in std_logic_vector(7 downto 0);
        q : out std_logic_vector(7 downto 0)
    );
end reg_Latch;

architecture beh of reg_Latch is
    signal sig_q : std_logic_vector(7 downto 0);
begin
    process(clk, load)
    begin
        if (load = '0') then
            sig_q <= x"00";
        elsif falling_edge(clk) then
            if load = '1' then
                sig_q <= in_data;
            end if;
        end if;
    end process;
    q <= sig_q;
end beh;