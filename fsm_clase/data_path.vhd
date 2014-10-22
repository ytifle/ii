library ieee;
use ieee.std_logic_1164.all; 

ENTITY data_path IS
	GENERIC (num_bits:POSITIVE :=4);
	PORT (clk : IN STD_LOGIC; -- Activo por flanco de subida
			rst_n : IN STD_LOGIC; -- Activo por nivel bajo
			enable : IN STD_LOGIC; -- Activo por nivel alto
			data_in : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			velocidad: OUT STD_LOGIC_VECTOR (num_bits -1 DOWNTO 0)
			);
END data_path;

ARCHITECTURE estructural OF data_path IS

    COMPONENT decoder_2_4	PORT    (ent_selec: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
												salidas: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
                                    ); 
    END COMPONENT;

	 COMPONENT reg_pp_algorithm	GENERIC (num_bits:POSITIVE :=4);
											PORT	(clk_ri : IN STD_LOGIC;
													rst_n : IN STD_LOGIC;
													enable_e : IN STD_LOGIC;
													data_in : IN STD_LOGIC_VECTOR (num_bits -1 DOWNTO 0);
													data_out: OUT STD_LOGIC_VECTOR (num_bits -1 DOWNTO 0)
													); 
    END COMPONENT;
	 
	 SIGNAL deco_to_reg_pp: STD_LOGIC_VECTOR (3 DOWNTO 0);
	 
	 FOR ALL: reg_pp_algorithm USE ENTITY WORK.reg_pp_algorithm(behavior);
	 FOR ALL: decoder_2_4 USE ENTITY WORK.decoder_2_4(comporta);
	 
	 BEGIN
	 
	 decoder: decoder_2_4 PORT MAP( 	ent_selec => data_in, 
											salidas => deco_to_reg_pp);
											
	 latchT1: reg_pp_algorithm	GENERIC MAP (num_bits => 4)
								PORT MAP(clk_ri => clk, 
											rst_n => rst_n,
											enable_e => enable,
											data_in => deco_to_reg_pp,
											data_out => velocidad); 
	 
END estructural;
