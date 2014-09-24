-- Proyecto:    MUX_bus
-- Autor:       Gonzalez de Castro, Sergio
-- Fecha:       24/09/2014

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

ENTITY MUX_bus IS 
    GENERIC (num_bits : IN  POSITIVE := 4); -- Numero de bits del bus
    PORT    (data_in0:  IN  UNSIGNED ((num_bits-1) DOWNTO 0);  -- Bus 0 de datos
             data_in1:  IN  UNSIGNED ((num_bits-1) DOWNTO 0);  -- Bus 1 de datos
             control:   IN  STD_LOGIC; -- Bit de control de seleccion de bus
             data_out:  OUT UNSIGNED ((num_bits-1) DOWNTO 0) -- Bus de salida del mux
            ); 
END MUX_bus;

-- Arquitectura (flujo)

ARCHITECTURE simple OF MUX_bus IS
    BEGIN
        PROCESS (control,data_in0,data_in1) -- Lista de sensibilidades
            BEGIN
                IF falling_edge(control) OR control = '0' THEN -- Si el control esta a GND, escojemos el bus 0
                    data_out <= data_in0;
                ELSE IF rising_edge(control) OR control = '1' THEN -- Si esta a VCC, la salida es el bus 1
                      data_out <= data_in1;
                    END IF;
                END IF;
        END PROCESS;
END simple;