LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--Entidad

ENTITY mux_n IS 
	GENERIC (num_bits : IN POSITIVE := 8); -- Numero de bits del mux (n)
	PORT (sel: IN STD_LOGIC_VECTOR ((num_bits/2)-2 DOWNTO 0); --Selector del mux.
			ent: IN STD_LOGIC_VECTOR ((num_bits - 1) DOWNTO 0); --Entrada del mux.
			sal: OUT STD_LOGIC); --Salida del mux.
END mux_n;

--Arquitectura

ARCHITECTURE comportamiento OF mux_n IS
	BEGIN
		PROCESS (sel,ent)
			BEGIN
				sal <= ent( TO_INTEGER(UNSIGNED(sel)) ); -- Convertir STD_LOGIC_VECTOR a integer
		END PROCESS;
END comportamiento;