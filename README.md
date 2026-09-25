# REIO — Framework de Co-Design Hardware/Software pour Systèmes Critiques

Bienvenue sur le dépôt principal du framework **REIO** (Reliable Embedded Interception Operations). Cet écosystème regroupe des architectures de co-design matériel/logiciel (RTL VHDL + Rust Bare-Metal `#[no_std]` / C FFI) dédiées à la sûreté de fonctionnement, à l'interception de flux haute vitesse et à l'immunité déterministe des infrastructures embarquées.

## 📑 1. Fondations Théoriques & Antériorité Scientifique

Les concepts abstraits, invariants métalogiques (Ancrage Ontologique, Règles anti-Gettier) et les règles de confinement paraconsistant qui gouvernent cet écosystème ont été officiellement archivés et gelés au niveau de la recherche académique :
* **Spécification Fondamentale :** REIO-RFC-003 / Phase 6
* **Publication Officielle :** Déposée et verrouillée de manière permanente sur **Zenodo (CERN)**.
* **Certification d'Antériorité :** Adossée à un **DOI (Digital Object Identifier) unique et immuable**.

---

## 🛠️ 2. Réalisations Matérielles & Validations Physiques (Open-Core Portfolio)

Pour répondre aux contraintes micro-architecturales réelles du silicium et garantir le respect strict des contraintes temporelles sans aucune violation, les spécifications théoriques ont été adaptées sous forme de modules matériels compacts et autonomes, entièrement synthétisés et routés sur cible **AMD/Xilinx Artix-7** (Mode *Out-of-Context*).

Le framework est actuellement structuré autour de deux Proof of Concepts (PoC) industriels majeurs :

### ⛓️ [Module 01 : REIO-Chain (SPU_103)](./chain)
*   **Fonction :** Disjoncteur matériel et filtre d'interception réseau synchrone sur bus parallèle **64 bits**.
*   **Métriques Vivado :** Cadencement du plan de contrôle à **400 MHz** (période de 2,5 ns) et de la ligne à 125 MHz. Timing Closure entièrement validé post-routage (**WNS : +1,596 ns**, **WHS : +0,142 ns**).
*   **Empreinte :** Optimisation extrême combinatoire pure (12 LUTs / 111 Registres), consommation dynamique de seulement **1 mW**.

### 🚗 [Module 02 : REIO-Drive (SPU_105)](./drive)
*   **Fonction :** Intercepteur déterministe et bouclier anti-injection pour bus multiplexés automobiles CAN/LIN.
*   **Sûreté (ISO 26262) :** Architecture alignée sur les exigences critiques **ASIL-D** via une machine d'états redondante en mode **Lockstep** et bascule automatique en mode dégradé sécurisé (*Fail-Safe*).
*   **Livrable Temporel :** Atténuation chirurgicale et isolation physique de la ligne de transmission exécutée en **exactement 1 cycle d'horloge unitaire** après détection du motif de menace.

---

## ⚖️ 3. Mentions Légales & Propriété Intellectuelle

Conformément aux clauses de protection exclusive de notre modèle "Jardin Secret", les fichiers de code source d'origine (`.vhd`, `.rs`) sont protégés contre toute extraction ou exposition publique par des restrictions d'environnement strictes (`.gitignore`). 

Le public, les auditeurs et les directeurs techniques (CTO) disposent d'un accès libre pour analyser les rapports physiques de compilation CAO post-routage (`.rpt`), les bilans de puissance thermique, les chronogrammes de simulation fonctionnelle ainsi que les interfaces d'en-tête C-FFI (`reio_chain.h` / `reio_drive.h`).

*Pour toute demande de licence commerciale (Option Logicielle B2B ou Rachat complet des droits d'IP Source), d'audit architectural ou d'intégration sur mesure, veuillez contacter l'architecte matériel via les canaux professionnels de messagerie.*
