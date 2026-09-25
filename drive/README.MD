## Synchronous Automotive Bus Interceptor & Fail-Safe Core (100 MHz APB Interface)

REIO-Drive (SPU_105) is a hardware-software Intellectual Property (IP Core) designed for real-time stream interception, hardware-level message filtering, and rapid deterministic mitigation for automotive CAN/LIN multiplexed networks. The architecture is split into a fault-tolerant RTL filtering stage and a hardened bare-metal control plane.

### 🔬 Certified Hardware Metrics (AMD/Xilinx Vivado v2026.1)

Implementation and post-routing layout evaluations on the AMD/Xilinx Artix-7 fabric certify the following hardware safety and timing metrics:

- **Control Clock Frequency (Rust):** Fully closed synchronous timing path under aggressive high-frequency constraints.
- **Worst Negative Slack (WNS):** Fully stabilized in the green with robust design margins and zero path violations.
- **Worst Hold Slack (WHS):** Fully optimized intra-site routing delays with strict positive hold time closure.
- **Deterministic Mitigation Delay:** Single-cycle hardware disjunction execution (1 clock cycle latency).

```text
+--------------------------------------------------------+

|                    APPLICATION HÔTE                    |
|   (Environnement AUTOSAR / Calculateur de Véhicule)    |
+--------------------------------------------------------+
                            |
                            | Liaison Directe (C-FFI Bridge)
                            v
+--------------------------------------------------------+

|                PILOTE DE CONTRÔLE RUST                 |
|   Configuration MMIO & Verrou Temporel (#![no_std])    |
+--------------------------------------------------------+
                            |
                            | Bus de Contrôle AMBA APB
                            v
+========================================================+

|                        SILICIUM                        |
| ------------------------------------------------------ |
|               DISJONCTEUR MATÉRIEL VHDL                |
|      Isolation du Bus & Machine d'États Lockstep       |
|                                                        |
|   [Optimized Slice LUTs]          [Registers]          |
|   [Single-Cycle Mitigation]       [Zero Violations]    |
+========================================================+
                            ^
                            | Interception Parallèle Haute Vitesse
                            | [ BUS CAN / LIN ]
```
