library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;


  entity decoder_2x4 is
    port (
        sel : in std_logic_vector(1 downto 0);
        A : out std_logic;
        B : out std_logic;
        C : out std_logic;
        D : out std_logic
    );
  end decoder_2x4;

  architecture beh of decoder_2x4 is
  begin
    A <= '1' when sel = 0 else '0';
    B <= '1' when sel = 1 else '0';
    C <= '1' when sel = 2 else '0';
    D <= '1' when sel = 3 else '0';
  end beh ; -- beh