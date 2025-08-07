# RUN: llvm-mc %s -triple=riscv32 -mattr=+a,+y,+zyhybrid -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv32 -mattr=+a,+y,+zyhybrid < %s \
# RUN:     | llvm-objdump --mattr=+a,+y,+zyhybrid,+cap-mode -M no-aliases -d -r - \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM-AND-OBJ %s

# RUN: llvm-mc %s -triple=riscv64 -mattr=+a,+y,+zyhybrid -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 -mattr=+a,+y,+zyhybrid < %s \
# RUN:     | llvm-objdump --mattr=+a,+y,+zyhybrid,+cap-mode -M no-aliases -d -r - \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM-AND-OBJ %s

# Tests instructions available in purecap + A, rv32 and rv64.

.option capmode

# CHECK-ASM-AND-OBJ: amoswap.w a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x08]
amoswap.w a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoswap.w.aq a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x0c]
amoswap.w.aq a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoswap.w.rl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x0a]
amoswap.w.rl a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoswap.w.aqrl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x0e]
amoswap.w.aqrl a1, a2, 0(ca3)

# CHECK-ASM-AND-OBJ: amoadd.w a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x00]
amoadd.w a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoadd.w.aq a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x04]
amoadd.w.aq a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoadd.w.rl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x02]
amoadd.w.rl a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoadd.w.aqrl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x06]
amoadd.w.aqrl a1, a2, 0(ca3)

# CHECK-ASM-AND-OBJ: amoxor.w a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x20]
amoxor.w a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoxor.w.aq a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x24]
amoxor.w.aq a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoxor.w.rl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x22]
amoxor.w.rl a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoxor.w.aqrl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x26]
amoxor.w.aqrl a1, a2, 0(ca3)

# CHECK-ASM-AND-OBJ: amoand.w a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x60]
amoand.w a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoand.w.aq a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x64]
amoand.w.aq a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoand.w.rl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x62]
amoand.w.rl a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoand.w.aqrl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x66]
amoand.w.aqrl a1, a2, 0(ca3)

# CHECK-ASM-AND-OBJ: amoor.w a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x40]
amoor.w a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoor.w.aq a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x44]
amoor.w.aq a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoor.w.rl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x42]
amoor.w.rl a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amoor.w.aqrl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x46]
amoor.w.aqrl a1, a2, 0(ca3)

# CHECK-ASM-AND-OBJ: amomin.w a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x80]
amomin.w a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amomin.w.aq a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x84]
amomin.w.aq a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amomin.w.rl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x82]
amomin.w.rl a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amomin.w.aqrl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0x86]
amomin.w.aqrl a1, a2, 0(ca3)

# CHECK-ASM-AND-OBJ: amomax.w a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xa0]
amomax.w a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amomax.w.aq a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xa4]
amomax.w.aq a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amomax.w.rl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xa2]
amomax.w.rl a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amomax.w.aqrl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xa6]
amomax.w.aqrl a1, a2, 0(ca3)

# CHECK-ASM-AND-OBJ: amominu.w a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xc0]
amominu.w a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amominu.w.aq a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xc4]
amominu.w.aq a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amominu.w.rl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xc2]
amominu.w.rl a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amominu.w.aqrl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xc6]
amominu.w.aqrl a1, a2, 0(ca3)

# CHECK-ASM-AND-OBJ: amomaxu.w a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xe0]
amomaxu.w a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amomaxu.w.aq a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xe4]
amomaxu.w.aq a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amomaxu.w.rl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xe2]
amomaxu.w.rl a1, a2, 0(ca3)
# CHECK-ASM-AND-OBJ: amomaxu.w.aqrl a1, a2, (ca3)
# CHECK-ASM: # encoding: [0xaf,0xa5,0xc6,0xe6]
amomaxu.w.aqrl a1, a2, 0(ca3)

# CHECK-ASM-AND-OBJ: lr.w a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x25,0x05,0x10]
lr.w a1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.w.aq a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x25,0x05,0x14]
lr.w.aq a1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.w.rl a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x25,0x05,0x12]
lr.w.rl a1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.w.aqrl a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x25,0x05,0x16]
lr.w.aqrl a1, 0(ca0)

# CHECK-ASM-AND-OBJ: lr.h a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x15,0x05,0x10]
lr.h a1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.h.aq a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x15,0x05,0x14]
lr.h.aq a1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.h.rl a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x15,0x05,0x12]
lr.h.rl a1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.h.aqrl a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x15,0x05,0x16]
lr.h.aqrl a1, 0(ca0)

# CHECK-ASM-AND-OBJ: lr.b a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x05,0x05,0x10]
lr.b a1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.b.aq a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x05,0x05,0x14]
lr.b.aq a1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.b.rl a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x05,0x05,0x12]
lr.b.rl a1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.b.aqrl a1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x05,0x05,0x16]
lr.b.aqrl a1, 0(ca0)

# CHECK-ASM-AND-OBJ: sc.w a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x25,0xc5,0x18]
sc.w a1, a2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.w.aq a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x25,0xc5,0x1c]
sc.w.aq a1, a2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.w.rl a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x25,0xc5,0x1a]
sc.w.rl a1, a2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.w.aqrl a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x25,0xc5,0x1e]
sc.w.aqrl a1, a2, 0(ca0)

# CHECK-ASM-AND-OBJ: sc.h a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x15,0xc5,0x18]
sc.h a1, a2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.h.aq a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x15,0xc5,0x1c]
sc.h.aq a1, a2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.h.rl a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x15,0xc5,0x1a]
sc.h.rl a1, a2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.h.aqrl a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x15,0xc5,0x1e]
sc.h.aqrl a1, a2, 0(ca0)

# CHECK-ASM-AND-OBJ: sc.b a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x05,0xc5,0x18]
sc.b a1, a2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.b.aq a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x05,0xc5,0x1c]
sc.b.aq a1, a2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.b.rl a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x05,0xc5,0x1a]
sc.b.rl a1, a2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.b.aqrl a1, a2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x05,0xc5,0x1e]
sc.b.aqrl a1, a2, 0(ca0)

# CHECK-ASM-AND-OBJ: lr.y ca1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0x05,0x10]
lr.y ca1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.y.aq ca1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0x05,0x14]
lr.y.aq ca1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.y.rl ca1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0x05,0x12]
lr.y.rl ca1, 0(ca0)
# CHECK-ASM-AND-OBJ: lr.y.aqrl ca1, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0x05,0x16]
lr.y.aqrl ca1, 0(ca0)

# CHECK-ASM-AND-OBJ: amoswap.y ca1, ca2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0xc5,0x08]
amoswap.y ca1, ca2, 0(ca0)
# CHECK-ASM-AND-OBJ: amoswap.y.aq ca1, ca2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0xc5,0x0c]
amoswap.y.aq ca1, ca2, 0(ca0)
# CHECK-ASM-AND-OBJ: amoswap.y.rl ca1, ca2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0xc5,0x0a]
amoswap.y.rl ca1, ca2, 0(ca0)
# CHECK-ASM-AND-OBJ: amoswap.y.aqrl ca1, ca2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0xc5,0x0e]
amoswap.y.aqrl ca1, ca2, 0(ca0)

# CHECK-ASM-AND-OBJ: sc.y a1, ca2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0xc5,0x18]
sc.y a1, ca2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.y.aq a1, ca2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0xc5,0x1c]
sc.y.aq a1, ca2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.y.rl a1, ca2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0xc5,0x1a]
sc.y.rl a1, ca2, 0(ca0)
# CHECK-ASM-AND-OBJ: sc.y.aqrl a1, ca2, (ca0)
# CHECK-ASM: # encoding: [0xaf,0x45,0xc5,0x1e]
sc.y.aqrl a1, ca2, 0(ca0)
