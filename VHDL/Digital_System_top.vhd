LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity Digital_System_top is
	generic ( n : positive := 8 ); 
	port( upperBound : in std_logic_vector(9 downto 0);
		  KEY0,KEY1 : in std_logic;
		  CL_50 : in std_logic;
		  countOut : out std_logic_vector(7 downto 0);
		  countOut_h1: out Std_logic_vector(6 downto 0);
		  countOut_h2: out Std_logic_vector(6 downto 0);
		  UpperOut :out std_logic_vector(7 downto 0);
		  UpperOut_h1 :out std_logic_vector(6 downto 0);
		  UpperOut_h2 :out std_logic_vector(6 downto 0));
end Digital_System_top;
------------------------------------------------------------------
architecture arc_sy of Digital_System_top is
	component Digital_System is
	generic ( n : positive := 8 ); 
	port( rst,enable : in std_logic;
		  upperBound : in std_logic_vector(7 downto 0);
		  KEY0,KEY1 : in std_logic;
		  CL_50 : in std_logic;
		  countOut : out std_logic_vector(n-1 downto 0);
		  UpperOut :out std_logic_vector(7 downto 0));
end component;
component segment is
	generic ( n : positive := 8 ); 
	port(num1 : in std_logic_vector(3 downto 0);
		 num2: in std_logic_vector(3 downto 0);
		 out_h1 : out std_logic_vector(6 downto 0);
		 out_h2 : out std_logic_vector(6 downto 0));
end component;

SIGNAL cutUpperBound : std_logic_vector(7 downto 0);

SIGNAL Cout: std_logic_vector(7 downto 0);
SIGNAL Uout: std_logic_vector(7 downto 0);
signal Count_Upper : std_logic_vector(3 downto 0);
signal Count_low : std_logic_vector(3 downto 0);
signal Upper_Upper : std_logic_vector(3 downto 0);
signal Upper_low : std_logic_vector(3 downto 0);
begin
cutUpperBound<=(0=>upperBound(0),1=>upperBound(1),2=>upperBound(2),3=>upperBound(3),4=>upperBound(4),5=>upperBound(5),6=>upperBound(6),others=>upperBound(7));
	m1: Digital_System port map(
	     rst => upperBound(9),
		 enable=>upperBound(8),
		 upperBound=>cutUpperBound,
		 KEY0=>KEY0,
		 KEY1=>KEY1,
		 CL_50=>CL_50,
		 countOut=>Cout,
		 UpperOut=>Uout);
	
	m2: segment port map(Count_low,Count_Upper,countOut_h1,countOut_h2);
	m3: segment port map(Upper_low,Upper_Upper,UpperOut_h1,UpperOut_h2);

Count_low<=Cout(3 downto 0);
Count_Upper<=Cout(7 downto 4);
Upper_low<=Uout(3 downto 0);
Upper_Upper<=Uout(7 downto 4);
countOut<=Cout;
UpperOut<=Uout;



end arc_sy;







