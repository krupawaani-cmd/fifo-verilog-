# fifo-verilog-
FIFO Design in Verilog

This project implements an 8-bit wide, 8-depth FIFO (First In First Out) buffer using Verilog.
It includes the design, testbench, and simulation waveform.

Project Structure

fifo.v → FIFO RTL design
fifo_tb.v → Testbench code
fifo_waveform.png → Screenshot of waveform from simulation

Features

Parameterized FIFO (configurable depth and width)

Status flags:

fifo_empty

fifo_full

status_counter tracks number of elements

Write and Read operations synchronized with clock
