# REIO-Drive (SPU_105) — Technical Datasheet & Product Brief

## 📋 1. Product Overview & Classifications
REIO-Drive Core v1.0 is a safety-critical hardware-software guardrail designed to instantly isolate and mitigate malicious frame injections or data corruption on embedded networks.
* **Functional Safety:** Designed for ISO 26262 ASIL-D and DO-254 compliance (SEooC - Safety Element out of Context).
* **Testing Coverage:** 100% MC/CD (Modified Condition/Decision Coverage) validated via automated HDL testbenches.

---

## 🔌 2. Signal Specifications & I/O Mapping (VHDL Component)

The core acts as a synchronous hardware firewall blocking frame-level anomalies within 1 clock cycle.

| Signal Name | Direction | Width (Bits) | Type | Description |
| :--- | :--- | :--- | :--- | :--- |
| `clk` | Input | 1 | `STD_LOGIC` | System Clock (100 MHz target for APB bus validation) |
| `reset` | Input | 1 | `STD_LOGIC` | Asynchronous System Reset (Active High) |
| `flux_data_in` | Input | 8 | `STD_LOGIC_VECTOR` | Parallel incoming frame payload byte from the transceiver |
| `flux_valid_in` | Input | 1 | `STD_LOGIC` | Data valid strobe from physical layer |
| `statut_securite` | Output | 1 | `STD_LOGIC` | Active high hardware status flag ('1' = Nominal, '0' = Isolated) |
| `declencher_secours`| Output | 1 | `STD_LOGIC` | Critical safety override trigger output logic line ('1' = Active) |

---

## ⚙️ 3. Operational Logic & Invariant Bounds

```text
    STIMULI TIMING CHRONOGRAM (RTL BEHAVIORAL VERIFICATION)
    
               +--- 20ns ---+--- 50ns ---+--- 70ns ---+--- 80ns ---+
    CLK        | _/¯\_/¯\_/¯ | _/¯\_/¯\_/¯ | _/¯\_/¯\_/¯ | _/¯\_/¯\_/¯ |
    RESET      | ¯¯¯¯¯¯¯¯¯¯¯ | ____________ | ____________ | ____________ |
    FLUX_DATA  | 0x00        | 0xAA (Valid) | 0x7F (Threat)| 0x7F        |
    STATUT_SEC | 0           | 1            | 1            | 0 (ISOLATE) |
    DECLEN_SEC | 1           | 0            | 0            | 1 (EMERGENCY)
```

### Phase Description:
* **Initialization (0ns – 50ns):** While `reset` is active, the core forces safe system confinement (`statut_securite = '0'`, `declencher_secours = '1'`).
* **Nominal Processing (50ns – 70ns):** Valid incoming data drives the system into functional state.
* **Surgical Isolation (70ns – 80ns+):** Detection of the threat signature (`0x7F`) triggers full hardware disjunction in **exactly one clock cycle**.

---

## 💻 4. Software Control Plane (Rust Bare-Metal / C Bridge)
* **Execution:** Zero dynamic allocation (`#[no_std]`, no heap), mathematical overflow protection against buffer overflows.
* **Host Interfacing:** Integrated via the bilingual C-FFI header `reio_drive.h`. Requires only 5 lines of code within the client host's main execution loop.

---

## ⚖️ 5. Commercial B2B Licensing & Pricing Model (Europe / BeNeLux)

The SPU_105 core architecture is available under three flexible B2B procurement models:

* **Option 1: Software License (Fixed Fee) | €4,500 (One-time payment)**
  * Includes the compiled standalone Rust library (`.a` / `.lib`), `reio_drive.h` header, and 30 days of integration support.
* **Option 2: Core Hardware IP Source (Buyout) | €35,000 (Unlimited usage)**
  * Includes full access to the encrypted proprietary VHDL source code `reio_drive_hardware.vhd`, automated Testbench scripts, and synthesis `.sdc` timing constraint templates.
* **Option 3: Royalties / Volume Licensing | €150 / Machine / Year**
  * Distributed deployment option backed by an active automated hardware validation license clock.
