#ifndef REIO_CHAIN_H
#define REIO_CHAIN_H

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

void reio_l3_set_runtime_threat_mask(uint32_t mask);

void reio_l3_set_paradox_trigger_mask(uint32_t mask);

uint32_t reio_l3_read_telemetry_counter(void);

#ifdef __cplusplus
}
#endif

#endif 
