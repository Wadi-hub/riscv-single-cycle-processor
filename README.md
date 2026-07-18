# RISC-V Processor (Single-Cycle → Pipelined)

A RISC-V (RV32I subset) processor implemented in SystemVerilog, built and simulated in Vivado, and cross-verified against [Ripes](https://github.com/mortbopet/Ripes).

This is an ongoing project tracking the evolution of the design: starting from a single-cycle implementation, then restructured into a 5-stage pipeline, with hazard handling and branch prediction planned next.

| Stage | Status | Tag |
|---|---|---|
| Single-cycle | Complete, verified | [`v1-single-cycle`](../../releases/tag/v1-single-cycle) |
| Pipelined (5-stage) | Functional, hazards not yet handled | [`v2-pipelined`](../../releases/tag/v2-pipelined) |
| Hazard detection & forwarding | Planned | — |
| Branch prediction | Planned | — |

## Supported Instructions

| Instruction | Type | Format |
|---|---|---|
| add, sub, and, or, slt, sll | R-type | funct7 \| rs2 \| rs1 \| funct3 \| rd \| opcode |
| addi, andi, ori, slti, slli | I-type | imm[11:0] \| rs1 \| funct3 \| rd \| opcode |
| lw | I-type (load) | imm[11:0] \| rs1 \| funct3 \| rd \| opcode |
| sw | S-type | imm[11:5] \| rs2 \| rs1 \| funct3 \| imm[4:0] \| opcode |
| beq | B-type | imm[12,10:5] \| rs2 \| rs1 \| funct3 \| imm[4:1,11] \| opcode |

## Repo Structure
## Repo Structure
```
├── single_cycle/
│   ├── source_files/           # Single-cycle datapath, control unit, ALU, register file, PC, etc.
│   ├── test_benches/           # Testbenches for the single-cycle wrapper and individual units
│   ├── assembly_code/          # RISC-V assembly test programs
│   ├── assembly_test_code.s    # Primary sample program used for verification
│   └── ripes_verification.png  # Verification screenshot
├── pipelined/
│   ├── sources/                # Pipelined datapath — wrapper, pipeline registers (if_id, id_ex, ex_mem, mem_wb), control unit, ALU
│   └── sims/                   # Simulation waveforms and testbench outputs
├── images/                     # Shared diagrams and screenshots
└── riscv_code.docx             # Notes/documentation
```

## Single-Cycle Design

Full datapath — PC, instruction memory, register file, immediate generator, control unit, ALU, branch logic, data memory — implemented and verified end-to-end.

**Verification:** wrote a RISC-V assembly test program (`assembly_test_code.s`), ran it in [Ripes](https://github.com/mortbopet/Ripes) to get expected register values, then ran the equivalent instructions through the Verilog testbench in Vivado and confirmed matching results.

![Ripes verification](single_cycle/ripes_verification.png)

## Pipelined Design

Restructured the single-cycle datapath into a classic 5-stage pipeline (IF → ID → EX → MEM → WB), with dedicated pipeline register modules (`if_id`, `id_ex`, `ex_mem`, `mem_wb`) inserted between stages. Verified against the same array-sum test program, with waveform inspection confirming correct instruction overlap (new instruction fetched every cycle, constant fetch-to-writeback latency, multiple instructions in flight simultaneously).

**Known limitation:** no hazard detection or forwarding yet — data/control hazards (e.g. back-to-back dependent instructions, branches) are not currently handled correctly. This is the next stage of the project.

## What's Next

- Hazard detection unit and data forwarding (EX/MEM and MEM/WB forwarding paths)
- Branch/control hazard handling — static or dynamic prediction
- Extend instruction coverage to the full RV32I base ISA

## Tools Used

- SystemVerilog
- Xilinx Vivado (simulation)
- [Ripes](https://github.com/mortbopet/Ripes) (reference verification)
