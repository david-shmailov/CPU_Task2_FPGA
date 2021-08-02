LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity Digital_System is
	generic ( n : positive := 8 ); 
	port( rst,enable : in std_logic;
		  upperBound : in std_logic_vector(7 downto 0);
		  KEY0,KEY1 : in std_logic;
		  CL_50 : in std_logic;
		  countOut : out std_logic_vector(n-1 downto 0);
		  UpperOut :out std_logic_vector(7 downto 0));
end Digital_System;
------------------------------------------------------------------
architecture arc_sy of Digital_System is
	component top is
		generic ( n : positive := 8 ); 
		port( rst,clk,enable : in std_logic;
			  upperBound : in std_logic_vector(n-1 downto 0);
			  countOut : out std_logic_vector(n-1 downto 0));
	end component;
	
	 component PLL port(
	      areset		: IN STD_LOGIC  := '0';
		   inclk0		: IN STD_LOGIC  ;
		       c0		: OUT STD_LOGIC ;
		    locked		: OUT STD_LOGIC );
    end component;
SIGNAL bitDivider : std_logic_vector(1 downto 0);
SIGNAL Upper: std_logic_vector(7 downto 0);
SIGNAL CLOCK :std_logic ;
signal PLLOut : std_logic ;
SIGNAL SW0 : std_logic :=upperBound(0);
SIGNAL SW1 : std_logic :=upperBound(1);
signal constOne : std_logic_vector(26 downto 0) := (0 => '1' , others => '0');
signal Count : std_logic_vector (26 downto 0) := (others => '0');
begin
	L0 : top generic map (n) port map(rst,CLOCK,enable,Upper,countOut);
	m1: PLL port map(
	     inclk0 => CL_50,
		  c0 => PLLOut
	   );
	--------------------------------------------------------------

	proc1 : process(KEY0)
	VARIABLE Up:std_logic_vector(n-1 downto 0):=(others=>'0');
	begin
			IF(KEY0'event and KEY0='1' ) then
				Up:=upperBound;
			end if;
				Upper<=Up;
				UpperOut<=Up;
	end process;
	--------------------------------------------------------------
	proc2 : process(KEY1)
	VARIABLE State : std_logic_vector (1 downto 0):=(others=>'0');
	begin 
			IF(KEY1'event and KEY1='1') then
				State:=(0=>SW0,1=>SW1);
			End IF;
			bitDivider<=State;
	end process;

	proc3 : process(PLLOut)
		variable counter : std_logic_vector (26 downto 0) :=(others=>'0');
	begin
		if(rising_edge(PLLOut)) then
			counter := counter + constOne;
		end if;
		count <= counter;
	end process;

	with bitDivider select
		CLOCK <= count(23) when "00",
				 count(24) when "01",
				 count(25) when "10",
				 count(26) when others;

	--------------------------------------------------------------

	--------------------------------------------------------------
end arc_sy;







