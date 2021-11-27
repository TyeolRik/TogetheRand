// TyeolRik
// Distributed Computing Lab., Univ. of Seoul.
// Version 0.1.0.
// Date : 2021. 11. 02.

// SPDX-License-Identifier: MIT License
pragma solidity >=0.8.9 <0.9.0;

contract TogetheRand {
    // In this Contract version,
    // We need 6 blocks to make Random number properly.
    // Each block needs at least 2 participants or it is not sure whether proper random or not.
    // Keccak + WELL512a

    // Events for Logging and Testing
    event BLOCK_NUMBERS(uint256[] blockNumbers);
    event PERSONAL_INPUTS(bytes32[12] personalInput);
    event CHECK_IF(bool value);
    event SHOW_KECCAK256_OF_BLOCK(uint blockNumber, bytes32 keccak256_results);
    event SHOW_PART1(bytes4[8] part1);
    event SHOW_PART2(bytes4[8] part2);
    event SHOW_BEFORE_OUTPUTs(bytes4[] outputs);
    event SHOW_OUTPUTs(bytes4[] outputs);

    // About WELL512
    struct WELL512a {
        // Random Number Generator
        // Well equidistributed long-period linear
        bytes4[16] state;
        uint8 state_i;
        bytes4 z0;
        bytes4 z1;
        bytes4 z2;
        // No need because we can hard-code due to reduce memory in WELL512a
        // uint32 w;  // 32
        // uint32 r;  // 16
        // uint32 0;  //  0
        // uint32 m1; // 13
        // uint32 m2; //  9
        // uint32 m3; //  5
    }
    WELL512a well512a;

    function nextWELL512a() internal returns (bytes4) {
        uint8 temp = uint8((well512a.state_i + 15) & 0xF); // Mask 4 bits means 0 ~ 15
        well512a.z0 = well512a.state[temp];

        well512a.z1 =
            (well512a.state[well512a.state_i] ^
                (well512a.state[well512a.state_i] << 16)) ^
            (well512a.state[(well512a.state_i + 13) & 0x0000000F] ^
                (well512a.state[(well512a.state_i + 13) & 0x0000000F] << 15));

        well512a.z2 = (well512a.state[(well512a.state_i + 9) & 0x0000000F] ^
            (well512a.state[(well512a.state_i + 9) & 0x0000000F] >> 11));

        well512a.state[well512a.state_i] = well512a.z1 ^ well512a.z2;

        well512a.state[temp] =
            (well512a.z0 ^ (well512a.z0 << 2)) ^
            (well512a.z1 ^ (well512a.z1 << 18)) ^
            (well512a.z2 << 28) ^
            (well512a.state[well512a.state_i] ^
                ((well512a.state[well512a.state_i] << 5) & 0xDA442D24));

        well512a.state_i = temp;
        return well512a.state[well512a.state_i];
    }

    struct Participant {
        address payable addr;
        uint8 order;
        bytes32 personalInput;
        bytes4 returnNumbers;
    }

    struct Block {
        Participant[] participants;
        bytes32 blockKeccak;
    }

    // Declare variables
    uint8 globalOrderCounter = 0;
    mapping(uint256 => Block) public blocks;
    uint256[] public blockNumbers;
    bytes32[12] public personalInputs;

    function __Bytes32ToBytes4_8array(bytes32 input) pure private returns (bytes4[8] memory) {
        bytes4[8] memory ret;
        ret[0] = bytes4(input&0xFFFFFFFF00000000000000000000000000000000000000000000000000000000);
        ret[1] = bytes4((input<<32)&0xFFFFFFFF00000000000000000000000000000000000000000000000000000000);
        ret[2] = bytes4((input<<64)&0xFFFFFFFF00000000000000000000000000000000000000000000000000000000);
        ret[3] = bytes4((input<<96)&0xFFFFFFFF00000000000000000000000000000000000000000000000000000000);
        ret[4] = bytes4((input<<128)&0xFFFFFFFF00000000000000000000000000000000000000000000000000000000);
        ret[5] = bytes4((input<<160)&0xFFFFFFFF00000000000000000000000000000000000000000000000000000000);
        ret[6] = bytes4((input<<192)&0xFFFFFFFF00000000000000000000000000000000000000000000000000000000);
        ret[7] = bytes4((input<<224)&0xFFFFFFFF00000000000000000000000000000000000000000000000000000000);
        return ret;
    }

    function __XOR_bytes4arr_bytes4arr(bytes4[8] memory a, bytes4[8] memory b) pure private returns (bytes4[8] memory) {
        bytes4[8] memory ret;
        for(uint8 i = 0; i < 8; i++) {
            ret[i] = a[i] ^ b[i];
        }
        return ret;
    }

    function START(bytes32 _personalInput) external payable {
        this.Participate(_personalInput);
    }

    function GetGlobalOrderCounter() external view returns(uint8) {
        // 0x47e9f582
        return globalOrderCounter;
    }

    function PrintPersonalinputs() external view returns(bytes32[12] memory) {
        // 0x440bef0b
        return personalInputs;
    }

    function Participate(bytes32 _personalInput) external payable {
        // 0xedd47568
        personalInputs[globalOrderCounter] = _personalInput;

        // Push New Participant struct into block's array
        bool existance = false;
        for(uint i = 0; i < blockNumbers.length; i++) {
            if(blockNumbers[i] == block.number) {
                existance = true;
            }
        }
        if(!existance) {
            blockNumbers.push(block.number);
        }
        blocks[block.number].participants.push(
            Participant(
                payable(msg.sender),
                globalOrderCounter++,
                _personalInput,
                0
            )
        );
        blocks[block.number].blockKeccak =
            blocks[block.number].blockKeccak ^
            _personalInput; // XOR
    }

    function END() external payable {
        if ( // There is 3 Conditions to END (getting random number)
            blockNumbers.length >= 6 && // Block length
            globalOrderCounter >= 12 // && // Total number of participants (That means at least 2 participants at each blocks)
            // blocks[blockNumbers[blockNumbers.length - 1]].participants.length >= 2    // Last block
        ) {
            //emit CHECK_IF(true);
            // Safe
            //emit BLOCK_NUMBERS(blockNumbers);
            //emit PERSONAL_INPUTS(personalInputs);

            // 1. Using Hash function (keccak256) from all XOR-ed User input
            for(uint8 i = 0; i < blockNumbers.length; i++) {
                blocks[blockNumbers[i]].blockKeccak = keccak256(abi.encode(blocks[blockNumbers[i]].blockKeccak));
                emit SHOW_KECCAK256_OF_BLOCK(uint(i), blocks[blockNumbers[i]].blockKeccak);
            }

            // 2. Do WELL512a
            // We have 6 (or more) keccak datas for seeds. (32 bytes * 6 blocks)
            // But we only need 64 bytes for WELL512a.
            // So, We are mix them for security.
            // How to mix?
            // Let each 6 datas as A, B, C, D, E, F
            // concat((A xor C xor E), (B xor D xor F)) like this.
            bytes4[8] memory part1 = [bytes4(0), bytes4(0), bytes4(0), bytes4(0), bytes4(0), bytes4(0), bytes4(0), bytes4(0)];
            bytes4[8] memory part2 = [bytes4(0), bytes4(0), bytes4(0), bytes4(0), bytes4(0), bytes4(0), bytes4(0), bytes4(0)];

            // A xor C xor E xor ...
            for(uint8 blockIndex = 0; blockIndex < blockNumbers.length; blockIndex = blockIndex + 2) {
                part1 = __XOR_bytes4arr_bytes4arr(part1, __Bytes32ToBytes4_8array(blocks[blockNumbers[blockIndex]].blockKeccak));
            }

            // B xor D xor F xor ...
            for(uint8 blockIndex = 1; blockIndex < blockNumbers.length; blockIndex = blockIndex + 2) {
                part2 = __XOR_bytes4arr_bytes4arr(part2, __Bytes32ToBytes4_8array(blocks[blockNumbers[blockIndex]].blockKeccak));
            }

            emit SHOW_PART1(part1);
            emit SHOW_PART2(part2);
            
            well512a = WELL512a(
                [part1[0], part1[1], part1[2], part1[3], part1[4], part1[5], part1[6], part1[7], part2[0], part2[1], part2[2], part2[3], part2[4], part2[5], part2[6], part2[7]],   // state(=seed)
                0,  // state_i
                0,  // z0 (Don't touch)
                0,  // z1 (Don't touch)
                0   // z2 (Don't touch)
            );
            
            // 3. Distribute Random Number
            bytes4[] memory outputRandomNumbers = new bytes4[](globalOrderCounter);
            for(uint8 i = 0; i < globalOrderCounter; i++) {
                outputRandomNumbers[i] = nextWELL512a();
            }
            emit SHOW_BEFORE_OUTPUTs(outputRandomNumbers);

            // Shuffle using Fisher–Yates shuffle and WELL512a
            bytes4 temp;
            for(uint8 i = globalOrderCounter - 1; i > 0; i--) {
                uint8 j = uint8(bytes1(nextWELL512a())) % i;
                // Exchange outputRandomNumbers[i], outputRandomNumbers[j]
                temp = outputRandomNumbers[i];
                outputRandomNumbers[i] = outputRandomNumbers[j];
                outputRandomNumbers[j] = temp;
            }
            emit SHOW_OUTPUTs(outputRandomNumbers);
            uint8 tempIndex = 0;
            for(uint8 blockIndex = 0; blockIndex < blockNumbers.length; blockIndex++) {
                for(uint8 participantIndex = 0; participantIndex < blocks[blockNumbers[blockIndex]].participants.length; participantIndex++) {
                    blocks[blockNumbers[blockIndex]].participants[participantIndex].returnNumbers = outputRandomNumbers[tempIndex++];
                }
            }
        } else {
            emit CHECK_IF(false);
            // Not safe
        }
    }

    function Checker() external {
        emit BLOCK_NUMBERS(blockNumbers);

        // 1. Using Hash function (keccak256) from all XOR-ed User input
        for(uint8 i = 0; i < blockNumbers.length; i++) {
            blocks[blockNumbers[i]].blockKeccak = keccak256(abi.encode(blocks[blockNumbers[i]].blockKeccak));
            emit SHOW_KECCAK256_OF_BLOCK(uint(i), blocks[blockNumbers[i]].blockKeccak);
        }
    }

    function GETmyRandomNumber(address addr) external view returns (bytes4) {
        for(uint8 blockIndex = 0; blockIndex < blockNumbers.length; blockIndex++) {
            for(uint8 participantIndex = 0; participantIndex < blocks[blockNumbers[blockIndex]].participants.length; participantIndex++) {
                if(blocks[blockNumbers[blockIndex]].participants[participantIndex].addr == payable(addr)) {
                    return blocks[blockNumbers[blockIndex]].participants[participantIndex].returnNumbers;
                }
            }
        }
    }
}