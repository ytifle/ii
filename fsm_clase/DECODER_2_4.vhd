-------------------------------------------------------------------------------------------
--ESTE DISEÑO PUEDE SER COPIADO CON FINES DE ESTUDIO 
------------------------------------------------------------------------------------------
-- Proyecto                    Ejercicio Sintetizable
-- Diseño:                     Decodificador
-- Nombre del fichero:         decoder_2_4.vhd 
--                                     
-- Autor:		       Nombre del alumno
-- Fecha:		       xx/xx/xx
-- Versión:                    0.1
-- Resumen:	               Este fichero contiene la entidad de un decodificador de 2 a 4. 
--                             utilizando tipo de datos STD_LOGIC.
--                             Se desarrollaran una arquitecturas en el estilo de comportamiento
--                                       
-- Modificaciones:
--
-- Fecha	 		Autor		Versión	 	Descripción del cambio
--========================================================================================
 --20/11/03 	                VRB	  	0.1	    	Original
-- 25/11/03			AAM		    		Comentarios
--========================================================================================



LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;


ENTITY decoder_2_4 IS 
 PORT (ent_selec: 		IN STD_LOGIC_VECTOR (1 DOWNTO 0);       -- entrada de seleccion
       salidas: 	    OUT STD_LOGIC_VECTOR (3 DOWNTO 0)      -- salidas decodificadas
       );   
END decoder_2_4;

ARCHITECTURE comporta OF decoder_2_4 IS 

BEGIN

  PROCESS (ent_selec)

    BEGIN

     CASE ent_selec IS

       WHEN "00" =>  salidas <= "0001";
       WHEN "01" =>  salidas <= "0010";
       WHEN "10" =>  salidas <= "0100";
       WHEN "11" =>  salidas <= "1000";
       WHEN OTHERS =>  salidas <= "0000";
-- 
     END CASE;
    END PROCESS;
 END comporta;


 