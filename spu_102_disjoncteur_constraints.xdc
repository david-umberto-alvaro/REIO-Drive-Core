# ---------------------------------------------------------------------------
# REIO-Chain: Configuration de l'Horloge Principale (400 MHz Target)
# ---------------------------------------------------------------------------
create_clock -period 2.500 -name clk [get_ports clk]

# ---------------------------------------------------------------------------
# Protocole REIO: Floorplanning Manuel - Confinement Zone Haute Vitesse X0Y0
# ---------------------------------------------------------------------------
create_pblock pblock_REIO_Chain
add_cells_to_pblock [get_pblocks pblock_REIO_Chain] [get_cells -hierarchical *]

# Restriction géographique stricte sur la matrice Artix-7 (xc7a35t)
resize_pblock [get_pblocks pblock_REIO_Chain] -add {CLOCKREGION_X0Y0:CLOCKREGION_X0Y0}

# ---------------------------------------------------------------------------
# Optimisation Physique et Directives de Placement de Précision
# ---------------------------------------------------------------------------
set_property CONTAIN_ROUTING TRUE [get_pblocks pblock_REIO_Chain]
set_property EXCLUDE_PLACEMENT TRUE [get_pblocks pblock_REIO_Chain]

# Forcer le regroupement ultra-dense des bascules FDRE de synchronisation
set_property ASYNC_REG TRUE [get_cells -hierarchical *sync_reg*]
