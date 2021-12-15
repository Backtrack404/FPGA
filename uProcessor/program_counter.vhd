library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity program_counter is
    port(
        nRst : in std_logic;
        clk : in std_logic;
        address_bus: out std_logic_vector(15 downto 0)
    );
end program_counter;


architecture BEH of program_counter is
    signal address: std_logic_vector (15 downto 0); 
begin
    process(nRst, clk) 
    begin
        if(nRst = '0') then
            address <= (others => '0');
        elsif rising_edge(clk) then
            address <= address + 1;
        end if;
    end process;
    address_bus <= address;
end BEH;





