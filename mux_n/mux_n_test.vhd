--Entidad de simulacion temporal

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE WORK.mux_n;

ENTITY mux_n_test IS
END mux_n_test;

ARCHITECTURE test_flujo OF mux_n_test IS

	CONSTANT num_bits: POSITIVE := 8; -- Exponencial de base 2
	CONSTANT cicloRelojNum: INTEGER := 2;
	CONSTANT cicloReloj: TIME:= cicloRelojNum * 1 NS;


	COMPONENT mux_n 	GENERIC	(num_bits: IN POSITIVE);
							PORT 		(ent,sel: IN STD_LOGIC_VECTOR;
										 sal: OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL ent : STD_LOGIC_VECTOR ((num_bits-1) DOWNTO 0) := "00000000";
	SIGNAL sel : STD_LOGIC_VECTOR ((num_bits/2)-2 DOWNTO 0) := "000" ;
	SIGNAL sal : STD_LOGIC := '0';
	
	FOR ALL: mux_n USE ENTITY WORK.mux_n(comportamiento);
	
	BEGIN
		mux: mux_n GENERIC MAP (num_bits) PORT MAP(ent=>ent, sel=>sel, sal=>sal);
		
		auto_sel:FOR i IN 0 TO (num_bits/2)-2 GENERATE
        sel(i) <= not sel(i) AFTER (cicloRelojNum+i) * 1 ns;
		END GENERATE auto_sel;
		
		auto_ent:FOR i IN 0 TO (num_bits-1) GENERATE
        ent(i) <= not ent(i) AFTER (cicloRelojNum+i) * 1 ns;
		END GENERATE auto_ent;
		
END test_flujo;