library ieee;
use ieee.std_logic_1164.all; 

ENTITY visualizador_velocidad IS
	PORT (
			reloj : IN STD_LOGIC; -- Flanco de subida
			contacto_llaves : IN STD_LOGIC; -- (L) llaves puestas
			piso_acelerador : IN STD_LOGIC; -- (H) acelero
			piso_freno : IN STD_LOGIC; -- (H) freno
			marcha_puesta : IN STD_LOGIC; -- (H) activo salida
			velocidad_visualizada: OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END visualizador_velocidad;

ARCHITECTURE estructural OF visualizador_velocidad IS
	
	COMPONENT control_fsm	port(
										clk		 : in	std_logic;
										keys	 : in	std_logic;
										brake	 : in	std_logic;
										accelerate	 : in	std_logic;
										output	 : out	std_logic_vector(1 downto 0)
									);
	END COMPONENT;
	
	COMPONENT data_path GENERIC(num_bits:POSITIVE :=4);
									PORT (
											clk : IN STD_LOGIC; -- Activo por flanco de subida
											rst_n : IN STD_LOGIC; -- Activo por nivel bajo
											enable : IN STD_LOGIC; -- Activo por nivel alto
											data_in : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
											velocidad: OUT STD_LOGIC_VECTOR (num_bits -1 DOWNTO 0)
									);
	END COMPONENT;
	
	SIGNAL fsm_to_datapath: STD_LOGIC_VECTOR (1 DOWNTO 0);
	 
	FOR ALL: control_fsm USE ENTITY WORK.control_fsm(rtl);
	FOR ALL: data_path USE ENTITY WORK.data_path(estructural);

	
BEGIN

	decoder: control_fsm PORT MAP(clk => reloj, 
											keys => contacto_llaves, 
											brake => piso_freno, 
											accelerate => piso_acelerador,
											output => fsm_to_datapath);
											
	datapatho: data_path GENERIC MAP(num_bits => 4)
								PORT MAP(clk => reloj, 
											rst_n => contacto_llaves, 
											enable => marcha_puesta, 
											data_in => fsm_to_datapath,
											velocidad => velocidad_visualizada);

END estructural;