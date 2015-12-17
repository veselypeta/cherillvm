# RUN: llvm-mc -triple=cheri-unknown-freebsd -disassemble %s | FileCheck %s
#
# Check that the disassembler is able to handle capability memory instructions.
#

# CHECK: csc	$c0, $13, 3($c1)
0xf8,0x01,0x68,0x03
# CHECK: clc	$c0, $13, 3($c1)
0xd8,0x01,0x68,0x03
# CHECK: clb	$12, $13, 3($c1)
0xc9,0x81,0x68,0x1c
# CHECK: clh	$12, $13, 3($c1)
0xc9,0x81,0x68,0x1d
# CHECK: clw	$12, $13, 3($c1)
0xc9,0x81,0x68,0x1e
# CHECK: clbu	$12, $13, 3($c1)
0xc9,0x81,0x68,0x18
# CHECK: clhu	$12, $13, 3($c1)
0xc9,0x81,0x68,0x19
# CHECK: clwu	$12, $13, 3($c1)
0xc9,0x81,0x68,0x1a
# CHECK: cld	$12, $13, 3($c1)
0xc9,0x81,0x68,0x1b
# CHECK: csb	$12, $13, 3($c1)
0xe9,0x81,0x68,0x18
# CHECK: csh	$12, $13, 3($c1)
0xe9,0x81,0x68,0x19
# CHECK: csw	$12, $13, 3($c1)
0xe9,0x81,0x68,0x1a
# CHECK: csd	$12, $13, 3($c1)
0xe9,0x81,0x68,0x1b
