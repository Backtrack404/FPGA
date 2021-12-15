--1. 라이브러리
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

--2. 엔티티
entity mux_2x1_component is
    port(
        A : in std_logic;
        B: in std_logic;
        Sel : in std_logic; --입력 1비트
        Y : out std_logic --출력 1비트
    );
end mux_2x1_component;

-- 3. 아키텍쳐
architecture STR of mux_2x1_component is --구조적 방법으로 기술 (구조만 연결해놓음) structure

    --하위 디자인 컴포넌트로 선언 각각 하위 엔티티 기술 
    component AND_2 is -- 2번 사용해도 컴포넌트에서는 1번만 선언
        port(
            A, B: in std_logic;
            Y : out std_logic
        );
    end component;

    component OR_Gate is
        port(
            A, B: in std_logic;
            Y : out std_logic
        );
    end component;
	
	 component NOT_gate is
		port(
			A: in std_logic;
			Y: out std_logic
		);
    end component;
    
    --내부 컴포넌트간의 연결 시그널 선언
    signal NotS : std_logic;    
    signal AandNotS: std_logic;
    signal BandS : std_logic;

begin 
        -- 내부 구조 기술 
        U1 : AND_2 --U1은 라벨
        port map( -- A, B, Y는 하위 엔티티(원 컴포넌트)의 포트를 각각의 시그널선으로 연결(방향 상관 없음) 
                  --ex) Y포트를 AandNotS에 연결하겠다 
            A => A, 
            B => NotS,
            Y => AandNotS   -- U1(AND_2)와 U4(OR_Gate)와 연결
        );

        U2 : AND_2
        port map(
            A => B,
            B => Sel,
            Y => BandS
        );

        U3 : NOT_gate
        port map(
            A => Sel,
            Y => NotS
        );

        U4 : OR_Gate
        port map(
            A => AandNotS,
            B => BandS,
            Y => Y
        );
end STR;
