library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;
entity Duo_2to13_Counter_Test is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        q: out std_logic_vector(3 downto 0);
        fnd_data: out std_logic_vector(6 downto 0)
    );
end Duo_2to13_Counter_Test;
architecture BEH of Duo_2to13_Counter_Test is
  signal sig_cnt: std_logic_vector(3 downto 0);
begin
  process(nRst, clk)
  begin
    if(nRst ='0')then
      sig_cnt <= "0010";
      fnd_data <= "0100100";
    elsif clk 'event and clk = '1' then
      if(sig_cnt = 13) then
        sig_cnt <= "0010";
        fnd_data <= "0100100";
      else
        sig_cnt <= sig_cnt +1;
        fnd_data <= "0100100";
		  if(sig_cnt = 2) then
            fnd_data <= "0110000";elsif(sig_cnt = 3) then
            fnd_data <= "0011001";elsif(sig_cnt = 4) then
            fnd_data <= "0010010";elsif(sig_cnt = 5) then
            fnd_data <= "0000010";elsif(sig_cnt = 6) then
            fnd_data <= "1011000";elsif(sig_cnt = 7) then
            fnd_data <= "0000000";elsif(sig_cnt = 8) then
            fnd_data <= "0010000";elsif(sig_cnt = 9) then
            fnd_data <= "0001000"; --A
        elsif(sig_cnt = 10) then
            fnd_data <= "0000011"; --B
        elsif(sig_cnt = 11) then
            fnd_data <= "0100111"; --C
        elsif(sig_cnt = 12) then
            fnd_data <= "0100001"; --D
		  end if;
		end if;
    end if;
  end process;
  q <= sig_cnt;
end BEH;