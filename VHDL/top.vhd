LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE work.aux_package.all;
------------------------------------------------------------------
entity top is
	generic ( n : positive := 8 ); 
	port( rst,clk,enable : in std_logic;
		  upperBound : in std_logic_vector(n-1 downto 0);
		  countOut : out std_logic_vector(n-1 downto 0));
end top;
------------------------------------------------------------------
architecture arc_sys of top is	
SIGNAL connection : std_logic_vector(n-1 downto 0);
signal upperConnection : std_logic_vector(n-1 downto 0);
signal addone:std_logic_vector (n-1 downto 0);
begin

	addone <= (0=>'1',others=>'0');
	--------------------------------------------------------------
	proc1 : process(clk,rst,enable)
	VARIABLE ount : std_logic_vector (n-1 downto 0);
	begin
		IF (rst='1')THEN
				ount:=(others=>'0');
				countOut<= (others=>'0');
		ELSIF (clk'EVENT AND clk='1' and enable = '1') THEN
				if (connection=ount)then
					countOut<=(others=>'0');
					ount:=(others=>'0');
				ELSE
					ount:= ount+addone;
					countOut<=ount;
				END IF;
		END IF;
		
	end process;
	--------------------------------------------------------------
	proc2 : process(clk,rst,enable)
	VARIABLE ount : std_logic_vector (n-1 downto 0);
	--VARIABLE addone:std_logic_vector (n-1 downto 0):=(0=>'1',others=>'0');
	VARIABLE N:std_logic_vector (n-1 downto 0) := (others => '0');
	begin 
		IF (rst='1')THEN
				ount:=(others=>'0');
				N:=(others=>'0');
		ELSIF (clk'EVENT AND clk='1' and enable = '1') THEN
				if (N=ount)then
					if(N>=upperConnection) then
						N:=(others=>'0');
					else N:=N+addone;
					end if;
				ount:=(others=>'0');
				ELSE
				ount:= ount+addone;
		
				end if;
		END IF; 
		connection <=N ; 
	end process;
	--------------------------------------------------------------
	upperReg: process(clk,rst,enable)
		variable d : std_logic_vector(n-1 downto 0);
	begin
		if(rst='1') then
			d:=(others => '0');
		elsif (clk'event and clk='1' and enable='1') THEN
			d:=upperBound;
		end if;
		upperConnection <= d;
	end process;

end arc_sys;







