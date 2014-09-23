--Entidad de simulacion temporal

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.mux_n_alt;

ENTITY mux_n_alt_test IS
END mux_n_alt_test;

ARCHITECTURE comportamiento OF mux_n_alt_test IS

	CONSTANT bits_sel: POSITIVE := 3; -- Exponencial de base 2
	CONSTANT cicloRelojNum: INTEGER := 2;
	CONSTANT cicloReloj: TIME:= cicloRelojNum * 1 NS;


	COMPONENT mux_n_alt 	GENERIC	(bits_sel: IN POSITIVE);
								PORT 		(ent: IN STD_LOGIC_VECTOR;
											 sel: IN INTEGER;
											sal: OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL ent : STD_LOGIC_VECTOR ((2**bits_sel - 1) DOWNTO 0) := "00000000";
	SIGNAL sel : INTEGER := 0;
	SIGNAL sal : STD_LOGIC := '0';
	
	FOR ALL: mux_n_alt USE ENTITY WORK.mux_n_alt(comportamiento);
	
	BEGIN
		mux: mux_n_alt GENERIC MAP (bits_sel) PORT MAP(ent=>ent, sel=>sel, sal=>sal);
		
	proceso: PROCESS
		begin
			WAIT for 10 ns;	
			ent(3) <= ('1');
			WAIT for 1 ns;
			sel <= 3;
			WAIT for 5 ns;
			ent(3) <= ('0');
			WAIT for 50 ns;
			sel <= 0;
      WAIT;
   END PROCESS;
		
END comportamiento;