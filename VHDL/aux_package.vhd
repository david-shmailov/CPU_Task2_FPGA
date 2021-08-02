LIBRARY ieee;
USE ieee.std_logic_1164.all;


package aux_package is

component Digital_System_top is
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
end component;

component Digital_System is
	generic ( n : positive := 8 ); 
	port( rst,CL_50,enable,SW0,SW1,KEY0,KEY1 : in std_logic;
		  upperBound : in std_logic_vector(n-1 downto 0);
		  countOut : out std_logic_vector(n-1 downto 0);
		  UpperOut :out std_logic_vector(7 downto 0));
end component;

	component top is
		generic ( n : positive := 8 ); 
		port( rst,clk,enable : in std_logic;
		  upperBound : in std_logic_vector(n-1 downto 0);
		  countOut : out std_logic_vector(n-1 downto 0));
	end component;

  component segment is
	generic ( n : positive := 8 ); 
	port(num1 : in std_logic_vector(3 downto 0);
		 num2: in std_logic_vector(3 downto 0);
		 out_h1 : out std_logic_vector(6 downto 0);
		 out_h2 : out std_logic_vector(6 downto 0));
end component;
end aux_package;

