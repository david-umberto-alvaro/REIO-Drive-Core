# REIO — Framework de Co-Design Hardware/Software pour la Sûreté des Systèmes Embarqués

## 🔬 1. Positionnement Scientifique & Recherche Académique

Le framework **REIO** (*Reliable Embedded Interception Operations*) relie méthodes formelles et contraintes physiques (FPGA). 

### Fondations Théoriques
Les mécanismes s'appuient sur la **logique paraconsistante** et les FSM pour garantir un comportement déterministe malgré les fautes (*bit-flips*).
* **Référence Académique :** Thèse et spécifications sur **Zenodo** : `[https://zenodo.org/records/20743411]`
---

## 🛠️ 2. Implémentation Physique & Métriques Vivado (PoC)

Deux Proof of Concepts (PoC) en **VHDL** et **Rust/C FFI** ont été synthétisés sur cible **AMD/Xilinx Artix-7**.

### 🚗 [REIO-Drive (SPU_105)](./drive)
* **Fonction :** Bouclier pour bus CAN/LIN.
* **Sûreté (ISO 26262) :** Aligné ASIL-D (Lockstep, mode *Fail-Safe*).
* **Validation :** Validé à 100 MHz (WNS : +7,606 ns, WHS : +0,279 ns). Interception en 1 cycle.

### ⛓️ [REIO-Chain (SPU_103)](./chain)
* **Fonction :** Disjoncteur matériel sur bus 64 bits.
* **Validation :** Cible à 400 MHz (WNS : +1,596 ns, WHS : +0,142 ns).
* **Ressources :** 12 LUTs / 111 Registres, consommation ~1 mW.

---

### 🌐 Architecture Globale du Framework

```text
                     [ REIO FRAMEWORK ]
                             |
                             v
     +-----------------------------------------------+

     |                   REIO-CORE                   |
     |      (Spécification Théorique Initiale)       |
     |   -> Archivé sur Zenodo avec son DOI unique   |
     +-----------------------------------------------+
                             |
         +-------------------+-------------------+

         |                                       |
         v                                       v
+------------------------+              +------------------------+

|       REIO-CHAIN       |              |       REIO-DRIVE       |
|  (PoC Réseau - Impl.)  |              |   (PoC Auto - Impl.)   |
|  -> Pipeline 64 bits   |              |  -> Mode Lockstep      |
|  -> Cadencement 400 MHz|              |  -> Norme ISO 26262    |
+------------------------+              +------------------------+
```

## 📦 3. Structure du Dépôt & Politique d'Accès

Ce dépôt sert de portfolio technique.

### Accès Libre :
* `reio_chain.h`, `AI_METHODOLOGY.md` et rapports Vivado.

### Code Source (`.vhd`, `.rs`) :
Le code source brut est restreint pour protéger la propriété intellectuelle.
* **Contact :** Demande d'accès via [LinkedIn](https://linkedin.com).
