-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity control_fsm is

	port(
		clk		 : in	std_logic;
		keys	 : in	std_logic;
		brake	 : in	std_logic;
		accelerate	 : in	std_logic;
		output	 : out	std_logic_vector(1 downto 0)
	);

end entity;

architecture rtl of control_fsm is

	-- Build an enumerated type for the state machine
	type state_type is (stop, slow, medium, fast);

	-- Register to hold the current state
	signal state   : state_type;

begin

	-- Logic to advance to the next state
	process (clk,keys)
	begin
		if keys = '0' then
			state <= stop;
		elsif (rising_edge(clk)) then
			case state is
				when stop=>
					if accelerate = '1' AND brake = '0' then
						state <= slow;
					end if;
				when slow=>
					if accelerate = '1' AND brake = '0' then
						state <= medium;
					elsif accelerate = '0' AND brake = '1' then
						state <= stop;
					elsif accelerate = '1' AND brake = '1' then
						state <= stop;
					end if;
				when medium=>
					if accelerate = '1' AND brake = '0' then
						state <= fast;
					elsif accelerate = '0' AND brake = '1' then
						state <= slow;
					elsif accelerate = '1' AND brake = '1' then
						state <= stop;
					end if;
				when fast =>
					if accelerate = '0' AND brake = '1' then
						state <= medium;
					elsif accelerate = '1' AND brake = '1' then
						state <= stop;
					end if;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when stop =>
				output <= "00";
			when slow =>
				output <= "01";
			when medium =>
				output <= "10";
			when fast =>
				output <= "11";
		end case;
	end process;

end rtl;
