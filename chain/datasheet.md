# ⚡ REIO-Chain (SPU_103) — Technical Datasheet & Network Firewall Brief

## 1. Product Overview & Architectural Target
REIO-Chain (SPU_103) is an ultra-high-speed synchronous hardware network filter IP Core designed for inline packet monitoring, deterministic masking, and line-rate isolation of Layer 3 data streams, decoupling a 125 MHz line data plane from a 400 MHz control plane.

---

## 2. Electrical, Timing & Resource Metrics (Artix-7)
*Certified post-placement-routing metrics under AMD/Xilinx Vivado v2026.1 targeting the xc7a35tcsg324-1 component (Commercial Temperature Grade).*

### Power & Thermal Dissipation Profile:

- **Device Static Power:** 72 mW (Hardware static floor post-routing).
- **Core Active Dynamic Power (REIO-Core):** < 1 mW (Total design dynamic power including I/Os is validated at 2 mW).
- **Max Admissible Ambient Temperature ($T_{AMB\_MAX}$):** Validated at **84.6 °C** under standard thermal constraints (ThetaJA = 4.8 C/W, 250 LFM airflow), fully stable for baseline operating conditions.

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

◀------- Nominal Processing -------▶◀---- Surgical Isolation (1 Clock Cycle Latency) ----
0ns                 5ns                10ns               15ns               20ns

|                   |                  |                  |                  |
   ______             ______             ______             ______             ______
__/      \___________/      \___________/      \___________/      \___________/      \_  SYS_CLK (100 MHz)
____
    \__________________________________________________________________________________  RESET (Active-High)
__________ ______________________________________ _____________________________________
XXXXX_0xAA_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX_0x7F_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX  CAN_RX_RAW (1 bit)
                                                      ▲ (Threat Signature Injected)
_______________________________________________________
                                                       \_______________________________  FAIL_SAFE_MODE (1->0)
                                                        ▼ (Triggered on next rising edge)


---

## 5. Software Control Plane Integration (Rust no_std)
The IP Core exposes a standard C-FFI boundary through `reio_chain.h`. The bare-metal driver guarantees execution with memory safety and zero dynamic allocation.

---

## 6. Commercial Integration & Portfolio Framework
The REIO-Chain (SPU_103) architecture is part of a professional co-design portfolio demonstrating hardware security filtering and advanced RTL constraints resolution.

*   **Consulting & Custom IP Adaptation:** Tailoring to custom networking fabrics, bus boundaries mitigation (CDC), and driver interfacing.
*   **Engagement Model:** Engineering missions are available under freelance contracts or payroll umbrella structures (**SMART Belgium** / direct enterprise contracts).

> 💡 **Engineering Note:** While the current open-core hardware implementation reports are targeted and verified on a commercial-grade matrix (xc7a35tcsg324-1) for physical footprint validation, the architecture's Dual-Core Lockstep (DCLS) RTL logic is natively prepared for migration to extended automotive temperature grades down to qualification boundaries.
