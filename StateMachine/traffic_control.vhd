library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity traffic_control is 
    port(
        nRst : in std_logic;
        clk : in std_logic;
        M_G: out std_logic;
        M_R: out std_logic;
        C_G: out std_logic;
        C_R: out std_logic;
        C_Y: out std_logic;

        count : out std_logic_vector(3 downto 0);
        flick_sig: out std_logic
    );
end traffic_control;

architecture BEH of traffic_control is
    type state_type is (MAN_GO, MAN_STOP, CAR_GO, CAR_STOP);
    signal state: state_type;
    signal cnt : std_logic_vector(5 downto 0);
    type clk_type is (LED_ON, LED_OFF);
    signal flicker : clk_type;

begin
    process(nRst, clk)
    begin
        if(nRst = '0') then
            state <= MAN_GO;
            cnt <= (others => '0');
        elsif rising_edge(clk) then
        
            case state is
                when MAN_GO =>              -- 횡단보도 초록불
                    if(cnt = 30) then       -- 30초 되면
                        state <= MAN_STOP;  -- 횡단보도 빨간불
                        cnt <= (others => '0'); -- 카운터 0 초기화
                    else 
                        cnt <= cnt + 1;     -- 30까지 1 씩 카운팅
                        M_G <= '1';         -- 횡단보도 초록불 o
                        M_R <= '0';         -- 횡단보도 빨간불 x
                        C_G <= '0';         -- 도로 초록불 x
                        C_Y <= '0';         -- 도로 노란불 x
                        C_R <= '1';         -- 도로 빨간불 o
                    end if;

                    when MAN_STOP =>        -- 횡단보도 깜빡임 
                        if(cnt = 10) then   -- 10초 되면
                            state <= CAR_GO;  -- 도로 초록불
                            cnt <= (others => '0'); -- 카운터 0 초기화
                            M_G <= '0';       -- 초록불 x
                        else 
                            cnt <= cnt + 1; -- 카운터 1씩 증가
                            if (flicker = LED_ON) then    -- 깜빡임
                                M_G <= '1';               -- 횡단보도 초록불 o  
                            elsif (flicker = LED_OFF) then
                                M_G <= '0';               -- 횡단보도 초록불 x
                            else
                                M_G <= '1';               -- 횡단보도 초록불 o
                            end if;
                        M_R <= '0';     -- 횡단보도 빨간불 x
                        C_G <= '0';     -- 도로 초록불 x
                        C_R <= '1';     -- 도로 빨간불 o
                        C_Y <= '0';     -- 도로 노란불 x
                        end if;
                    
                    when CAR_GO =>      -- 도로 초록불 
                        if(cnt = 60) then   -- 60초 되면 
                            state <= CAR_STOP;  -- 도로 빨간불
                            cnt <= (others => '0'); -- 카운터 초기화
                        else 
                            cnt <= cnt + 1; -- 카운터 1씩 증가
                            M_G <= '0';     -- 횡단보도 초록불 x
                            M_R <= '1';     -- 횡단보도 빨간불 o
                            C_G <= '1';     -- 도로 초록불 o
                            C_Y <= '0';     -- 도로 노란불 x
                            C_R <= '0';     -- 도로 빨간불 x
                            
                        end if;
                    
                    when CAR_STOP =>    -- 도로 빨간불 
                        if(cnt = 5) then    -- 5초 되면 
                            state <= MAN_GO;    -- 도로 초록불
                            cnt <= (others => '0'); -- 카운터 초기화
                        else 
                            cnt <= cnt + 1; -- 카운터 1씩 증가
                            M_G <= '0';     -- 횡단보도 초록불 x
                            M_R <= '1';     -- 횡단보도 빨간불 o
                            C_G <= '0';     -- 도로 초록불 x
                            C_Y <= '1';     -- 도로 노란불 o
                            C_R <= '0';     -- 도로 빨간불 x
                            
                        end if;

                    when others => 
                        state <= MAN_GO;    -- 예외시 횡단보도 초록불
            end case;
            
            case flicker is     -- 깜빡거림
                when LED_OFF =>     
                    flicker <= LED_ON;
                when LED_ON =>
                    flicker <= LED_OFF;
                when others =>
                    flicker <= LED_OFF;
            end case;
        end if;
    end process;

flick_sig <= '1' when flicker = LED_OFF else
             '0' when flicker = LED_ON else
             '1';
end BEH;
