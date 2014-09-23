LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--

PACKAGE mux_n_m_matrix IS
	constant m : integer := 8;
	type matrix is array (natural range <>) of std_logic_vector (m-1 downto 0);
END PACKAGE mux_n_m_matrix;

--Entidad
LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use work.mux_n_m_matrix.all;

ENTITY mux_n_m IS
	GENERIC (n : integer := 2);   -- size in bits of the selector, the number of inputs will be 2**n, change this if you want more 
	PORT (ent: in matrix (0 to (2**n)-1); --Entrada del mux.
			sel : in integer range 0 to 2**n-1;  --Selector del mux.
			sal: out std_logic_vector (m-1 downto 0)); --Salida del mux.
END mux_n_m;

--Arquitectura

ARCHITECTURE comportamiento OF mux_n_m IS
	BEGIN
		PROCESS (sel,ent)
			BEGIN
				 sal <= ent(sel);
		END PROCESS;
END comportamiento;