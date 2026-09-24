# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# REIO-Chain: Configuration de l'Horloge Principale (400 MHz Target)
# ---------------------------------------------------------------------------
create_clock -period 2.500 -name clk [get_ports clk]

# ---------------------------------------------------------------------------
# Protocole REIO: Floorplanning Manuel - Confinement Zone Haute Vitesse X0Y0
# ---------------------------------------------------------------------------
create_pblock pblock_REIO_Chain

# Filtrage chirurgical : Inclusion exclusive des LUTs, FF et Carry Logic (Exclusion du BUFG)
add_cells_to_pblock [get_pblocks pblock_REIO_Chain] [get_cells -hierarchical -filter {PRIMITIVE_GROUP == REGISTER || PRIMITIVE_GROUP == LUT || PRIMITIVE_GROUP == CARRY}]

# Restriction géographique stricte sur la matrice Artix-7 (xc7a35t)
resize_pblock [get_pblocks pblock_REIO_Chain] -add {CLOCKREGION_X0Y0:CLOCKREGION_X0Y0}

# ---------------------------------------------------------------------------
# Optimisation Physique et Directives de Placement de Précision
# ---------------------------------------------------------------------------
set_property CONTAIN_ROUTING TRUE [get_pblocks pblock_REIO_Chain]
set_property EXCLUDE_PLACEMENT TRUE [get_pblocks pblock_REIO_Chain]

# Application de la propriété ASYNC_REG sur les chaînes de synchronisation (FDRE)
set_property ASYNC_REG TRUE [get_cells -hierarchical -filter {NAME =~ *sync_reg*}]
