#ifndef REIO_DRIVE_H
#define REIO_DRIVE_H

#include <stdint.h>
#include <stddef.h>

typedef enum {
    REIO_SUCCESS          = 0x00,
    REIO_ERROR_CORRUPTION = 0x01,
    REIO_ATTACK_DETECTED  = 0x02,
    REIO_LICENSE_EXPIRED  = 0x03,
    REIO_INVALID_PARAM    = 0X04
} reio_status_t;

#ifdef __cplusplus
extern "C" {
#endif

reio_status_t verifier_flux_reio(const uint8_t *buffer_ptr, size_t taille);

#ifdef __cplusplus
}
#endif
