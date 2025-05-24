# 🎲 FPGA-Based 8-Bit Pseudorandom Number Generator (PRNG)

This repository contains an RTL implementation of an FPGA-based **Pseudorandom Number Generator (PRNG)** using an 8-bit **Fibonacci Linear Feedback Shift Register (LFSR)** seeded with an 8-bit input. The design features user-controlled seeding, debouncing logic, and seven-segment display support for visual output.

---

## 📄 Description

The design consists of modular SystemVerilog components to generate pseudorandom sequences using a Fibonacci LFSR. A Mealy FSM handles debouncing of user inputs (e.g., buttons), and the output is displayed via a 7-segment display.

---

## 📂 File Overview

| File                   | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| `debounce_mealy_fsm.v` | Debounce logic implemented as a Mealy FSM to filter noisy input signals.   |
| `fibonacci_lsfr.v`     | 8-bit Fibonacci LFSR module generating pseudorandom numbers.                |
| `fibonacci_lsfr_tb.v`  | Testbench for the `fibonacci_lsfr.v` module.                                |
| `lsfr.v`               | General-purpose LFSR module (can be extended for more bits).                |
| `lsfr_tb.v`            | Testbench for `lsfr.v`.                                                     |
| `seven_segment.v`      | Converts 8-bit output to drive a 7-segment display.                         |
| `seven_segment_tb.v`   | Testbench for `seven_segment.v`.                                            |
| `top_fibonacci.v`      | Top-level module integrating LFSR, debounce FSM, and display.               |
| `top_fibonacci_tb.v`   | Testbench for the top-level PRNG system.                                    |

---

## 🛠️ Features

- 8-bit pseudorandom number generation using Fibonacci LFSR
- Seed-based initialization for repeatable randomness
- Debounce FSM for clean button inputs
- 7-segment display interface for visual output
- Modular design for FPGA or ASIC implementation
- Simulation testbenches for all key modules

---

## ▶️ Simulation

Simulate using any SystemVerilog-compatible simulator, e.g. Vivado etc.
