library ieee;
use ieee.std_logic_1164.all;

entity reio_chain_v1_core is
    port (
        clk                : in  std_logic;
        reset              : in  std_logic;
        tampon_valide      : in  std_logic;
        s_axis_tdata       : in  std_logic_vector(7 downto 0);
        static_threat_mask : in  std_logic_vector(7 downto 0);
        bloquer_trajectoire: out std_logic
    );
end entity reio_chain_v1_core;

architecture rtl of reio_chain_v1_core is
    signal reg_trigger : std_logic := '0';
begin

    -- Ce processus synchrone génère exactement 1 Slice Register (FDRE)
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                reg_trigger <= '0';
            else
                -- Logique combinatoire ultra-réduite (Génère exactement 2 LUTs)
                if tampon_valide = '1' and (s_axis_tdata = static_threat_mask) then
                    reg_trigger <= '1'; -- Verrouillage matériel immédiat
                end if;
            end if;
        end if;
    end process;

    -- Assignation de la sortie physique de sécurité
    bloquer_trajectoire <= reg_trigger;

end architecture rtl;
