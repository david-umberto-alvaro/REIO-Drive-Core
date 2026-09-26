# 🚗 REIO-Drive (SPU_105) — Fiche Technique Industrielle & Sécurité Automobile

## 1. Description Générale & Objectifs de Sécurité (Safety)
REIO-Drive (SPU_105) est un sous-système matériel d'interception et de protection active (Hardware Shield) pour les bus de communication embarqués automobiles **CAN** (Controller Area Network) et **LIN** (Local Interconnect Network). 

Conçu pour faire face aux injections de trames malveillantes ou aux défaillances matérielles de type *babbling idiot*, le cœur s'interpose physiquement entre le transcepteur (Transceiver) et le contrôleur de protocole pour isoler chirurgicalement le nœud défaillant.

### Métriques de Sûreté de Fonctionnement (ISO 26262) :
*   **Niveau d'Intégrité :** Aligné **ASIL-D** (Niveau de criticité le plus élevé du secteur automobile).
*   **Architecture Matérielle :** Configuration **Dual-Core Lockstep (DCLS)** avec logique de comparaison cycle à cycle et confinement immédiat en mode *Fail-Safe*.
*   **Objectif de Temps de Tolérance aux Pannes (FTTI) :** Confinement et isolement du bus garantis en **moins de 10 microséconndes (µs)** (Interception logique interne en 1 seul cycle machine à 100 MHz).

---

## 2. Caractéristiques Électriques et Temporelles (Artix-7)
*Spécifications certifiées après placement-routage sous AMD/Xilinx Vivado v2026.1 sur cible xc7a12tlcpg238-2L (Grade de température étendu pour l'automobile : -40°C à +125°C).*

| Paramètre Temporel | Symbole | Spécification Target | Slack Validé | Unité |
| :--- | :--- | :--- | :--- | :--- |
| **Fréquence Horloge Cœur** | \(f_{CLK}\) | 100.00 | — | MHz |
| **Période Horloge Cœur** | \(T_{CLK}\) | 10.00 | — | ns |
| **Worst Negative Slack (Setup)**| WNS | — | **+7.606** | ns |
| **Worst Hold Slack (Hold)** | WHS | — | **+0.279** | ns |
| **Temps de Réponse Lockstep** | \(T_{LOCK}\) | **10.00 (1 Cycle)** | Conforme | ns |

### Profil Thermique et Énergie :
*   **Puissance Statique Dissipée :** 56 mW (Fixe silicium).
*   **Puissance Dynamique Active du Cœur :** < 1 mW.
*   **Marge Thermique Globale :** Température maximale ambiante admissible (\(T_{AMB\_MAX}\)) calculée à **99.6 °C** sous enveloppe thermique standard, parfaitement compatible avec les contraintes d'habitacle ou de baie électronique moteur.

---

## 🔌 3. Spécifications des Signaux & Brochage (I/O Mapping)

| Nom du Signal | Direction | Largeur | Type | Description / Rôle Physique |
| :--- | :--- | :--- | :--- | :--- |
| `sys_clk` | Input | 1 bit | STD_LOGIC | Horloge système principale (100 MHz) |
| `reset` | Input | 1 bit | STD_LOGIC | Réinitialisation matérielle synchrone (Active-High) |
| `can_rx_raw` | Input | 1 bit | STD_LOGIC | Flux brut en provenance du Transceiver physique CAN |
| `can_rx_filtered`| Output | 1 bit | STD_LOGIC | Flux sécurisé et filtré vers le contrôleur CAN hôte |
| `lockstep_error` | Output | 1 bit | STD_LOGIC | Drapeau d'erreur asymétrique miroir ('1' = Divergence matérielle) |
| `fail_safe_mode` | Output | 1 bit | STD_LOGIC | Ligne de contrôle d'isolement ('1' = Nominal, '0' = Relais coupé) |

---

## ⚙ 4. Cartographie des Registres et Interface MMIO (Memory Map)
*Accès direct via le plan de contrôle Rust bare-metal (`#![no_std]`). Alignement strict sur 32 bits.*

| Adresse Offset | Registre | Type | Description / Fonction |
| :--- | :--- | :--- | :--- |
| `0x00` | `DRV_REG_CTRL` | R/W | [Bit 0] : Force mode Fail-Safe \| [Bit 1] : Reset compteurs d'erreurs |
| `0x04` | `DRV_REG_STAT` | R | [Bit 0] : Lockstep Status \| [Bit 1] : Bus CAN Isolation State |
| `0x08` | `DRV_REG_CAN_ERR`| R | Compteur synchrone des violations de protocole CAN détectées |
| `0x0C` | `DRV_REG_LIN_ERR`| R | Compteur synchrone des violations de protocole LIN détectées |

---

## 📊 5. Chronogramme Comportemental & Injection de Fautes

```text
                       ◀  Nominal Execution  ▶◀ Lockstep Mismatch & Fail-Safe Isolation
                       0ns         10ns        20ns        30ns        40ns

                       |           |           |           |           |
SYS_CLK (100 MHz)   ___/¯¯¯¯\_____/¯¯¯¯\_____/¯¯¯¯\_____/¯¯¯¯\_____/¯¯¯¯\__
CAN_RX_RAW          ¯¯¯¯\__________/¯¯¯¯¯¯¯¯¯¯\____________________________
LOCKSTEP_ERR        ___________________________/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
                                               ▲ (Divergence détectée entre les 2 cœurs)
FAIL_SAFE_MODE      ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\___________________________
                                               ▼ (Isolement physique instantané du bus)
```

---

## ⚖ 6. Cadre de Prestation & Intégration Industrielle

L'architecture REIO-Drive (SPU_105) démontre une expertise de pointe en sûreté de fonctionnement (Functional Safety) appliquée aux architectures silicium embarquées. 

*   **Livrables de Mission :** Adaptation de la brique de protection aux matrices de messages réseau du client, intégration des barrières anti-métastabilité pour l'interfaçage des horloges de bus, et support à la rédaction du *Safety Case* pour les audits de certification ISO 26262.
*   **Modalités :** Prestation exécutable au forfait ou via TJM en portage salarial (**SMART Belgique** / Contrats directs).
