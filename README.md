# 5-Stage Pipelined MIPS Processor

A classic 5-stage pipelined MIPS processor built from scratch in Verilog HDL, featuring hazard detection and data forwarding (bypassing) to resolve Read-After-Write (RAW) hazards.

## Project Info
- **Tech:** Verilog HDL
- **Simulator:** JDoodle (Icarus Verilog)
- **Difficulty:** Advanced
- **Architecture:** 5-stage pipeline (IF, ID, EX, MEM, WB)

## Modules
| File | Description |
|------|--------------|
| pc_unit.v | Program Counter with stall support |
| instruction_memory.v | Instruction storage |
| pipeline_registers.v | IF/ID, ID/EX, EX/MEM, MEM/WB pipeline registers |
| register_file.v | 32 x 32-bit registers with write-then-read forwarding |
| decode_unit.v | R-type instruction decoder |
| alu.v | Arithmetic Logic Unit (ADD, SUB, AND, OR) |
| hazard_detection_unit.v | Detects RAW hazards, stalls pipeline |
| forwarding_unit.v | Forwards ALU results to avoid stalls |
| pipelined_cpu.v | Top-level CPU connecting all 5 stages |
| tb_pipelined_cpu.v | Testbench with a RAW hazard test case |

## Pipeline Stages
```
IF  -> Instruction Fetch
ID  -> Instruction Decode + Register Read
EX  -> Execute (ALU operation)
MEM -> Memory Access
WB  -> Write Back to Register File
```

## Hazard Handling

### Problem: Read-After-Write (RAW) Hazard
```
ADD x3, x1, x2     ; x3 = 20
SUB x5, x3, x1      ; needs x3, but it isn't written back yet!
```

### Solution 1 — Hazard Detection (Stall-based)
Detects the dependency during Decode and freezes the pipeline (PC + IF/ID)
for 2 cycles until the value is safely available.

### Solution 2 — Forwarding Unit (Stall-free)
Instead of waiting, the ALU result is forwarded directly from the EX/MEM
or MEM/WB pipeline register straight into the next instruction's ALU input —
eliminating wasted cycles entirely.

## Simulation Results
```
FINAL REGISTERS: x3=20 (ADD 15+5) x5=5 (SUB x3-x1, should be 20-15=5)
```

With forwarding enabled, the pipeline runs with zero stalls while still
producing the correct result.

## Learning Outcomes
- 5-stage pipeline execution flow
- RAW hazard detection and stall-based resolution
- Data forwarding / bypassing for stall-free execution
- CPU datapath analysis and debugging of timing/race conditions
