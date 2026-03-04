<img width="933" height="646" alt="image" src="https://github.com/user-attachments/assets/a38e7504-d5a4-454f-baa1-2ab4039b4bd9" />

# Asynchronous FIFO for Clock Domain Crossing (CDC)

## Overview

This project implements a **parameterized asynchronous FIFO in Verilog** to safely transfer data between **independent write and read clock domains**.

The design follows industry-standard **Clock Domain Crossing (CDC)** techniques using:

* Gray-coded pointers
* Two flip-flop synchronizers
* Robust FULL and EMPTY detection logic

The FIFO ensures **no data loss, duplication, or metastability issues** when transferring data across asynchronous clock domains.

---

## Architecture


### Design Idea

Instead of transferring data directly across clock domains:

* Data is stored inside **FIFO memory**
* Only **Gray-coded pointer information crosses domains**

This approach minimizes metastability risk and ensures reliable operation.

---

## Key Features

* Parameterized FIFO depth and data width
* Separate **write and read clock domains**
* Gray-coded pointer generation
* Two-stage synchronizers for CDC safety
* FULL and EMPTY flag detection
* Simulation-verified design

---

## Module Structure

| Module            | Description                              |
| ----------------- | ---------------------------------------- |
| `async_fifo.v`    | Top-level FIFO controller                |
| `gray_counter.v`  | Binary counter with Gray code conversion |
| `sync_2ff.v`      | Two-flip-flop synchronizer               |
| `fifo_mem.v`      | Dual-clock FIFO memory                   |
| `tb_async_fifo.v` | Testbench for verification               |

---

## Clock Domain Crossing Strategy

To prevent metastability:

* Multi-bit **data never crosses clock domains**
* Only **Gray-coded pointers** are synchronized
* Two-stage synchronizer stabilizes asynchronous signals

---

## Simulation 

The design was simulated using Icarus Verilog and GTKWave to observe
FIFO behavior under independent read and write clocks.

The waveform demonstrates:

• Correct write pointer increment
• Correct read pointer increment
• Proper Gray code conversion
• Correct EMPTY flag behavior
• Data written to FIFO appears correctly at the read output
---

## How to Run the Simulation

```bash
iverilog -g2012 -o fifo_sim rtl/*.v tb/tb_async_fifo.v
vvp fifo_sim
gtkwave async_fifo.vcd
```

---

## Verification

The design was tested under:

* Fast write / slow read scenarios
* Slow write / fast read scenarios
* Random enable patterns

Results confirmed:

* No data loss
* No duplication
* Stable CDC operation

---

## Author

**Mansi Bhongade**

VLSI | Digital Design | Computer Architecture

