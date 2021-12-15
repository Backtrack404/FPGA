library ieee;                   -- 표준
  use ieee.std_logic_1164.all;  -- 문법 
  use ieee.std_logic_arith.all; -- 연산
  use ieee.std_logic_unsigned.all; --내부에서 사용하는 데이터 타입

entity MUX_2x1 is   --입출력 포트 정의(엔티티이름, 파일이름, 프로젝트이름 다 같아야함)
    port(
        A: in std_logic;    --in : 1비트 입력방향
        B: in std_logic;    
        SEL: in std_logic;
        Y: out std_logic    --out : 1비트 출력방향
    );
end MUX_2x1;    -- 정의 종료


architecture beh of MUX_2x1 is  --실제 동작 기술(beh : behavior(직접 행동 정의), str(구조 정의))
begin
    Y <= A when SEL = '0' else -- <= Y에 SEL 이 0이면 A, SEL이 1이면 B 할당 
			NOT B when SEL = '1' else   --오작동 방지를 위해 Default Low로
			'Z'; -- 1비트지만 0, 1말고 6가지 경우의수 더있음 따라서 예외처리 Z는 High impedance(즉 신호 출력 안하겠다)
            --MUX 뒤에 다른 회로 붙을 수 있으므로  
    -- 또다른 기술 방식 (구조정의) 
    -- Y <= ((NOT S)and A) or (S and B) 
end beh; 

 