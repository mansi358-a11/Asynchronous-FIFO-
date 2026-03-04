<img width="933" height="646" alt="image" src="https://github.com/user-attachments/assets/a38e7504-d5a4-454f-baa1-2ab4039b4bd9" />

# Asynchronous FIFO for Clock Domain Crossing (CDC)

## Overview

This project implements a **parameterized Asynchronous FIFO in Verilog** to safely transfer data between **independent write and read clock domains**.

In digital systems, when two modules operate on different clocks, directly transferring multi-bit data between them can cause **metastability and data corruption**. An asynchronous FIFO solves this problem by using **memory buffering and pointer synchronization**.

This design demonstrates a **Clock Domain Crossing (CDC) safe architecture** using Gray-coded pointers and two-flip-flop synchronizers.

---

## Architecture


### Key Idea

Instead of transferring data directly between clock domains:

1. Data is written into a **FIFO memory buffer**
2. The **write pointer** and **read pointer** track positions
3. Pointer information is converted to **Gray code**
4. Gray pointers are synchronized across domains using **two-flip-flop synchronizers**

This ensures safe communication between asynchronous clock domains.

---

## Key Features

* Independent **write and read clock domains**
* Parameterized **FIFO depth and data width**
* Binary counters with **Gray code conversion**
* **Two-flip-flop synchronizers** for CDC safety
* FULL and EMPTY detection logic
* Simulation using **Icarus Verilog and GTKWave**

---

## Repository Structure

```
Asynchronous-FIFO
│
├── rtl/
│   ├── async_fifo.v
│   ├── fifo_mem.v
│   ├── gray_counter.v
│   └── sync_2ff.v
│
├── tb/
│   └── tb_async_fifo.v
│
├── images/
│   └── waveform.png
│
├── README.md
└── LICENSE
```

---

## Module Description

| Module            | Description                                     |
| ----------------- | ----------------------------------------------- |
| `async_fifo.v`    | Top-level FIFO module connecting all components |
| `fifo_mem.v`      | Dual-port memory used for FIFO storage          |
| `gray_counter.v`  | Binary counter with Gray code conversion        |
| `sync_2ff.v`      | Two-flip-flop synchronizer for CDC              |
| `tb_async_fifo.v` | Testbench for simulation                        |

---

## Clock Domain Crossing Strategy

To safely transfer data across asynchronous clocks:

* Multi-bit **data remains inside FIFO memory**
* Only **Gray-coded pointers** cross clock domains
* Pointer signals are stabilized using **two-stage flip-flop synchronizers**

This approach significantly reduces the probability of metastability.

---

## Simulation

The design was simulated using **Icarus Verilog** and visualized using **GTKWave**.

### Steps to Run Simulation

```bash
iverilog -g2012 -o fifo_sim rtl/*.v tb/tb_async_fifo.v
vvp fifo_sim
gtkwave async_fifo.vcd
```

---

## Simulation Waveform

<img width="1919" height="847" alt="image" src="https://github.com/user-attachments/assets/281ac924-2721-4762-80f0-faa31f8d9315" />


The waveform shows:

* Write operations using `wr_clk`
* Read operations using `rd_clk`
* Proper increment of read and write pointers
* Correct behavior of **EMPTY flag**
* Data written to the FIFO appearing correctly at the output

---

## Learning Outcomes

Through this project I learned:

* Fundamentals of **Clock Domain Crossing**
* How metastability affects digital systems
* Implementation of **Gray code counters**
* Design of **two-flip-flop synchronizers**
* Simulation and waveform debugging using GTKWave

---

## Author

**Mansi Bhongade**

Undergraduate Student
Digital Design • Computer Architecture • VLSI
cture

