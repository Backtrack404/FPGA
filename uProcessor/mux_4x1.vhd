library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity mux_4x1 is
Port ( 
  Reg1 : in std_logic_vector(7 downto 0); -- mux input1
  Reg2 : in std_logic_vector(7 downto 0); -- mux input2
  Reg3 : in std_logic_vector(7 downto 0); -- mux input3
  Reg4 : in std_logic_vector(7 downto 0); -- mux input4
  sel : in std_logic_vector(1 downto 0); -- selection line
  Q : out std_logic_vector(7 downto 0)
  ); -- output data
end mux_4x1;

architecture BEH of mux_4x1 is
begin
    Q <= Reg1 when sel = 0 else
      Reg2 when SEL = 1 else
      Reg3 when SEL = 2 else
      Reg4 when SEL = 3 else (others => '0');
end BEH;