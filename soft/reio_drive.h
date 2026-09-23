#ifndef REIO_DRIVE_H
#define REIO_DRIVE_H

#include <stdint.h>
#include <stddef.h>

// Point d'entrée du Pont Invariant de la bibliothèque binaire Rust unifiée
// Inclut désormais la vérification de la validité temporelle de la licence (Time-bomb)
uint32_t verifier_flux_reio(const uint8_t *buffer_ptr, 
                            size_t taille, 
                            uint32_t annee_actuelle, 
                            uint32_t mois_actuel, 
                            uint32_t jour_actuel);

#endif // REIO_DRIVE_H
