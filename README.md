# ⚡ REIO-Chain: Lightweight Paraconsistent Logic Testbench on FPGA

[![DOI](https://zenodo.org)](https://zenodo.org)

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

* **Availability:** Available for freelance R&D, VHDL modeling, and firmware optimization services.
* **Contract Administration:** Legal compliance and corporate billing are structured through the **SMART Belgique** framework.
