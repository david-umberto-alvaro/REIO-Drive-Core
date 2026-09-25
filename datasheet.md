# TECHNICAL DATASHEET: REIO-Chain (SPU_103)
## VHDL Core & Bare-Metal Rust/C Control Plane Interface

## Ultra-Low Latency L3 Network Interceptor & Trivalent Paradox Mitigation Core
**Document Version:** 2026.3.2  
**Classification:** Technical Portfolio / Open-Core Verification  
**Core Architect:** David Umberto Alvaro  

---

## 1. EXECUTIVE OVERVIEW

The **REIO-Chain (SPU_103)** is a hardware-proven, nanosecond-class Intellectual Property (IP) block designed for wire-speed Layer 3 (L3) packet interception, decoding, and deterministic mitigation. It features a native **Trivalent Logic Engine** implemented under aerospace-grade constraints and a memory-mapped, bare-metal **Rust control plane**.

---

## 2. ARCHITECTURAL METRICS & PERFORMANCE

All metrics are hardware-verified through full placement and routing via AMD/Xilinx Vivado v2026.1 targeting an Artix-7 fabric in an Out-of-Context (OOC) structural compilation profile.

* **Target Clock Frequency:** 400.000 MHz (Clock Period: 2.500 ns)
* **Worst Negative Slack (WNS):** +0.246 ns
* **Worst Hold Slack (WHS):** +0.199 ns
* **Worst Pulse Width Slack (WPWS):** +0.750 ns
* **Total Pulse Width Slack (TPWS):** 0.000 ns

## 3. RESOURCE UTILIZATION PROFILE
* **Slice LUTs (as Logic):** 46 (0.58% of xc7a12t fabric)
* **Slice Registers (as Flip-Flops):** 142 (0.89% of xc7a12t fabric)
* **Hardware Primitives utilized:** FDCE (142), LUT2 (35), CARRY4 (24), LUT1 (4), LUT3 (3), LUT4 (2), LUT6 (1), LUT5 (1)

---

## 4. THERMAL & POWER SIGNATURE

Derived from the static and dynamic vector analysis layout (`power_routed.rpt`):
* **Total On-Chip Power Dissipation:** 0.060 W (60 mW)
* **Core Logic Dynamic Power:** 0.004 W (4 mW)
* **Device Static Power:** 0.056 W (56 mW)
* **Junction Temperature:** 25.4°C (at 25.0°C Ambient)

---

## 5. HARDWARE-SOFTWARE CO-DESIGN SPECIFICATIONS

```text
       +-----------------------------------------------------------+

       |                                                           |
       |                  REIO-Chain Core Module                   |
       |                                                           |
       +-----------------------------------------------------------+
AXI4-Stream Inbound In ===> | [Intercepteur] -> [Kill-Switch] | ===> Out
       +-----------------------------------------------------------+
             |                           ^

             |                           |
             v [Axi-Lite MMIO Bus]       | [Override / Unmask]
       +-----------------------------------------------------------+

       |     | Télémétrie 32-bit         | Registres de Contrôle    |
       |     v                           v                         |
       |                                                           |
       |               Rust Control Plane (#[no_std])              |
       |               Interface C-FFI / Librairie C++             |
       |                                                           |
       +-----------------------------------------------------------+
```

### 🧬 Trivalent Logic Enforcement
The core processes Layer 3 network vectors by resolving non-binary conditional statements inspired by Lukasiewicz paraconsistent algebra. It forces incoming stream variables into explicit, bounded states to instantly isolate structural anomalies within a 2.5 ns execution window:
* `STATE_NEUTRAL (00)`: Equilibrium mode, line-rate bypass.
* `STATE_ACTIVE  (01)`: Valid payload rule match engaged.
* `STATE_GROUND  (10)`: Hardware-level safe lockdown.
* `STATE_INVALID (11)`: Structural paradox or illegal bit combination caught.

### 🛡️ Metastability & Reliability Controls
* **Asynchronous Boundary Isolation:** The software registers driven by the control plane are bounded through a cascaded 2-stage flip-flop synchronization tree hardwired with `ASYNC_REG` structural placement parameters.
* **Latch Leakage Prevention:** Built with dedicated sequential latch protection registers (`r_latch_state`) to eliminate asynchronous glitch propagation down the network stream.

### 🦀 Driver Runtime Environment (Rust 2024 Stricte)
* **Compilation Constraints:** Built under `#![no_std]` bare-metal specifications for direct cross-compilation target `thumbv7m-none-eabi`.
* **Zero OS Overhead:** Safe, non-allocating memory interactions executed through `write_volatile` and `read_volatile` pointer abstractions mapped directly to AXI-Lite MMIO register segments.
* **Panic Isolation:** Implements an atomic corporate `#[panic_handler]` loop preventing unwinding bloat, ensuring maximum software execution determinism.
