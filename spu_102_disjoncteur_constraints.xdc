# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# REIO-Chain: Configuration de l'Horloge Principale (400 MHz Target)
# =========================================================================
# 📌 CONFIGURATION TEMPORELLE ET CONSTRAINTES D'HORLOGES GTH (400 MHz / 2.5 ns)
# =========================================================================
create_clock -period 2.500 -name gt_refclk [get_ports gt_refclk_p]

# =========================================================================
# 📌 PLACEMENT GÉOMÉTRIQUE STRICT DES BROCHES PHYSIQUES (SFP+ Transceivers)
# =========================================================================
# Note : Ces coordonnées ciblent les banques de transceivers GTH d'un FPGA AMD UltraScale+/Artix-7
set_property PACKAGE_PIN Y6 [get_ports gt_refclk_p]
set_property PACKAGE_PIN Y5 [get_ports gt_refclk_n]

set_property PACKAGE_PIN W4 [get_ports sfp_rx_p]
set_property PACKAGE_PIN W3 [get_ports sfp_rx_n]
set_property PACKAGE_PIN V2 [get_ports sfp_tx_p]
set_property PACKAGE_PIN V1 [get_ports sfp_tx_n]

# =========================================================================
# 📌 SANCTUARISATION MATÉRIELLE ET RE-ZONAGE DE L'IP CORE PREMIUM (Floorplanning)
# =========================================================================
create_pblock pblock_REIO_SFP_Top
add_cells_to_pblock [get_pblocks pblock_REIO_SFP_Top] [get_cells -hierarchical -filter {PRIMITIVE_GROUP == REGISTER || PRIMITIVE_GROUP == LUT || PRIMITIVE_GROUP == CARRY}]
resize_pblock [get_pblocks pblock_REIO_SFP_Top] -add {CLOCKREGION_X0Y0:CLOCKREGION_X0Y0}

# Verrouillage pour empêcher la logique parasite de s'infiltrer dans la zone optique
set_property EXCLUDE_PLACEMENT TRUE [get_pblocks pblock_REIO_SFP_Top]
