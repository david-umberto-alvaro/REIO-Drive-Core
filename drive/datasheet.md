# REIO-Drive (SPU_105) — Hardware Interface Datasheet

## 🔌 Signal Specifications & I/O Mapping

The SPU_105 core acts as a synchronous hardware guardrail between the vehicle's communication controller and the physical transceiver lines. It monitors bus activity at the clock cycle level to execute deterministic mitigation.

### 🎛️ Top-Level Entity Ports

| Signal Name | Direction | Width (Bits) | Type | Description |
| :--- | :--- | :--- | :--- | :--- |
| `clk` | Input | 1 | `STD_LOGIC` | System Clock (100 MHz target for APB bus validation) |
| `reset` | Input | 1 | `STD_LOGIC` | Asynchronous System Reset (Active High) |
| `flux_data_in` | Input | 8 | `STD_LOGIC_VECTOR` | Parallel incoming frame payload byte from the network link |
| `flux_valid_in` | Input | 1 | `STD_LOGIC` | Data valid strobe from the network transceiver layer |
| `statut_securite` | Output | 1 | `STD_LOGIC` | Active high hardware status flag ('1' = Nominal, '0' = Attack intercepted / Isolated) |
| `declencher_secours`| Output | 1 | `STD_LOGIC` | Critical safety override trigger output logic line ('1' = Active fail-safe deployment) |

---

## ⚙️ Operational Logic & Invariant Bounds

```text
    STIMULI TIMING CHRONOGRAM (RTL BEHAVIORAL VERIFICATION)
    
               +--- 20ns ---+--- 50ns ---+--- 70ns ---+--- 80ns ---+
    CLK        | _/¯\_/¯\_/¯ | _/¯\_/¯\_/¯ | _/¯\_/¯\_/¯ | _/¯\_/¯\_/¯ |
    RESET      | ¯¯¯¯¯¯¯¯¯¯¯ | ____________ | ____________ | ____________ |
    FLUX_DATA  | 0x00        | 0xAA (Valid) | 0x7F (Threat)| 0x7F        |
    STATUT_SEC | 0           | 1            | 1            | 0 (ISOLATE) |
    DECLEN_SEC | 1           | 0            | 0            | 1 (EMERGENCY)
```

### 1. Reset / Initialization Phase (0ns – 50ns)
* While `reset` is held high, the circuit enforces a passive containment state. 
* **Hardware Invariant:** `statut_securite` is forced to `'0'` and `declencher_secours` is asserted to `'1'`, preventing any unvalidated frame propagation during system boot.

### 2. Transparent Nominal Stream Mode (50ns – 70ns)
* Upon clearing `reset`, the arrival of standard network frames (e.g., `0xAA`) with active data strobes shifts the core into transparent throughput.
* **Hardware Invariant:** `statut_securite` transitions to `'1'` and `declencher_secours` is pulled to `'0'`.

### 3. Surgical Single-Cycle Interception (70ns – 80ns+)
* The introduction of the critical entropy signature `0x7F` directly violates the bus integrity bounds.
* On the immediate next **rising_edge(clk)**, the combinatorial matrix flags the payload.
* **Hardware Invariant:** Within exactly **one clock cycle**, `statut_securite` drops to `'0'` (physical bus isolation) and `declencher_secours` rises to `'1'` to route backup instructions.

---

## 🛡️ Functional Safety Metrics (ISO 26262 ASIL-D Ready)

* **Determinism:** Absolute mitigation latency locked at exactly 1 clock period (10 ns at 100 MHz), completely agnostique of host processor software utilization or task queues.
* **Fail-Safe Fallback:** Any loss of clock or internal parity mismatch within the Lockstep FSM array automatically drops the entity back into the default hardware state (`statut_securite = '0'`, `declencher_secours = '1'`).
