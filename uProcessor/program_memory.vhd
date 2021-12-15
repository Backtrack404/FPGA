library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_arith.all;
    use ieee.std_logic_unsigned.all;

entity program_memory is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        address_bus : in std_logic_vector(15 downto 0);
        data_bus : out std_logic_vector(7 downto 0)
    );
end program_memory;

architecture BEH of program_memory is 
    type mem_array is array (0 to 19) of std_logic_vector(7 downto 0);
    signal mem : mem_array;
begin
    process(nRst, clk, address_bus)
        variable index : integer range 0 to 19 := 0;
    begin
        if(nRst = '0') then
            mem(0) <= x"40"; -- LD R1 0x40     0x40
            mem(1) <= x"0A"; -- Data 10 0x0A   0x0A
            mem(2) <= x"50"; -- LD R2          0x50
            mem(3) <= x"05"; -- Data 5         0x05
            mem(4) <= x"C0"; -- Add            0xC0
			mem(5) <= x"40";
			mem(6) <= x"09";
			mem(7) <= x"50";
			mem(8) <= x"02";
			mem(9) <= x"D1";
			mem(10) <= x"40";
			mem(11) <= x"07";
			mem(12) <= x"50";
			mem(13) <= x"0A";
			mem(14) <= x"E2";
			mem(15) <= x"40";
			mem(16) <= x"0A";
			mem(17) <= x"50";
			mem(18) <= x"04";
			mem(19) <= x"F3";
        elsif rising_edge(clk) then
            index := conv_integer(address_bus(4 downto 0));
            data_bus <= mem(index);
        end if;
    end process;
end BEH;



-- 1	0A	00001010
-- 2	50	01010000
-- 3	05	00000101
-- 4	C0	11000000
-- 5	40	01000000
-- 6	0D	00001101
-- 7	50	01010000
-- 8	0A	00001010
-- 9	C1	11000001
-- 10	40	01000000
-- 11	0F	00001111
-- 12	50	10100000
-- 13	03	00000011
-- 14	C2	11000010
-- 15	40	10000000
-- 16	03	00000011
-- 17	50	10100000
-- 18	0C	00001100
-- 19	C3	11000011
