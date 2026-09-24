# ⚡ REIO-Chain: Ultra-Low Latency Hardware Disconnector on FPGA

Ce dépôt présente un disjoncteur matériel ultra-rapide et économe en ressources pour les chemins critiques, servant de portfolio R&D en co-conception matériel/logiciel. Pour consulter le contenu complet du fichier README et ses détails techniques, veuillez vous référer au document source.

## 🔬 Core Implementation (VHDL & Rust)

L'architecture déploie une couche de filtrage en ligne déterministe pour une interruption immédiate du flux.

### 📊 Hardware Synthesis (AMD/Xilinx Vivado)
- **Optimisation :** Architecture RTL utilisant **9 Slice LUTs** et **42 Slice Registers**.
- **Primitives :** Utilisation de **CARRY4** et **42 registres FDRE**.
- **Timing :** Fermeture temporelle parfaite avec un **TNS égal à 0.000 ns**.

### 📊 Simulation Proof
![Simulation Premium Proof](simulation_rust.png)
*Chronogramme d'interception synchrone.*

### 🦀 Software Control Plane
- **Driver :** Couche de contrôle MMIO en **Rust #[no_std]**.
- **Binding :** Pont C-FFI bas niveau.

## 💼 Portfolio Purpose & Independent Consulting
Vitrine technique pour prestations de conseil en R&D, modélisation RTL et intégration système.
- **Localisation :** Bruxelles, Belgique.
- **Facturation :** Cadre SMART Belgique.

## 🛡 R&D Methodology
Protocole **REIO (Réalisme Expérimental Instrumenté Optimisé)** pour la validation physique et l'assurance temporelle.
