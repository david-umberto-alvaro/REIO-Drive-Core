# REIO-Drive (SPU_105) — Technical Datasheet & Product Brief

## ⚡ 1. Product Overview & Classifications
REIO-Drive (SPU_105) is a compact hardware security monitor core designed as a Proof of Concept (PoC) for low-latency line-level interception on multiplexed automotive and industrial control buses.

*   **Design Philosophy:** Conçu selon les principes d'architecture de sûreté de fonctionnement (Functional Safety) inspirés des exigences ISO 26262 / ASIL-D, mettant en œuvre une machine d'états (FSM) redondante en logique Lockstep.
*   **Testing Coverage:** Validated via synchronic RTL testbenches focusing on clock-cycle deterministic state transitions and fault isolation.

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

## ⚙️ 4. Software Control Plane & Memory-Mapped Interface (MMIO)
S'agissant d'un cœur logique de filtrage combinatoire pur (Stream IP Core), le circuit ne dispose pas de décodeur d'adresse interne ni de registres de configuration configurables en écriture. 

*   **Host Interfacing (MMIO) :** Les lignes de sortie matérielles `statut_securite` et `declencher_secours` sont connectées directement aux registres d'E/S (GPIO) cartographiés en mémoire du processeur hôte.
*   **Rust Control Plane :** Le pilote écrit en Rust bare-metal (`#![no_std]`) effectue des lectures asynchrones et déterministes de ces broches d'état en mémoire physique (Volatile MMIO Reads). Cela permet au logiciel de sécurité de lever instantanément une exception ou d'activer le mode dégradé (Fail-Safe) du véhicule dès que le matériel applique la disjonction.

---

## ⚖️ 5. Intégration Portfolio & Modèle de Consultance Freelance

L'architecture REIO-Drive (SPU_105) constitue un démonstrateur de sûreté de fonctionnement matériel (PoC gelé) destiné à illustrer la modélisation de machines d'états en logique redondante (Lockstep).

*   **Exploitation Professionnelle :** Ce module sert de base d'évaluation pour démontrer des compétences en prototypage rapide et en architecture de systèmes embarqués sécurisés.
*   **Modèle de Prestation :** Prestations de services et de co-conception hardware/software facturables au Tarif Journalier Moyen (TJM) via la structure SMART Belgique.
*   **Contact & NDA :** Les demandes d'analyse architecturale ou d'adaptation de ce bloc de sûreté pour vos prototypes industriels se font sous accord de confidentialité (NDA) via les réseaux professionnels.

