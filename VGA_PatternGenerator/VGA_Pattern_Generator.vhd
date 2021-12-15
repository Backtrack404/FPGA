-- 분주
-- 100Mhz = 10ns 주기
-- 50Mhz = 20ns 주기 

-- 1Ghz = 
-- 쿼터스 최대 시뮬레이션 100us


library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;


entity VGA_Pattern_Generator is 
    port(
        nRst : in std_logic;
        clk : in std_logic;
        VGA_CLK : out std_logic;
        VGA_BLANK : out std_logic;
        VGA_HS : out std_logic;
        VGA_VS : out std_logic;
        VGA_SYNC : out std_logic;
        VGA_R : out std_logic_vector(9 downto 0);
        VGA_G : out std_logic_vector(9 downto 0);
        VGA_B : out std_logic_vector(9 downto 0)
    );
end VGA_Pattern_Generator;

architecture BEH of VGA_Pattern_Generator is 
        
    signal H_cnt : std_logic_vector(9 downto 0);
    signal V_cnt : std_logic_vector(9 downto 0);
    signal pclk : std_logic;

begin
        
    process(nRst, clk)
    begin
        if(nRst = '0') then
            pclk <= '0';
        elsif rising_edge(clk) then
            pclk <= not pclk;
        end if;
    end process;

    process(nRst, pclk)
    begin
        if(nRst = '0')then
            H_cnt <= (others => '0');
            v_cnt <= (others => '0');
        elsif rising_edge(pclk) then
            if(H_cnt = 799) then
                H_cnt <= (others => '0');
                if(V_cnt = 524) then
                    V_cnt <= (others => '0');
                else
                    V_cnt <= V_cnt + 1;
                end if;
            else
                H_cnt <= H_cnt + 1;
           end if;
        end if;
    end process;
    
    VGA_CLK <= pclk;
    VGA_HS <= '0' when (H_cnt >= 0) and (H_cnt <= 99) else '1';
    VGA_VS <= '0' when (V_cnt >= 0) and (V_cnt <= 1) else '1';
    VGA_BLANK <= '1' when (H_cnt >= 149) and (H_cnt <= 789) else '0'; --데이터 없는구간에서 LOW
    VGA_SYNC <= '0' when (H_cnt >= 149) and (H_cnt <= 789) else '1'; --데이터 있는구간에서 High
    VGA_R <= (others => '1') when (H_cnt >= 149) and (H_cnt <= 359) else (others => '0');
    VGA_G <= (others => '1') when (H_cnt >= 360) and (H_cnt <= 579) else (others => '0');
    VGA_B <= (others => '1') when (H_cnt >= 580) and (H_cnt <= 789) else (others => '0');
end BEH;


                


                