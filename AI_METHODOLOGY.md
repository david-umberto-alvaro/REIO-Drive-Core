# AI-Assisted Engineering Methodology

## Cadre d'Orchestration Matérielle/Logicielle (Vivado & Rust Bare-Metal)

Ce document formalise la méthodologie d'ingénierie système assistée par IA utilisée pour concevoir, optimiser et durcir le framework REIO-chain (SPU_103). L'IA a été exploitée ici comme un copilote de CAO avancée pour accélérer la recherche et le débogage physique, sous la supervision stricte de critères de validation industriels.

---

### 1. Cycle d'Itération & Convergence Technologique

La conception du cœur d'interception a suivi un flux de convergence itératif rigoureux entre les invites (prompts) et les rapports physiques générés par AMD/Xilinx Vivado.

Le flux suit une boucle fermée systématique :
1. Spécifications architecturales et écriture du code VHDL.
2. Synthèse et Placement-Routage physique sous Vivado.
3. Analyse automatique des fichiers de violations (`.rpt`).
4. Soumission des logs à l'IA avec une invite d'optimisation ciblée.
5. Correction et ré-injection du code épuré.

Chaque bloc de code généré a été confronté à la réalité micro-architecturale de la cible Artix-7 (`xc7a12tlcpg238-2L`).

---

### 2. Résolution des Contraintes Physiques de Timing (Haute Fréquence)

L'apport majeur de l'ingénierie assistée par IA s'est concentré sur la fermeture complète du timing sous une période d'horloge agressive de l'ordre du gigahertz.

#### A. Élimination des violations de Setup (WNS)
* **Problème initial :** Les cascades de calculs combinatoires logiques pour l'évaluation des masques réseau saturaient le chemin critique (Critical Path), entraînant un Worst Negative Slack (WNS) rouge et négatif.
* **Correction IA/Humain :** Implémentation guidée d'une structure de pipeline logique. L'insertion de registres tampons a permis de segmenter les opérations combinatoires.
* **Résultat :** Convergence finale validée au routage avec un WNS positif et stable (zéro violation sur le chemin critique).

#### B. Gestion du Cross-Clock Domain (CDC) & Métastabilité
* **Problème initial :** Le couplage asynchrone entre l'horloge réseau Ethernet de ligne (125 MHz) et l'horloge système du plan de contrôle rapide présentait des risques critiques de métastabilité.
* **Correction IA/Humain :** Génération et isolation stricte de barrières de resynchronisation à l'aide de l'attribut matériel `ASYNC_REG` en VHDL, combinée à l'écriture de contraintes temporelles spécifiques (`set_clock_groups -asynchronous`) dans le fichier XDC.

---

### 3. Optimisation de l'Empreinte (LUT Combining)

Pour garantir une latence déterministe d'un seul cycle machine, l'IA a été configurée pour cibler une compacité logicielle maximale :
* **Optimisation sémantique :** Élimination de l'arithmétique flottante et des calculs de ratios complexes au niveau du silicium. Déportation de l'évaluation logique vers le plan de contrôle Rust bare-metal (`#[no_std]`).
* **Résultat CAO :** Le moteur de synthèse Vivado a pu exploiter pleinement la micro-architecture des tranches (Slices) Xilinx en fusionnant la logique de contrôle et la propagation arithmétique (primitives CARRY4) au sein d'un nombre minimal de Slice LUTs hybrides, réduisant ainsi la puissance dynamique active à son niveau le plus bas.

---

### 4. Conclusion & Posture d'Ingénierie Augmentée

Cette approche démontre l'efficacité du paradigme de l'Ingénieur Augmenté : considérait que l'Intelligence Artificielle gère la vitesse de production et la structure brute du code, tandis que l'opérateur humain valide la physique du routage, applique les contraintes de délai matérielles (`set_input_delay`) et certifie les chronogrammes de simulation comportementale.
