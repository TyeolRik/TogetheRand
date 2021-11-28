from web3 import Web3
import json

def printArray(input):
    print("{", end='')
    for i in range(len(input)-1):
        print("0x%X, " % input[i], end='')
    print("0x%X}" % input[len(input)-1])


def padding_hex_to_bytes32(input):
    if(input[:2] == "0x"):
        input = input[2:]
    for i in range(64 - len(input)):
        input = '0' + input
    return '0x'+input

inputs = [
        0x12,
        0x34,
        0x56,
        0x78,
        0x9A,
        0xBC,
        0xDE,
        0xF1,
        0x23,
        0x45,
        0x67,
        0x89,
]

printArray(inputs)

block_inputs = []
for i in range(0, len(inputs), 2):
    block_inputs.append(inputs[i] ^ inputs[i+1])

block_inputs_keccak = []
print("idx" + '\t' + "block_inputs" + "\t" + "Keccak256")
for i in range(len(block_inputs)):
    padded = padding_hex_to_bytes32("%X" % block_inputs[i])
    block_inputs_keccak.append(int("0x" + Web3.solidityKeccak(['bytes32'], [padded]).hex().upper()[2:], 16))
    print(str(i) + "\t" + "0x%X" % block_inputs[i] + "\t\t" + "0x%X" % block_inputs_keccak[i])

print("Keccak256 = ", end='')
printArray(block_inputs_keccak)

part1 = 0
part2 = 0

for i in range(0, len(block_inputs_keccak), 2):
    part1 = part1 ^ block_inputs_keccak[i]
    part2 = part2 ^ block_inputs_keccak[i+1]

print("part1" + "\t" + "0x%X" % part1)
print("part2" + "\t" + "0x%X" % part2)

concat = ("%X" % part1) + ("%X" % part2)
print("concat\t" + concat)

print("WELL512a")
seeds = []
for i in range(0, len(concat), 8):
    seeds.append("0x"+concat[i:i+8])

print("SEED\t" + json.dumps(seeds))

well512 = [0x2087986d,0xd007b7f0,0xf12cca2d,0x853e93f4,0x97c14b7a,0xf8df31a5,0x477ac4e5,0xddb1ec13,0x7db7c9cb,0x79f21717,0xb800f6de,0x5970626a]
well512_str = []
for x in well512:
    well512_str.append("0x%X" % x)

print("Returns\t" + json.dumps(well512_str))
printArray(well512)