# Algorithms-on-Hardware-Bit-Counting-Circuit-using-ASM-chart-
This repository contains the verilog code, testbenches and simulations waveforms to show how Algorithmic State Machines (ASM) charts are used as a design tool that allow the specification of digital systems in a form similar to a flow chart. This project was designed in 
Altera's Quartus Prime using Verilog HDL. Modelsim Altera was used to view simulation waveforms. 

# Basic Understanding and Design Methodology
ASM chart for a bit counting circuit is shown below:
![Capture](https://github.com/user-attachments/assets/a9462274-7c22-4a4d-8811-486834838c3c)
- It represents a circuit that counts the number of bits set to 1 in an n-bit input A .
- The rectangular boxes in this diagram represent the states of the digital system, and actions specified inside of a state box occur on each active clock edge in this state.
- Transitions between states are specified by arrows.
- The diamonds in the ASM chart represent conditional tests.
- The ovals represent actions taken only if the corresponding conditions are either true (on an arrow labeled 1) or false (on an arrow labeled 0).
- In this ASM chart, state S1 is the initial state. In this state the result is initialized to 0, and data is loaded into a register A, until a start signal, s, is asserted. The ASM chart then transitions to state S2, where it increments the result to count the number of
  1’s in register A. Since state S2 specifies a shifting operation. Also, since the result is incremented.  When register A contains 0 the ASM chart transitions to state S3, where it sets an output Done = 1 and waits for the signal s to be deasserted.

This ciruit was implemented on DE1-SOC. Various input and output modules of the board was used during this exercise.
- Slide switches ( 0 to 7) were used as 8-bit inputs.
- KEY0 was used as an synchorous reset.
- SW9 was used as a start signal.
- HEX0 ( seven segment display) was used to display the total number of ones in an n-bit input.
- LEDR9 was used as a finish signal.

#Files

