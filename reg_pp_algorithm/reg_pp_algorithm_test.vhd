-- Proyecto:    reg_pp_algorithm_test
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
USE WORK.reg_pp_algorithm;

-- Entidad de testbench

ENTITY reg_pp_algorithm_test IS
END reg_pp_algorithm_test;

-- Arquitectura de testbench

ARCHITECTURE reg_pp_algorithm_arq_test OF reg_pp_algorithm_test IS

    CONSTANT num_bits: POSITIVE := 4; -- Numero de bits de los buses del MUX
    
    CONSTANT ciclo_high: TIME := 4 NS; -- Tiempo de ciclo para la simulacion
    CONSTANT ciclo_low: TIME := 3 NS; -- Tiempo de ciclo para la simulacion
    CONSTANT ciclo: TIME := ciclo_high + ciclo_low; -- Tiempo de ciclo para la simulacion

    -- Declaracion de componentes
    
    COMPONENT reg_pp_algorithm  GENERIC (num_bits : IN  POSITIVE);
                                PORT    (data_in:   IN  UNSIGNED ((num_bits-1) DOWNTO 0);
                                         data_out:  OUT  UNSIGNED ((num_bits-1) DOWNTO 0);
                                         clk_ri:    IN  STD_LOGIC;
                                         rst_n:     IN  STD_LOGIC;
                                         enable_e:  IN  STD_LOGIC
                                        ); 
    END COMPONENT;
    
    -- Creado de signals
    
    SIGNAL data_in : UNSIGNED ((num_bits-1) DOWNTO 0):=TO_UNSIGNED(0, num_bits);
    SIGNAL data_out : UNSIGNED ((num_bits-1) DOWNTO 0):=TO_UNSIGNED(0, num_bits);
    SIGNAL clk_ri : STD_LOGIC := '0';
    SIGNAL rst_n : STD_LOGIC := '0';
    SIGNAL enable_e : STD_LOGIC := '0';
    
    -- Instanciado de componentes
    
    FOR ALL: reg_pp_algorithm USE ENTITY WORK.reg_pp_algorithm(behavior);
    
    -- Inicio del workbench
    
    BEGIN
    
        -- Mapeado de componentes
    
        mux: reg_pp_algorithm GENERIC MAP (num_bits=>num_bits) 
                              PORT MAP  (  data_in=>data_in, 
                                           data_out=>data_out,
                                           clk_ri=>clk_ri,
                                           rst_n=>rst_n,
                                           enable_e=>enable_e);
        
        -- Codigo de la simulacion
        
        PROCESS
            BEGIN
                FOR i IN 0 TO 1 LOOP   -- La señal de reloj no es simetrica
                    clk_ri <= '0';
                    WAIT FOR ciclo_low; -- Nivel Bajo
                    clk_ri <= '1';
                    WAIT FOR ciclo_high; -- Nivel Alto
                    END LOOP; -- Enbuclar para siempre
            END PROCESS;
        
        rst_n       <= '1', '0' AFTER 66.5 NS, '1' AFTER 77 NS;
        enable_e    <= '1', '0' AFTER 56 NS, '1' AFTER 70 NS;
        
        PROCESS
            BEGIN
                FOR i IN 0 TO (2**num_bits)-1 LOOP -- En orden creciente
                    data_in <= TO_UNSIGNED(i, num_bits); -- Alimentar el bus d_in
                    WAIT FOR ciclo; -- Una vez por ciclo
                    END LOOP;
            END PROCESS;

END reg_pp_algorithm_arq_test;