library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity simple_state_machine is 
    port(
        nRst : in std_logic;
        clk : in std_logic;
        sw_a : in std_logic;
        sw_b : in std_logic;
        count : out std_logic_vector(3 downto 0)
    );
end simple_state_machine;

architecture state_machine of simple_state_machine is
    type state_type is (IDLE, STATE_A, STATE_B); -- 상태 정의
    signal state : state_type;
    signal cnt : std_logic_vector(3 downto 0);
begin
    process(nRst, clk)
    begin
        if(nRst = '0') then
            state <= IDLE;
            cnt <= (others => '0');
        elsif rising_edge(clk) then     -- 상태 동작
            case state is 
                when IDLE =>            -- [IDLE 상태]
                    if(sw_a = '1')then  -- sw_a = '1' 이면 
                        state <=STATE_A;    -- STATE_A로
                    elsif(sw_b = '1')then -- sw_b = '1' 이면
                        state <= STATE_B;   -- STATE_B로
                    else
                        state <= IDLE;    -- 예외시 IDLE
                    end if;
                    cnt <= (others => '0'); -- cnt 초기회
                
                    when STATE_A =>      -- [STATE_A 상태]   
                    if(cnt = 9) then    --  cnt가 9면       
                        cnt <= (others => '0'); -- 0으로 초기화 
                        state <= IDLE;  -- IDLE로
                    else 
                        cnt <= cnt + 1; -- 1씩 증가
                        state <= STATE_A; -- STATE_A 그대로
                    end if;
                
                when STATE_B =>       -- [STATE_B 상태]      
                    if(cnt = 15) then   -- cnt 가 15 면
                        cnt <= (others => '0'); -- 0으로 초기화
                        state <= IDLE;  -- IDLE로
                    else 
                        cnt <= cnt + 1; -- 1씩 증가
                        state <= STATE_B; -- STATE_B 그대로
                    end if;
                when others => 
                    state <= IDLE; -- 예외시 IDLE
            end case;
        end if;
    end process;
    count <= cnt; -- count 와 cnt 연결
end state_machine;
    