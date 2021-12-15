--50Mhz 를 1Hz로 
--스위치 내리면 run 올리면 Set모드
--시간조정, 분정, 초조정, 리셋버튼(12시로) 4개 버튼 사용

-- U_sec_gen = 1초 생성기
-- mux = set모드에서 사용자가 눌러주는 키 신호를 전달(run모드와 set모드 구분하기 위해 사용)
-- 
-- sec와 min은 같은 카운터 (60진수) 
-- hr은 시간 카운터(12진수)


-- !! 이거 시험에 나옴
-- 50Mhz를 1Hz로 분주 해야함 
-- t = 1/f (20ns)
-- 0 ~ 49999999 따라서 그 반

-- H와 L이 50%인 주기를 만들꺼임 
-- 0 ~ 24999999에서 토글 그럼 다시 0 ~ 24999999 이거 반복


--문제점 
--시뮬레이션 시간이 한정되있음

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
        elsif rising_edge(clk)then
            if(cnt = 24999999)then --50Mhz를 1Hz로 분주  //2499
                cnt <= (others => '0');
                sig <= not sig; -- 토글 
            else
                cnt <= cnt + 1;
            end if;
        end if;
    end process;
    sec_sig <= sig;
end BEH;