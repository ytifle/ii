-- Proyecto:    MUX_bus_test
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
USE WORK.MUX_bus;

-- Entidad de testbench

ENTITY MUX_bus_test IS
END MUX_bus_test;

-- Arquitectura de testbench

ARCHITECTURE MUX_bus_arq_test OF MUX_bus_test IS

    CONSTANT num_bits: POSITIVE := 2; -- Numero de bits de los buses del MUX
    CONSTANT ciclo: TIME := 10 NS; -- Tiempo de ciclo para la simulacion

    -- Declaracion de componentes
    
    COMPONENT MUX_bus 	    GENERIC (num_bits : IN  POSITIVE);
                            PORT    (data_in0:  IN  UNSIGNED ((num_bits-1) DOWNTO 0);
                                     data_in1:  IN  UNSIGNED ((num_bits-1) DOWNTO 0);
                                     control:   IN  STD_LOGIC;
                                     data_out:  OUT UNSIGNED ((num_bits-1) DOWNTO 0)
                                    );
    END COMPONENT;
    
    -- Creado de señales
    
    SIGNAL data_in0 : UNSIGNED ((num_bits-1) DOWNTO 0);
    SIGNAL data_in1 : UNSIGNED ((num_bits-1) DOWNTO 0);
    SIGNAL control : STD_LOGIC := '0';
    SIGNAL data_out:  UNSIGNED ((num_bits-1) DOWNTO 0);
    
    -- Instanciado de componentes
    
    FOR ALL: MUX_bus USE ENTITY WORK.MUX_bus(simple);
    
    -- Inicio del workbench
    
    BEGIN
    
        -- Mapeado de componentes
    
        mux: MUX_bus GENERIC MAP (num_bits=>num_bits) 
                     PORT MAP(  data_in0=>data_in0, 
                                data_in1=>data_in1,
                                control=>control,
                                data_out=>data_out);
        
        -- Codigo de la simulacion
        
        control <= NOT control AFTER ciclo/2; -- Alternar cada medio ciclo.
        PROCESS
            BEGIN
                FOR i IN 0 TO num_bits LOOP -- En orden creciente
                    data_in0 <= TO_UNSIGNED(i, num_bits); -- Alimentar el bus 0
                    WAIT FOR ciclo; -- Una vez por ciclo
                    END LOOP;
            END PROCESS;
            
        PROCESS
            BEGIN
                FOR i IN num_bits DOWNTO 0 LOOP -- En orden decreciente
                    data_in1 <= TO_UNSIGNED(i, num_bits); -- Alimentar el bus 1
                    WAIT FOR ciclo; -- Una vez por ciclo
                    END LOOP;
            END PROCESS;

END MUX_bus_arq_test;