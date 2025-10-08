# 🧠 MEM_CTRL Verification using UVM

![Build Status](https://img.shields.io/badge/Build-Passing-brightgreen)
![Language](https://img.shields.io/badge/Language-SystemVerilog-blue)
![Methodology](https://img.shields.io/badge/Methodology-UVM%201.2-orange)
![Coverage](https://img.shields.io/badge/Coverage-Pending-yellow)
![Simulator](https://img.shields.io/badge/Simulator-VCS%2F%20Xcelium-purple)

---

## 📘 Overview

This repository contains the **SystemVerilog UVM-based verification environment** for the **Memory Controller (MEM_CTRL)** IP.  
The MEM_CTRL design supports **FLASH**, **SDRAM**, and **SSRAM** memory types and includes advanced features like **dynamic bus sizing**, **write protection**, and **low-power (sleep) modes**.

This UVM testbench ensures:
- ✅ Functional correctness across all modes  
- 🧩 Protocol compliance and timing accuracy  
- 🧠 Reusability through parameterized components  

---

## 🧩 Verification Architecture

Developed using **UVM 1.2**, the environment features:
- **Drivers / Sequencers / Monitors** for Wishbone and Memory interfaces  
- **Agents** for interface abstraction  
- **mc_env** – environment integrating all UVM components  
- **Test Library** for scenario-based validation  
- **Scoreboard (Pending)** – for data verification  
- **Coverage (Pending)** – for scenario completion metrics  

---

## 🧪 Test Summary

| **Test Name** | **Description** | **Status** |
|----------------|-----------------|-------------|
| `mc_reset_test` | Validates controller reset and default register state. | ✅ DONE |
| `mc_reg_access_test` | Verifies register access over bus interface. | ✅ DONE |
| `mc_flash_access_test` | Tests FLASH read/write transaction flow. | ✅ DONE |
| `mc_flash_wr_protect_test` | Validates FLASH write protection enforcement. | ✅ DONE |
| `mc_flash_sleep_test` | Checks sleep and wake-up functionality. | ✅ DONE |
| `mc_poc_test` | Power-On Configuration test. | ❌ NOT DONE |
| `mc_flash_vpen_test` | Tests write-enable (VPEN) control signal behavior. | ✅ DONE |
| `mc_flash_ready_test` | FLASH ready signal check (invalid scenario). | ⚠️ INVALID |
| `mc_flash_dyn_bus_size_8_bit_test` | Verifies 8-bit dynamic bus configuration. | ✅ DONE |
| `mc_flash_dyn_bus_size_16_bit_test` | Verifies 16-bit dynamic bus configuration. | ✅ DONE |
| `mc_flash_wr_protect_exp_err_test` | Expected error case for write-protection violation. | ❌ NOT DONE |

---

## 🧱 Pending Work

### Memory Type Verification
- [ ] **SDRAM** verification  
- [ ] **SSRAM** verification  

### Environment Enhancements
- [ ] Implement **Scoreboard**  
- [ ] Add **Functional Coverage**  
- [ ] Improve **Monitor** observability  

---

## 🧰 Tools & Setup

| **Category** | **Tool / Version** |
|---------------|------------------|
| Simulator | Synopsys VCS / Cadence Xcelium |
| Methodology | UVM 1.2 |
| Language | SystemVerilog |
| OS | Linux (RHEL / Ubuntu) |
| Version Control | Git |

---

## 📂 Repository Structure

```
MEM_CTRL/
│
├── design/
│   └── rtl/verilog/
│       ├── mc_top.v
│       ├── mc_mem_if.v
│       ├── mc_defines.v
│       ├── timescale.v
│       └── rtl_file_list.svh
│
├── MemoryModels/
│   ├── 160b3ver/               # FLASH models
│   ├── sdram_models/           # Micron SDRAM variants
│   ├── sram_models/            # IDT / Micron SRAM models
│   └── SyncCS/                 # Sync chip-select models
│
├── UVM_TB_GENERATOR/
│   ├── UVM_Tb_generator.py
│   ├── UVM_TB_PARAMS.csv
│   ├── tb_config.xlsx
│   └── Makefile
│
├── verif/
│   ├── TOP/
│   │   ├── top.sv
│   │   ├── mc_common.sv
│   │   ├── flash_mem_inst.sv
│   │   ├── flash_mem_bw8_inst.sv
│   │   ├── flash_mem_bw16_inst.sv
│   │   └── sdram_mem_inst.sv
│   │
│   ├── TEST_LIB/
│   │   ├── mc_base_test.sv
│   │   ├── mc_flash_access_test.sv
│   │   ├── mc_flash_sleep_test.sv
│   │   ├── mc_flash_vpen_test.sv
│   │   ├── mc_flash_dyn_bus_size_test.sv
│   │   └── mc_flash_dyn_bus_size_16_bit_test.sv
│   │
│   ├── SEQ_LIB/
│   │   ├── mc_base_seq.sv
│   │   ├── mc_flash_access_seq.sv
│   │   ├── mc_flash_sleep_seq.sv
│   │   ├── mc_flash_vpen_seq.sv
│   │   └── mc_flash_dyn_bus_size_seq.sv
│   │
│   ├── ENV/
│   │   ├── mc_env.sv
│   │   └── AGENTS/
│   │       ├── wb/
│   │       │   ├── wb_if.sv
│   │       │   ├── wb_drv.sv
│   │       │   ├── wb_mon.sv
│   │       │   ├── wb_sqr.sv
│   │       │   └── wb_agent.sv
│   │       └── mc_mem/
│   │           ├── mc_mem_if.sv
│   │           ├── mc_mem_drv.sv
│   │           ├── mc_mem_mon.sv
│   │           ├── mc_mem_sqr.sv
│   │           └── mc_mem_agent.sv
│   │
│   ├── RAL/                     # Register model (planned)
│   │
│   └── SIM/
│       ├── Makefile
│       ├── run.sh
│       ├── file_list.f
│       ├── wave_mc.rc
│       ├── flash_dyn_bus_size_bw_8.rc
│       ├── flash_dyn_bus_size_bw_16.rc
│       ├── image_0.hex ... image_3.hex
│       └── TB_README.txt
│
└── DEMO/
    ├── top.sv
    └── mc_common.sv
```

---

## ⚡ Quick Start

### 1️⃣ Clone Repository
```bash
git clone https://github.com/<your-username>/MEM_CTRL.git
cd MEM_CTRL/verif/SIM
```

### 2️⃣ Compile Testbench
```bash
make compile
```

### 3️⃣ Run Test
```bash
make run TEST=mc_flash_access_test
```

### 4️⃣ View Waveform
```bash
verdi -ssf wave_mc.rc &
```

---

## 📊 Verification Progress

| **Category** | **Progress** |
|---------------|--------------|
| FLASH Interface | ✅ 90% Complete |
| SDRAM / SSRAM | ⚙️ Pending |
| Scoreboard & Coverage | ⚙️ Pending |
| Overall Verification | 🟩 ~70% Completed |

---

## 👤 Author

**Name:** Koushik Shridhar  
**Date:** October 2025  
**Version:** v1.0  

---
