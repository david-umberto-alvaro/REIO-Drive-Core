# Technical Datasheet: REIO-Chain (SPU_103)

## Ultra-Compact Synchronous Line-Rate Drop-Filter IP Core

### 1. Electrical & Timing Specifications
- **System Clock (sys_clk) :** 400 MHz (2.5 ns period)
- **Network Interface Clock (phy_rx_clk) :** 125 MHz (8.0 ns period)
- **Worst Negative Slack (WNS) :** +1.596 ns [Setup Met]
- **Worst Pulse Width Slack (WPWS) :** +0.750 ns [Clock Tree Stabilized]
- **Mitigation Latency :** Deterministic 1 clock cycle (2.5 ns)

### 2. Physical Resource Utilization (xc7a12tlcpg238-2L)
- **LUT as Logic :** 12 (0.15%)
- **Slice Registers (FDCE) :** 111 (0.69%)
- **Arithmetic Primitives :** 24 CARRY4 blocks
- **Bonded IOB :** 0 (Out-of-Context verification flow / Package-isolated boundary)

### 3. Thermal & Power Dissipation Profile
- **Total On-Chip Power :** 0.058 W (58 mW)
- **Core Dynamic Power :** 0.001 W (1 mW)
- **Device Static Power :** 0.056 W (56 mW)
- **Junction Temperature :** 25.4 °C
