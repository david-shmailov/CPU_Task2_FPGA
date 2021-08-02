library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity tb_static_bound is
	constant n : integer := 8;
end tb_static_bound;
---------------------------------------------------------
architecture rtb of tb_static_bound is
	signal rst,clk: std_logic;
	signal enable: std_logic := '1';
	signal upperBound : std_logic_vector(n-1 downto 0) := (0 => '1' , 1 => '1' , 2 =>'1' ,others => '0') ; --upperbound is set to 7
	signal countOut : std_logic_vector(n-1 downto 0);
begin
	L0 : top generic map (n) port map(rst,clk,enable,upperBound,countOut);
    
	--------- start of stimulus section ------------------	
        gen_clk : process
        begin
		  clk <= '0';
		  wait for 50 ns;
		  clk <= not clk;
		  wait for 50 ns;
        end process;

		gen_rst : process
        begin
		  rst <='1','0' after 100 ns;
		  wait;
        end process; 
		
end architecture rtb;
