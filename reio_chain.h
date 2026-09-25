
#ifndef REIO_CHAIN_H
#define REIO_CHAIN_H

#include <stdint.h>
#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct __attribute__((aligned(32))) {
    uint32_t clean_packets;
    uint32_t anomaly_hits;
    uint32_t soft_blocks;
    uint32_t corruption_ratio_permille;
    uint32_t critical_alert;
    // Padding de synchronisation cache (12 octets réservés)
    uint32_t _reserved0;
    uint32_t _reserved1;
    uint32_t _reserved2;
} ReioForensicReport;


void reio_l3_set_runtime_threat_mask(uint32_t mask);


void reio_l3_set_paradox_trigger_mask(uint32_t mask);


void reio_l3_get_diagnostic_report(ReioForensicReport* out_report);

#ifdef __cplusplus
}
#endif

#endif 
