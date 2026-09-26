# ⚡ REIO-Chain (SPU_103) — Fiche Technique Industrielle

## 1. Description Générale & Applications
REIO-Chain (SPU_103) est un bloc de propriété intellectuelle (IP Core) synchrone ultra-compact dédié à l'interception linéaire et à l'isolation déterministe de flux de données Couche 3 au niveau de la couche physique (Line-Rate). 

### Applications Cibles :
*   Pare-feux matériels industriels (Automates, Scada).
*   Sonde de détection de menaces en temps réel pour routeurs critiques.
*   Disjoncteur réseau pour serveurs de trading haute fréquence (HFT).

---

## 2. Caractéristiques Électriques et Temporelles (Artix-7)
*Spécifications certifiées post-placement-routage sous AMD/Xilinx Vivado v2026.1 sur cible xc7a12tlcpg238-2L (Grade de température étendu).*

| Paramètre Temporel | Symbole | Spécification Target | Slack Validé | Unité |
| :--- | :--- | :--- | :--- | :--- |
| **Fréquence Horloge Système** | \(f_{SYS}\) | 400.00 | — | MHz |
| **Période Horloge Système** | \(T_{SYS}\) | 2.50 | — | ns |
| **Fréquence Horloge Ligne (PHY)** | \(f_{RX}\) | 125.00 | — | MHz |
| **Période Horloge Ligne (PHY)** | \(T_{RX}\) | 8.00 | — | ns |
| **Worst Negative Slack (Setup)**| WNS | — | **+1.596** | ns |
| **Worst Hold Slack (Hold)** | WHS | — | **+0.142** | ns |
| **Temps d'Isolation Critique** | \(T_{ISOL}\) | **1.00 (Unique cycle)** | Conforme | cycle |

### Profil de Consommation Électrique (Power Summary) :
*   **Puissance Statique du Composant (Vccint, Vccaux) :** 56 mW (Fixe silicium).
*   **Puissance Dynamique Active du Cœur (REIO-Core) :** **1 mW**.
*   **Température de Jonction Estimée (\(T_J\)) :** 25.4 °C (Pour une température ambiante de 25 °C).

---

## 3. Cartographie des Registres et Interface MMIO (Memory Map)
*L'accès au plan de contrôle s'effectue via des lectures/écritures volatiles directes (32-bit aligné sur les lignes de cache CPU).*

| Adresse Offset | Registre | Type | Largeur | Description / Fonction |
| :--- | :--- | :--- | :--- | :--- |
| `0x00` | `REG_CTRL` | R/W | 32 bits | [Bit 0] : Reset logiciel \| [Bit 1] : Forçage manuel de l'isolation |
| `0x04` | `REG_STATUS` | R | 32 bits | [Bit 0] : Statut Sécurité ('1'=Nominal, '0'=Isolé) \| [Bit 1] : Alerte |
| `0x08` | `REG_THREAT_SIG`| R/W | 8 bits | Signature de la menace (Valeur par défaut : `0x7F`) |
| `0x0C` | `REG_CNT_CLEAN` | R | 32 bits | Compteur synchrone des paquets sains interceptés |
| `0x10` | `REG_CNT_ANOM`  | R | 32 bits | Compteur synchrone des anomalies bloquées |

---

## 4. Chronogramme Comportemental & Invariants Logiques
```text
                       ◀ Nominal Processing ▶◀ Surgical Isolation (1 Cycle)
                       0ns         2.5ns       5.0ns       7.5ns       10ns

                       |           |           |           |           |
SYS_CLK (400 MHz)   ___/¯¯¯¯\_____/¯¯¯¯\_____/¯¯¯¯\_____/¯¯¯¯\_____/¯¯¯¯\__
RESET (Active-High) ¯¯¯¯\__________________________________________________
FLUX_DATA_IN (64b)  XXXX🔀  0xAA  XXXXXXXXX🔀  0x7F  XXXXXXXXXXXXXXXXXXXXXX
                                              ▲ (Signature Détectée)
STATUT_SECURITE    ____________/¯¯¯¯¯¯¯¯¯¯¯¯¯¯\___________________________
                                               ▼ (Coupure immédiate du flux)
DECLENCHER_SECOURS ___________________________/¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
```

---

## 5. Intégration Logicielle (Plan de Contrôle Rust `no_std`)
L'IP Core expose une interface C-FFI standardisée via `reio_chain.h`. Le pilote garantit une exclusion stricte des débordements de mémoire sans allocation dynamique.

```rust
// Exemple d'initialisation bare-metal du registre de contrôle REIO
pub unsafe fn initialize_reio_chain(base_address: usize) {
    let ctrl_ptr = base_address as *mut u32;
    // Écriture volatile directe pour activer le monitoring synchrone
    core::ptr::write_volatile(ctrl_ptr, 0x01);
}
```
