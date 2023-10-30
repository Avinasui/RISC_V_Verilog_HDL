# RISC_V-Verilog HDL

The project "RISC-V RV32I RTL Design using Verilog HD" introduces a 
robust RISC-V processor constructed with careful considerations of 
architectural design and performance optimization. This processor is engineered 
to execute all six different instruction types available in the RV32I instruction 
set architecture.

The core architectural design features a traditional 5-stage pipeline 
encompassing the Fetch, Decode, Execute, Memory, and Write Back stages. 
However, to enhance performance and minimize the Clocks Per Instruction 
(CPI) and CPU execution time, the processor's Register-Transfer Level (RTL) 
implementation has been adapted to a more efficient 3-stage pipeline design 
with 2 Pipeline registers. 
