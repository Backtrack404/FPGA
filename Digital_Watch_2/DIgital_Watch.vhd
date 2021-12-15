library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity Digital_Watch is 
    port(
        nRst :in std_logic;
        clk :in std_logic;
        key_sec :in std_logic;
        key_min :in std_logic;
        key_hr :in std_logic;
        sel_sw :in std_logic;
        fnd_sec_one : out std_logic_vector(6 downto 0);
        fnd_sec_ten : out std_logic_vector(6 downto 0);
        fnd_min_one : out std_logic_vector(6 downto 0);
        fnd_min_ten : out std_logic_vector(6 downto 0);
        fnd_hr_one : out std_logic_vector(6 downto 0);
        fnd_hr_ten : out std_logic_vector(6 downto 0)
    );
end Digital_Watch;

architecture BEH of Digital_Watch is

    component sec_gen is 
    port(
        nRst : in std_logic;
        clk : in std_logic;
        sec_sig : out std_logic
    );
    end component;

    component MUX_2x1 is 
    port(
        A : in std_logic;
        B : in std_logic;
        SEL : in std_logic;
        Y : out std_logic
    );
    end component;
    
    component fnd_decoder is 
    port(
        data : in std_logic_vector(3 downto 0);
        fnd_data : out std_logic_vector(6 downto 0)
    );
    end component;

    component min_gen is 
    port(
        nRst :in std_logic;
        clk :in std_logic;
        digit_one: out std_logic_vector(3 downto 0);
        digit_ten : out std_logic_vector(3 downto 0);
        carry : out std_logic
    );
    end component;

    component hour_gen is 
    port(
        nRst : in std_logic;
        clk : in std_logic;
        digit_one: out std_logic_vector(3 downto 0);
        digit_ten : out std_logic_vector(3 downto 0)
    );
    end component;

    signal sec_sig : std_logic;
    signal sec_clk : std_logic;
    signal min_clk : std_logic;
    signal hr_clk : std_logic;
    signal sec_carry : std_logic;
    signal min_carry : std_logic; 
    signal sec_cnt_one : std_logic_vector(3 downto 0);
    signal sec_cnt_ten : std_logic_vector(3 downto 0);
    signal min_cnt_one : std_logic_vector(3 downto 0);
    signal min_cnt_ten : std_logic_vector(3 downto 0);
    signal hr_cnt_one : std_logic_vector(3 downto 0);
    signal hr_cnt_ten :  std_logic_vector(3 downto 0);

begin
    U_sec_gen : sec_gen
    port map(
        nRst => nRst,
        clk => clk,
        sec_sig => sec_sig
    );
    U_sec_mux: MUX_2x1
    port map(
        A => sec_sig,
        B => key_sec,
        SEL => sel_sw,
        Y => sec_clk
    );

    U_min_mux : MUX_2x1
    port map(
        A => sec_carry,
        B => key_min,
        SEL => sel_sw,
        Y => min_clk
    );

    U_hr_mux : MUX_2x1
    port map(
        A => min_carry,
        B => key_hr,
        SEL => sel_sw,
        Y => hr_clk
    );

    U_cnt_sec : min_gen
    port map(
        nRst => nRst,
        clk => sec_clk,
        digit_one => sec_cnt_one,
        digit_ten => sec_cnt_ten,
        carry => sec_carry
    );

    U_cnt_min : min_gen
    port map(
        nRst => nRst,
        clk => min_clk,
        digit_one => min_cnt_one, 
        digit_ten => min_cnt_ten,
        carry => min_carry
    );

    U_cnt_hr : hour_gen
    port map(
        nRst => nRst,
        clk => hr_clk,
        digit_one => hr_cnt_one,
        digit_ten => hr_cnt_ten
    );

    U_fnd_sec_one : fnd_decoder
    port map(
        data => sec_cnt_one,
        fnd_data => fnd_sec_one
    );

    U_fnd_sec_ten : fnd_decoder
    port map(
        data => sec_cnt_ten,
        fnd_data => fnd_sec_ten
    );

    U_fnd_min_one : fnd_decoder
    port map(
        data => min_cnt_one,
        fnd_data => fnd_min_one
    );

    U_fnd_min_ten : fnd_decoder
    port map(
        data => min_cnt_ten,
        fnd_data => fnd_min_ten
    );
    
    U_fnd_hr_one : fnd_decoder
    port map(
        data => hr_cnt_one,
        fnd_data => fnd_hr_one
    );

    U_fnd_hr_ten : fnd_decoder
    port map(
        data => hr_cnt_ten,
        fnd_data => fnd_hr_ten
    );

end BEH ; 