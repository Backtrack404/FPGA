library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity fnd_decoder is
  port (
    data: in std_logic_vector(3 downto 0);
    fnd_data: out std_logic_vector(6 downto 0)
  ) ;
end fnd_decoder;


architecture beh of fnd_decoder is
begin
    fnd_data <= "1000000" when data = x"0" else -- 0이 점등 1이 점멸 각 비트는 시계방향으로 움직임
        "1111001" when data = x"1" else
        "0100100" when data = x"2" else
        "0110000" when data = x"3" else
        "0011001" when data = x"4" else
        "0010010" when data = x"5" else
        "0000010" when data = x"6" else
        "1011000" when data = x"7" else
        "0000000" when data = x"8" else
        "0010000" when data = x"9" else
        "1111111";
end beh ; 


