library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity ROM_4x8 is
    port(
        clk: in std_logic;  -- 클럭 input
        en: in std_logic;   -- Active Low읽기 허가신호
        address: in std_logic_vector(1 downto 0);   -- 읽을 주소 (0번지 ~ 3번지) 따라서 2비트만 있으면 됨
        data: out std_logic_vector(7 downto 0)      -- 읽기 데이터 출력(데이터 폭 8비트)
    );
end ROM_4x8;

architecture BEH of ROM_4x8 is
    type mem_array is array(0 to 3) of std_logic_vector(7 downto 0);    -- mem_array 배열[4x8]짜리 형 정의 
    signal mem : mem_array; --mem_array형의 mem 연결 생성
begin
    read: process(clk, address)
        variable index: integer range 0 to 3 := 0; -- integer형의 index변수 생성 (0~3전부 0으로 초기화)
    begin
        mem(0) <= x"08"; -- mem(0)배열에 0000 1000 할당
        mem(1) <= x"04"; -- mem(1)배열에 0000 0100 할당
        mem(2) <= x"02"; -- mem(2)배열에 0000 0010 할당
        mem(3) <= x"01"; -- mem(3)배열에 0000 0001 할당
        index := conv_integer(address(1 downto 0)); -- index변수에 address 백터를 int형으로 변환하여 대입
        if(en = '1') then -- 읽기 허가신호 아닐때
            data <= (others => '0'); -- data를 0으로 초기화 
        elsif rising_edge(clk) then -- Active Low이고 clk이 rising_edge일때
            data <= mem(index); -- data에 mem[index(0~3)]를 연결
        end if;
    end process;
end BEH;
