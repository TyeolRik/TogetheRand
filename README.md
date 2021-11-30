# TogetheRand
TogetheRand : the Collaborative Random Number Generator

## Requirements

- [Truffle](https://www.trufflesuite.com/docs/truffle/overview)
- [Ganache](https://www.trufflesuite.com/docs/ganache/overview) (Note that, **Not selecting auto-mining** in your environment.)
- [Solidity](https://docs.soliditylang.org/en/latest/) Compiler v0.8.9 or later

## How to test

```console
$ truffle compile
$ truffle migrate
$ truffle test --show-events
```

## Design

![Overview of TogetheRand](https://i.imgur.com/1rFjZ5i.png)

This pseudorandom number generator includes keccak256 and WELL512a for generating secure random sequence.

## Randomness tests result

Randomness test is proceeded using [Dieharder tests](https://linux.die.net/man/1/dieharder).

|       PRNG      | PASSED | WEAK | FAILED | Pass Ratio |
|:---------------:|:------:|:----:|:------:|:----------:|
|   ANSI C rand   |   28   |   0  |   86   |   24.561%  |
| C++ minstd_rand |   26   |   2  |   86   |   22.807%  |
|   C++ mt19937   |   112  |   2  |    0   |   98.246%  |
|   TogetheRand   |   113  |   1  |    0   |   99.123%  |