library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity sec_gen is
    port(
        nRst, clk : in std_logic;
        sec_sig : out std_logic
    );
end sec_gen;

architecture BEH of sec_gen is
    signal cnt : std_logic_vector(31 downto 0);
    signal sig : std_logic;

begin
    
    process(nRst, clk)
    begin
        if(nRst = '0')then
            sig <= '0';
            cnt <= (others => '0'); 
        elsif falling_edge(clk)then
		  --24999999
            if(cnt = '24999999')then -- 시뮬레이션 진행시 50Mhz를 N2
                                    --듀티비 50인1hz로 분주 // (5000000 / 2)-1
                cnt <= (others => '0');
                sig <= not sig;   --토글
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
	 sec_sig <= sig;
end BEH;