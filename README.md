# ⚡ REIO-Chain: Lightweight Paraconsistent Logic Testbench on FPGA

This repository serves as a personal R&D portfolio showcasing a lightweight Proof of Concept (PoC) for paraconsistent trivalent logic (L3) design mapped onto standard binary hardware. 

* **Theoretical Framework:** [Read Paper on Zenodo](https://zenodo.org)
* **Official Registry DOI:** `10.5281/zenodo.20743411`

---

## 🔬 Core Implementation (VHDL & Rust)

The goal of this project is to model a minimal, low-footprint hardware disconnector layer designed to handle uncertain or corrupted states at the silicon level.

### 📊 Hardware Synthesis (AMD/Xilinx Vivado)
* **Resource Optimization:** Miniaturized logic architecture utilizing exactly **9 Slice LUTs** and **42 Registers** to maintain a deterministic **1-clock-cycle execution latency** (2.5 ns execution at 400 MHz).
* **Timing Closure:** Perfect execution path constraint inside the high-speed X0Y0 clock domain (TNS = 0.000 ns).

### 🦀 Software Bridge
* **Driver Interface:** Experimental **Rust `#[no_std]`** MMIO control layer for minimal software overhead.
* **C++ Binding:** Clean C-FFI binding for low-overhead software integration.

---

## 💼 Portfolio Purpose & Independent Consulting

This project is an open-source conceptual prototype and a demonstration of hardware/software co-design methodologies. The source code and reports are shared publicly to support my independent consulting services.

---

## 💼 Availability & Professional Inquiries

This repository serves as a technical showcase. I am available for high-end independent R&D consulting, custom RTL (VHDL/Verilog) modeling, and bare-metal Rust/C++ system integration.

* 🇧🇪 **Location:** Brussels, Belgium (Available for remote and on-site contracts across Europe).
* 👔 **Hire Me on Malt:** [View Professional Freelance Profile](https://fr.malt.be/profile/davidumbertoalvaro)
* ⚖️ **Billing & Compliance:** Fully administered and legally insured via the **SMART Belgique** structural framework.

---

## 🛡️ R&D Methodology: The REIO Forensique Validation Protocol

To mitigate any structural risks associated with AI-assisted software and RTL generation, this framework strictly operates under the **REIO (Réalisme Expérimental Instrumenté Optimisé)** protocol. Every logic block is subjected to rigorous hardware-in-the-loop and compiler cross-examinations:

1. **Syntax & Logical Auditing:** Automatic synthesis output is thoroughly parsed to eliminate dead logic constructs, redundant registers, or floating nets.
2. **Deterministic Silicon Mapping:** Hardware routing is strictly restricted and floorplanned via manual TCL layout constraints (`create_pblock`) within target high-speed matrices.
3. **Physical Timing Assurance:** Uncompromised timing closure enforcing exactly **400 MHz operational clock speeds** with a strictly monitored **Total Negative Slack (TNS) equal to 0.000 ns**. 

*Physical metrics on hardware constraints replace abstract text validation, ensuring a 100% stable, deterministic, and fail-safe production line.*
