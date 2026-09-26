# REIO-Chain (SPU_103) — Technical Datasheet & Product Brief

## ⚡ 1. Product Overview & Classifications
REIO-Chain (SPU_103) is a ultra-high-speed hardware network filter core designed to instantly isolate and mitigate malicious frame injections or data corruption on synchronous parallel networks.

*   **Functional Safety:** Optimized for low-latency line-rate deterministic data streams.
*   **Testing Coverage:** 100% RTL Timing Closure (Worst Negative Slack validated) monitored via automated RTL testbenches.

---

## 🔌 2. Signal Specifications & I/O Mapping (VHDL Component)
The core acts as a synchronous hardware firewall blocking line-level anomalies within 1 clock cycle (2.5 ns).

| Signal Name | Direction | Width (Bits) | Type | Description |
| :--- | :--- | :--- | :--- | :--- |
| `sys_clk` | Input | 1 | STD_LOGIC | System clock (**400 MHz** target for line-rate validation) |
| `phy_rx_clk`| Input | 1 | STD_LOGIC | Network Interface Clock (125 MHz asynchronous interface) |
| `reset` | Input | 1 | STD_LOGIC | Asynchronous system reset (Active-High) |
| `flux_data_in` | Input | 64 | STD_LOGIC_VECTOR | Parallel incoming high-speed packet payload from bus lines |
| `flux_valid_in`| Input | 1 | STD_LOGIC | Data valid strobe from line physical layer |
| `statut_securite`| Output | 1 | STD_LOGIC | Active high hardware status flag ('1' = Nominal, '0' = Isolated) |
| `declencher_secours`| Output | 1 | STD_LOGIC | Critical security override trigger output logic line ('1' = Active) |

---

## 📊 3. Operational Logic & Invariant Bounds

```text
TIMING CHRONOGRAM (RTL BEHAVIORAL VALIDATION)

                0ns      2.5ns    5.0ns    7.5ns    10ns

                 |        |        |        |        |
SYS_CLK      ____/¯¯¯¯\____/¯¯¯¯\____/¯¯¯¯\____/¯¯¯¯\____
RESET        ¯¯¯¯\_______________________________________
FLUX_DATA    XXXXX🔀 0xAA XXXXXXXX🔀 0x7F (Threat) XXXXXXXX
STATUT_SEC   ____________/¯¯¯¯¯¯¯¯\______________________ (ISOLATE)
DECLEN_SEC   _____________________/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ (EMERGENCY)
```

### Phase Description:
*   **Initialization (0ns - 2.5ns):** While `reset` is active, the core forces safe system confinement (`statut_securite = '0'`, `declencher_secours = '1'`).
*   **Nominal Processing (2.5ns - 5.0ns):** Valid incoming data drives the system into functional state.
*   **Surgical Isolation (5.0ns - 7.5ns+):** Detection of the threat signature (`0x7F`) triggers full hardware disjunction in **exactly one clock cycle (2.5 ns)**.

---

## ⚙️ 4. Software Control Plane (Rust Bare-Metal / C Bridge)
*   **Execution:** Zero dynamic allocation (`#![no_std]`, no heap), mathematical overflow protection against buffer overflows.
*   **Host Interfacing:** Integrated via the bilingual C-FFI header `reio_chain.h`. Requires only 5 lines of code within the client host's main execution loop.

---

## ⚖️ 5. Intégration Portfolio & Modèle de Consultance Freelance

L'architecture REIO-Chain (SPU_103) est présentée exclusivement en tant que Proof of Concept (PoC) technologique pour démontrer des compétences en co-design et en fermeture de contraintes temporelles strictes sous AMD/Xilinx Vivado.

*   **Exploitation Professionnelle :** Le code source sous-jacent et les scripts d'automatisation associés sont transférables et intégrables dans vos infrastructures matérielles dans le cadre de missions de consultance en ingénierie.
*   **Modèle de Prestation :** Interventions techniques disponibles au Tarif Journalier Moyen (TJM) standard du marché via des contrats de portage salarial (SMART Belgique) ou contrats de prestation directs.
*   **Audit approfondi :** Pour toute demande d'intégration sur mesure, d'analyse de métastabilité ou d'extension d'architecture, veuillez me contacter directement via mes canaux professionnels associés.
