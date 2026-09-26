# REIO — Portfolio de Prototypage Hardware & Co-Design

Bienvenue sur mon portfolio technique. Ce dépôt rassemble mes maquettes fonctionnelles, mes architectures de co-design et mes rapports de validation physique post-routage sous AMD/Xilinx Vivado (VHDL + Rust Bare-Metal #[no_std] / C FFI).

---

## 🛠️ 1. Réalisations Matérielles & Validations Physiques (PoC Portfolio)

Toutes les architectures présentées ont été entièrement synthétisées, placées et routées sur cible matérielle AMD/Xilinx Artix-7 (Mode Out-of-Context) :

### 🚗 [REIO-Drive (SPU_105)](./drive)
- **Fonction :** Maquette d'un intercepteur et bouclier de sécurité pour bus multiplexés automobiles CAN/LIN.
- **Sûreté :** Architecture intégrant une machine d'états redondante en mode Lockstep avec bascule en mode dégradé sécurisé (Fail-Safe).
- **Validation Temporelle :** Routage physique entièrement validé à 100 MHz (Worst Negative Slack : +7,606 ns, Worst Hold Slack : +0,279 ns). Interception exécutée en exactement 1 cycle d'horloge.

### ⛓️ [REIO-Chain (SPU_103)](./chain)
- **Fonction :** Maquette d'un disjoncteur matériel et filtre d'interception réseau synchrone sur bus parallèle 64 bits.
- **Validation Temporelle :** Cadencement cible stabilisé à 400 MHz (période de 2,5 ns). Timing Closure entièrement validé post-routage (WNS : +1,596 ns, WHS : +0,142 ns).
- **Ressources :** Optimisation extrême combinatoire pure (12 LUTs / 111 Registres) pour une consommation dynamique active du cœur isolée à 1 mW.

---

## 🌐 2. Architecture Globale du Framework

Le framework s'articule autour d'un bloc central générique (REIO-CORE) configuré pour stabiliser le silicium et gérer les barrières de métastabilité. Ce cœur fonctionnel alimente et pilote les deux implémentations physiques spécialisées présentées dans ce portfolio :
- Le module réseau haut débit (REIO-CHAIN)
- Le module de sûreté automobile (REIO-DRIVE)

---

## ⚖️ 3. Mentions Légales & Propriété Intellectuelle (Proprietary Rights)

Conformément aux clauses de protection exclusives de mon modèle de distribution "Closed-Source / Restricted Access", les architectures logiques, l'implémentation algorithmique fine et les fichiers sources d'origine (.vhd, .rs) restent strictement propriétaires et confidentiels. Ces éléments sont protégés contre toute extraction ou exposition publique par des restrictions d'environnement automatisées (.gitignore).

Le public, les auditeurs techniques et les directeurs de l'ingénierie (CTO) disposent d'un droit d'accès libre pour auditer exclusivement les livrables physiques de validation : rapports CAO post-routage d'utilisation des ressources (.rpt), bilans de puissance thermique, chronogrammes de simulation fonctionnelle, ainsi que les interfaces d'en-tête C-FFI standardisées (reio_chain.h).

*Pour toute demande de licence d'exploitation commerciale, d'audit d'architecture approfondi ou d'intégration sur mesure au sein de vos systèmes embarqués, veuillez soumettre une demande officielle via les canaux professionnels de messagerie.*
