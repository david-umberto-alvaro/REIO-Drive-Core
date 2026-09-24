# ⚡ REIO-Chain: Ultra-Low Latency Hardware/Software Co-Design Framework

Welcome to the official repository of the REIO-Chain framework, a Ultra-Low Latency Layer-2 synchronous wire-speed network arbitrator and disconnector sub-system engineered for ultra-low latency High-Frequency Trading (HFT) fabrics and critical infrastructure protection.

This architecture implements the paraconsistent trivalent logic (L3) matrix detailed in our registered scientific paper, providing physical-layer immunization against fault injections and data corruption.
* **Scientific Blueprint:** [Read Specifications on Zenodo](https://zenodo.org)
* **Official Registry DOI:** `10.5281/zenodo.20743411`

---

## 💼 Dual-Licensing Distribution Model

To foster academic research while protecting high-end corporate intellectual property, REIO-Chain is distributed under a strict dual-licensing matrix:

### 🌐 1. Community Edition (REIO-Chain v1 Core) — Open Source
* **Licensing:** Distributed under the **GNU GPL v3 License**.
* **Access:** 100% open-source RTL source code available in the `/chain/v1` directory.
* **Scope:** Standard synchronous wire-level frame arbitration. Ideal for academic sandboxes, testing, and open R&D.
* *Note: According to GPLv3 terms, any commercial integration or derivative work must also disclose its full source code.*

### 🚀 2. Enterprise Edition (REIO-Chain v3 Premium) — Proprietary
* **Licensing:** Commercial Proprietary Site License (Royalty-Free deployment, exempt from GPL restrictions).
* **Access:** Closed-source. Blueprints, native AXI4-Stream sub-systems, and drivers are isolated and delivered exclusively under corporate NDA.
* **Scope:** High-speed AMD/Xilinx Artix-7 optimized fabric (9 Slice LUTs, 42 Registers, 2.5 ns deterministic hardware execution latency at 400 MHz), including a monolithic bare-metal Rust `no_std` driver and a zero-overhead C++ FFI binding.

---

## 🗂️ Repository Structure

* **`[ /chain/v1 ]`** — Community Edition. Contains the open-source VHDL core logic files under GPLv3.
* **`[ /chain/v3 ]`** — Enterprise Edition Showroom. Houses official Vivado behavioral simulation waveforms, routed clock-tree utilization reports (`.rpt`), and technical datasheets proving physical timing closure (`TNS = 0.000 ns`).

---

## 📧 Evaluation Sandbox & Corporate Licensing

Corporate engineering teams seeking to evaluate the **v3 Enterprise Edition** inside their hardware-in-the-loop (HIL) environments can request a binarized sandbox package (Pre-compiled Out-of-Context `.dcp` netlist and static `.a` software libraries).

Delivery requires the signature of a unilateral Non-Disclosure Agreement (NDA) and is legally administered through the **SMART Belgique** structural framework to guarantee secure asset assignment.

*For business inquiries, commercial licensing quotes, or NDA drafting, please contact the lead hardware architect directly via private messaging.*
