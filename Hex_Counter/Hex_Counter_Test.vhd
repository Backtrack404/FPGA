library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;
entity Hex_Counter_Test is
    port(
        nRst : in std_logic;
        clk : in std_logic;
		--q: out std_logic_vector(3 downto 0);	시뮬레이션 체크시에만 사용
		fnd_data: out std_logic_vector(6 downto 0)
    );
end Hex_Counter_Test;
architecture BEH of Hex_Counter_Test is
    signal cnt: std_logic_vector (3 downto 0); 
begin
    process(nRst, clk)
    begin
        if(nRst = '0') then
            cnt <= (others => '0');
				fnd_data <= "1000000";
				elsif clk 'event and clk = '1' then
					if(cnt = 15) then
						cnt <= (others => '0');
						fnd_data <= "1000000";
					else
					cnt <= cnt + 1;
							 fnd_data <= "1111001";
						if(cnt = 1) then
							fnd_data <= "0100100";elsif(cnt = 2) then
							fnd_data <= "0110000";elsif(cnt = 3) then
							fnd_data <= "0011001";elsif(cnt = 4) then
							fnd_data <= "0010010";elsif(cnt = 5) then
							fnd_data <= "0000010";elsif(cnt = 6) then
							fnd_data <= "1011000";elsif(cnt = 7) then
							fnd_data <= "0000000";elsif(cnt = 8) then
							fnd_data <= "0010000";elsif(cnt = 9) then
							fnd_data <= "0001000"; --A
						elsif(cnt = 10) then
							fnd_data <= "0000011"; --B
						elsif(cnt = 11) then
							fnd_data <= "0100111"; --C
						elsif(cnt = 12) then
							fnd_data <= "0100001"; --D
						elsif(cnt = 13) then
							fnd_data <= "0000110"; --E
						elsif(cnt = 14) then
							fnd_data <= "0001110"; --F
						end if;
				end if;		
        end if;
    end process;
	  --q <= cnt; 시뮬레이션 체크시에만 사용
end BEH ; 