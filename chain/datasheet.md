# ⚡ REIO-Chain (SPU_103) — Technical Datasheet & Network Firewall Brief

## 1. Product Overview & Architectural Target
REIO-Chain (SPU_103) is an ultra-high-speed synchronous hardware network filter IP Core designed for inline packet monitoring, deterministic masking, and line-rate isolation of Layer 3 data streams, decoupling a 125 MHz line data plane from a 400 MHz control plane.

---

## 2. Electrical, Timing & Resource Metrics (Artix-7)
*Targeting `xc7a12tlcpg238-2L` via Vivado v2026.1.*

| Timing Parameter | Symbol | Target Specification | Validated Slack | Unit |
| :--- | :--- | :--- | :--- | :--- |
| **System Clock Frequency** | f_SYS | 400.00 | — | MHz |
| **Line Clock Frequency (PHY)** | f_RX | 125.00 | — | MHz |
| **Worst Negative Slack (Setup)** | WNS | — | **+1.596** | ns |
| **Worst Hold Slack (Hold)** | WHS | — | **+0.142** | ns |

*   **Device Static Power:** 56 mW
*   **Core Active Dynamic Power:** **1 mW**
*   **Estimated Junction Temperature:** 25.4 °C

---

## 3. Register Map & MMIO Control Plane Interface

| Offset Address | Register Name | Access | Width | Description / Functional Bitfield |
| :--- | :--- | :--- | :--- | :--- |
| `0x00` | `REG_CTRL` | R/W | 32 bits | [Bit 0]: Software Reset \| [Bit 1]: Force Manual Isolation |
| `0x04` | `REG_STATUS` | R | 32 bits | [Bit 0]: Security Status ('1'=Nominal, '0'=Isolated) |
| `0x08` | `REG_THREAT_SIG`| R/W | 8 bits | Target threat signature (Default: `0x7F`) |
| `0x0C` | `REG_CNT_CLEAN` | R | 32 bits | Counter for clean packets |
| `0x10` | `REG_CNT_ANOM`  | R | 32 bits | Counter for blocked anomalies |

---

## 4. Behavioral Timing Chronogram & Invariant Bounds

```text
                       ◀ Nominal Processing ▶◀ Surgical Isolation (1 Cycle)
                       0ns         2.5ns       5.0ns       7.5ns       10ns

                       |           |           |           |           |
SYS_CLK (400 MHz)   ___/¯¯¯¯\_____/¯¯¯¯\_____/¯¯¯¯\_____/¯¯¯¯\_____/¯¯¯¯\__
RESET (Active-High) ¯¯¯¯\__________________________________________________
FLUX_DATA_IN (64b)  XXXX🔀  0xAA  XXXXXXXXX🔀  0x7F  XXXXXXXXXXXXXXXXXXXXXX
                                              ▲ (Threat Signature Detected)
STATUT_SECURITE    ____________/¯¯¯¯¯¯¯¯¯¯¯¯¯¯\___________________________
                                               ▼ (Immediate Bus Disjunction)
DECLENCHER_SECOURS ___________________________/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
```

---

## 5. Software Control Plane Integration (Rust no_std)
The IP Core exposes a standard C-FFI boundary through `reio_chain.h`. The bare-metal driver guarantees execution with memory safety and zero dynamic allocation.

```rust
// Example of bare-metal volatile initialization for REIO control register
pub unsafe fn initialize_reio_chain(base_address: usize) {
    let ctrl_ptr = base_address as *mut u32;
    // Direct volatile write to activate synchronous monitoring
    core::ptr::write_volatile(ctrl_ptr, 0x01);
}
```

---

## 6. Commercial Integration & Portfolio Framework
The REIO-Chain (SPU_103) architecture is part of a professional co-design portfolio demonstrating hardware security filtering and advanced RTL constraints resolution.

*   **Consulting & Custom IP Adaptation:** Tailoring to custom networking fabrics, bus boundaries mitigation (CDC), and driver interfacing.
*   **Engagement Model:** Engineering missions are available under freelance contracts or payroll umbrella structures (**SMART Belgium** / direct enterprise contracts).
