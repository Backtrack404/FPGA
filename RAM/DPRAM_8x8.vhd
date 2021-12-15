library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity DPRAM_8x8 is
    port(
        clk_l: in std_logic;  -- write clk
        wrn: in std_logic; -- write enable
        waddr: in std_logic_vector(2 downto 0); -- write adress(0 ~ 7까지 //0b000 ~ 0b111)
        data_in: in std_logic_vector(7 downto 0); -- write data(데이터 폭 8비트)
        clk_r: in std_logic;    -- read clk
        rdn: in std_logic;      -- read enable
        raddr: in std_logic_vector(2 downto 0);   -- read address(0 ~ 7까지 //0b000 ~ 0b111)
        data_out: out std_logic_vector(7 downto 0) -- read data(데이터 폭 8비트)
    );
end DPRAM_8x8;

architecture BEH of DPRAM_8x8 is
    type mem_tbl is array(0 to 7) of std_logic_vector(7 downto 0); -- mem_tbl 배열[8x8]짜리 형 정의 
    signal mem : mem_tbl; --mem_tbl형의 mem 연결 생성
begin
    write:process(clk_l)    -- 쓰기시 작동될 process
        variable I_A : natural; -- 자연수 I_A 변수 생성 
    begin
        I_A := conv_integer(waddr); -- I_A 변수에 waddr벡터를 int형을 변환해서 대입
        if rising_edge(clk_l) then -- clk_l이 rising edge이면 
            if(wrn = '0') then   -- write enable 신호일 때
                mem(I_A) <= data_in; -- mem배열에 data_in 연결
            end if;
        end if;
    end process;
    
    read:process(clk_r) -- 읽기시 작동될 process
        variable I_A : natural; -- 자연수 I_A 변수 생성
    begin 
        I_A := conv_integer(raddr); -- I_A 변수에 raddr벡터를 int형을 변환해서 대입
        if falling_edge(clk_r) then -- clk_r이 falling edge이면 
            if(rdn = '0') then  -- read enable 신호이면
                data_out <= mem(I_A); -- data_out에 mem(I_A)베열 연결
            else 
                data_out <= (others => '0'); -- read disable 이면 0 출력
            end if;
        end if;
    end process;
end BEH;
