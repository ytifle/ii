-- Proyecto:    reg_pp_algorithm
-- Autor:       Gonzalez de Castro, Sergio
-- Fecha:       30/09/2014

--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.

--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.

--    You should have received a copy of the GNU General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>.

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Entidad

ENTITY reg_pp_algorithm IS 
    GENERIC (num_bits : IN  POSITIVE := 4); -- Numero de bits del registro.
    PORT    (data_in:   IN  STD_LOGIC_VECTOR ((num_bits-1) DOWNTO 0); -- Entrada
             data_out:  OUT  STD_LOGIC_VECTOR ((num_bits-1) DOWNTO 0); -- Salida
             clk_ri:    IN  STD_LOGIC; -- Clock por flanco de subida
             rst_n:     IN  STD_LOGIC; -- Reset por nivel a tierra
             enable_e:  IN  STD_LOGIC -- Enable por nivel a VCC
            );
END reg_pp_algorithm;

-- Arquitectura (flujo)

ARCHITECTURE behavior OF reg_pp_algorithm IS
    BEGIN
        PROCESS (data_in,clk_ri,rst_n,enable_e) -- Lista de sensibilidades
            BEGIN
                IF rst_n = '0' THEN -- Si el reset esta activado
                    data_out <= (OTHERS=>'0'); -- Reiniciamos la salida
                ELSIF rising_edge(clk_ri) AND enable_e='1' THEN -- Si el clock está en el flanco de subida, y el enable a VCC
                      data_out <= data_in; -- Actualizamos el valor del registro
                END IF;
        END PROCESS;
END behavior;