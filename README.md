# 🛡️ REIO-Drive Core v1.0 — ASIL-D Ready Safety IP Core

[![License](https://shields.io)](LICENSE)
[![Vivado](https://shields.io)](hard/)
[![Target](https://shields.io)](hard/)

REIO-Drive Core v1.0 est une architecture de confinement duale de sécurité (Safety IP Core) conçue pour intercepter et isoler instantanément les injections de fautes malveillantes ou les corruptions de données en transit. 

Ce module offre une protection hybride hautement déterministe pour les véhicules autonomes, les drones de classe industrielle et les systèmes robotiques soumis aux exigences de sécurité critiques (**ISO 26262 ASIL-D**).

---

## 📈 Architecture de Confinement Duale (SIL vs HIL)

Pour répondre aux contraintes rigoureuses des architectures embarquées modernes, REIO-Drive sépare strictement sa logique logicielle de son exécution matérielle :

*   **Couche Logicielle (Software-in-the-Loop - SIL) :** Gérée par une bibliothèque **Rust bare-metal (`no_std`)** via une interface FFI sécurisée pour le C embarqué. Elle assure la gestion fine de la mémoire et l'application des politiques de sécurité avec une latence déterministe inférieure à **2 µs**.
*   **Couche Matérielle (Hardware-in-the-Loop - HIL) :** Implémentée sous forme d'une machine à états finis (FSM) synchrone ultra-optimisée en **VHDL/Verilog**. Elle garantit une isolation physique du bus en exactement **1 cycle d'horloge (10 ns à 100 MHz)**.

---

## 🔬 Performances Matérielles Validées (Vivado v2026.1)

L'implémentation matérielle a été entièrement compilée, synthétisée et validée sur une cible **AMD/Xilinx Artix-7 (xc7a35tcsg324-1)**.

### 📊 Utilisation des Ressources Silicium
*   **Slice LUTs :** 6 utilisées (sur 20 800) → Empreinte silicium minimale de 0,03 %, idéale pour une intégration en périphérie de bus sans surcoût.
*   **Slice Registers :** 4 Flip-Flops utilisés → Séquençage synchrone sans surcharge séquentielle (< 0,01 %).
*   **Bonded IOB :** 13 broches d'E/S utilisées (11 `IBUF`, 2 `OBUF`).
*   **Mémoire / DSP :** 0% (Logique combinatoire et séquentielle pure, aucun bloc RAM requis).
*   **Consommation Énergétique :** < 1mW en dynamique (négligeable, assurant une intégration transparente).

### 🔎 Vérification Comportementale (Waveform Simulation)
*   **Sécurisation Post-Reset :** Dès l'activation du signal `reset`, le système bascule immédiatement dans un état de repli sécurisé non-falsifiable (`statut_securite = '0'`, `declencher_secours = '1'`).
*   **Filtrage d'Entropie & Anti-Glitch :** Le module intègre un algorithme matériel de détection de motifs menaçants (*Pattern Threat Mapping*). Pour éviter les faux positifs liés aux bruits électromagnétiques transitoires du bus, la signature critique d'attaque doit être stable et validée pendant **3 cycles d'horloge consécutifs** avant le verrouillage de l'état d'urgence.

![Behavioral Verification Waveform](preuve_simulation.png)
---

## 📦 Structure du Dépôt

*   `📁 /hard` : Rapport officiel de synthèse matérielle Vivado (`reio_drive_hardware_utilization_synth.rpt`) et chronogrammes de simulation.
*   `📁 /soft` : En-tête C de production (`reio_drive.h`) exposant l'interface FFI Rust sécurisée.

---

## 💼 Évaluation Commerciale & Intégration B2B

La suite logicielle et l'IP Core sont distribués sous licence commerciale exclusive pour les intégrateurs automobiles et industriels.

*   **Package d'Évaluation Éphémère :** Fourni sous forme de binaire précompilé (Black-box `.a`/`.lib`) et de Netlist matérielle sécurisée (`.dcp`). 
*   **Sécurisation Temporelle :** L'évaluation est bridée par un mécanisme de verrouillage cryptographique éphémère (*Time-Bomb*) interne de 30 jours, basé sur une vérification matérielle d'horloge (RTC) non-falsifiable par l'hôte.
*   **Licence de Production :** Accès complet aux Netlists de production et intégration personnalisée clé en main (Services d'Ingénierie Dédiés).

Pour toute demande technique, documentation étendue ou protocole de test HIL, veuillez contacter directement l'architecte système en messagerie privée pour l'établissement d'un accord de confidentialité (NDA).

---

## ⚖️ Propriété Intellectuelle & Mentions Légales

Copyright (c) 2026 David Umberto Alvaro. Tous droits réservés.

Cette technologie est **PROPRIÉTAIRE et CONFIDENTIAL**. Aucune licence open-source n'est accordée. Toute reproduction, modification ou distribution non autorisée de ces fichiers sans un accord commercial écrit est strictement interdite. 

Le produit est fourni « En l'état » (*As-Is*), entièrement validé selon les rapports de synthèse et les chronogrammes officiels fournis dans ce dépôt.

