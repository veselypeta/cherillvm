# RUN: not llvm-mc -triple riscv32 -mattr=+y,+cap-mode <%s 2>&1 \
# RUN:     | FileCheck %s -check-prefixes=CHECK
# RUN: not llvm-mc -triple riscv64 -mattr=+y,+cap-mode <%s 2>&1 \
# RUN:     | FileCheck %s -check-prefixes=CHECK

ymodew      ca0, ca0, a0     # CHECK: <stdin>:[[#@LINE]]:1:  error: instruction requires the following: 'zyhybrid' (Backwards compatiblity for 'y' with RISCV)
scmode      ca0, ca0, a0     # CHECK: <stdin>:[[#@LINE]]:1:  error: instruction requires the following: 'zyhybrid' (Backwards compatiblity for 'y' with RISCV)

ymodeswy                     # CHECK: <stdin>:[[#@LINE]]:1:  error: instruction requires the following: 'zyhybrid' (Backwards compatiblity for 'y' with RISCV)
modesw.cap                   # CHECK: <stdin>:[[#@LINE]]:1:  error: instruction requires the following: 'zyhybrid' (Backwards compatiblity for 'y' with RISCV)

ymodeswi                     # CHECK: <stdin>:[[#@LINE]]:1:  error: instruction requires the following: 'zyhybrid' (Backwards compatiblity for 'y' with RISCV)
modesw.int                   # CHECK: <stdin>:[[#@LINE]]:1:  error: instruction requires the following: 'zyhybrid' (Backwards compatiblity for 'y' with RISCV)

gcmode      a0, ca0          # CHECK: <stdin>:[[#@LINE]]:1:  error: instruction requires the following: 'zyhybrid' (Backwards compatiblity for 'y' with RISCV)
ymoder      a0, ca0          # CHECK: <stdin>:[[#@LINE]]:1:  error: instruction requires the following: 'zyhybrid' (Backwards compatiblity for 'y' with RISCV)

ybndsiw     ca0, ca0, 33     # CHECK: <stdin>:[[#@LINE]]:23: error: immediate must be an integer in range [0, 31] or be a multiple of 16 in the range [0, 496]
ybndsiw     ca0, ca0, 104    # CHECK: <stdin>:[[#@LINE]]:23: error: immediate must be an integer in range [0, 31] or be a multiple of 16 in the range [0, 496]
ybndsiw     ca0, ca0, 512    # CHECK: <stdin>:[[#@LINE]]:23: error: immediate must be an integer in range [0, 31] or be a multiple of 16 in the range [0, 496]
