LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--Entidad

ENTITY mux_n_alt IS 
	GENERIC (bits_sel : IN POSITIVE := 2); -- Numero de bits del selector
	PORT (sel: IN INTEGER RANGE 0 TO 2**bits_sel-1; --Selector del mux.
			ent: IN STD_LOGIC_VECTOR ((2**bits_sel - 1) DOWNTO 0); --Entrada del mux.
			sal: OUT STD_LOGIC); --Salida del mux.
END mux_n_alt;

--Arquitectura

ARCHITECTURE comportamiento OF mux_n_alt IS
	BEGIN
		PROCESS (sel,ent)
			BEGIN
				sal <= ent(sel);
		END PROCESS;
END comportamiento;