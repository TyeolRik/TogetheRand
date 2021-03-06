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

### Detail Dieharder test Result of TogetheRand

```
#=============================================================================#
#            dieharder version 3.31.1 Copyright 2003 Robert G. Brown          #
#=============================================================================#
   rng_name    |rands/second|   Seed   |
stdin_input_raw|  1.26e+05  |1451879373|
#=============================================================================#
        test_name   |ntup| tsamples |psamples|  p-value |Assessment
#=============================================================================#
   diehard_birthdays|   0|       100|     100|0.04908322|  PASSED  
      diehard_operm5|   0|   1000000|     100|0.98165001|  PASSED  
  diehard_rank_32x32|   0|     40000|     100|0.38924265|  PASSED  
    diehard_rank_6x8|   0|    100000|     100|0.63551270|  PASSED  
   diehard_bitstream|   0|   2097152|     100|0.82911043|  PASSED  
        diehard_opso|   0|   2097152|     100|0.95621020|  PASSED  
        diehard_oqso|   0|   2097152|     100|0.51137986|  PASSED  
         diehard_dna|   0|   2097152|     100|0.29607435|  PASSED  
diehard_count_1s_str|   0|    256000|     100|0.90337991|  PASSED  
diehard_count_1s_byt|   0|    256000|     100|0.16575132|  PASSED  
 diehard_parking_lot|   0|     12000|     100|0.55915630|  PASSED  
    diehard_2dsphere|   2|      8000|     100|0.22960805|  PASSED  
    diehard_3dsphere|   3|      4000|     100|0.90118025|  PASSED  
     diehard_squeeze|   0|    100000|     100|0.93291335|  PASSED  
        diehard_sums|   0|       100|     100|0.70610160|  PASSED  
        diehard_runs|   0|    100000|     100|0.99028470|  PASSED  
        diehard_runs|   0|    100000|     100|0.67174729|  PASSED  
       diehard_craps|   0|    200000|     100|0.56280307|  PASSED  
       diehard_craps|   0|    200000|     100|0.36761674|  PASSED  
 marsaglia_tsang_gcd|   0|  10000000|     100|0.66417544|  PASSED  
 marsaglia_tsang_gcd|   0|  10000000|     100|0.41538531|  PASSED  
         sts_monobit|   1|    100000|     100|0.34107616|  PASSED  
            sts_runs|   2|    100000|     100|0.76642000|  PASSED  
          sts_serial|   1|    100000|     100|0.79979954|  PASSED  
          sts_serial|   2|    100000|     100|0.98289698|  PASSED  
          sts_serial|   3|    100000|     100|0.95329834|  PASSED  
          sts_serial|   3|    100000|     100|0.74001156|  PASSED  
          sts_serial|   4|    100000|     100|0.73592407|  PASSED  
          sts_serial|   4|    100000|     100|0.88377538|  PASSED  
          sts_serial|   5|    100000|     100|0.95539462|  PASSED  
          sts_serial|   5|    100000|     100|0.43361271|  PASSED  
          sts_serial|   6|    100000|     100|0.69399648|  PASSED  
          sts_serial|   6|    100000|     100|0.32720653|  PASSED  
          sts_serial|   7|    100000|     100|0.32775982|  PASSED  
          sts_serial|   7|    100000|     100|0.22858076|  PASSED  
          sts_serial|   8|    100000|     100|0.54847181|  PASSED  
          sts_serial|   8|    100000|     100|0.83228886|  PASSED  
          sts_serial|   9|    100000|     100|0.03019549|  PASSED  
          sts_serial|   9|    100000|     100|0.35822376|  PASSED  
          sts_serial|  10|    100000|     100|0.06415914|  PASSED  
          sts_serial|  10|    100000|     100|0.21443618|  PASSED  
          sts_serial|  11|    100000|     100|0.25119380|  PASSED  
          sts_serial|  11|    100000|     100|0.98425722|  PASSED  
          sts_serial|  12|    100000|     100|0.99684700|   WEAK   
          sts_serial|  12|    100000|     100|0.44171383|  PASSED  
          sts_serial|  13|    100000|     100|0.28115556|  PASSED  
          sts_serial|  13|    100000|     100|0.86761394|  PASSED  
          sts_serial|  14|    100000|     100|0.71844247|  PASSED  
          sts_serial|  14|    100000|     100|0.01035055|  PASSED  
          sts_serial|  15|    100000|     100|0.20816213|  PASSED  
          sts_serial|  15|    100000|     100|0.83070309|  PASSED  
          sts_serial|  16|    100000|     100|0.92322191|  PASSED  
          sts_serial|  16|    100000|     100|0.42004583|  PASSED  
         rgb_bitdist|   1|    100000|     100|0.89576549|  PASSED  
         rgb_bitdist|   2|    100000|     100|0.52399326|  PASSED  
         rgb_bitdist|   3|    100000|     100|0.85946950|  PASSED  
         rgb_bitdist|   4|    100000|     100|0.51368492|  PASSED  
         rgb_bitdist|   5|    100000|     100|0.91690382|  PASSED  
         rgb_bitdist|   6|    100000|     100|0.05843667|  PASSED  
         rgb_bitdist|   7|    100000|     100|0.35391016|  PASSED  
         rgb_bitdist|   8|    100000|     100|0.28188555|  PASSED  
         rgb_bitdist|   9|    100000|     100|0.98394461|  PASSED  
         rgb_bitdist|  10|    100000|     100|0.37890934|  PASSED  
         rgb_bitdist|  11|    100000|     100|0.52989768|  PASSED  
         rgb_bitdist|  12|    100000|     100|0.02416635|  PASSED  
rgb_minimum_distance|   2|     10000|    1000|0.16819249|  PASSED  
rgb_minimum_distance|   3|     10000|    1000|0.57998004|  PASSED  
rgb_minimum_distance|   4|     10000|    1000|0.99144891|  PASSED  
rgb_minimum_distance|   5|     10000|    1000|0.40015505|  PASSED  
    rgb_permutations|   2|    100000|     100|0.68485327|  PASSED  
    rgb_permutations|   3|    100000|     100|0.77234351|  PASSED  
    rgb_permutations|   4|    100000|     100|0.97596595|  PASSED  
    rgb_permutations|   5|    100000|     100|0.02311406|  PASSED  
      rgb_lagged_sum|   0|   1000000|     100|0.58603567|  PASSED  
      rgb_lagged_sum|   1|   1000000|     100|0.16641329|  PASSED  
      rgb_lagged_sum|   2|   1000000|     100|0.95964979|  PASSED  
      rgb_lagged_sum|   3|   1000000|     100|0.15479021|  PASSED  
      rgb_lagged_sum|   4|   1000000|     100|0.74123306|  PASSED  
      rgb_lagged_sum|   5|   1000000|     100|0.47781777|  PASSED  
      rgb_lagged_sum|   6|   1000000|     100|0.92637534|  PASSED  
      rgb_lagged_sum|   7|   1000000|     100|0.38685829|  PASSED  
      rgb_lagged_sum|   8|   1000000|     100|0.72943435|  PASSED  
      rgb_lagged_sum|   9|   1000000|     100|0.82081801|  PASSED  
      rgb_lagged_sum|  10|   1000000|     100|0.89318844|  PASSED  
      rgb_lagged_sum|  11|   1000000|     100|0.65007902|  PASSED  
      rgb_lagged_sum|  12|   1000000|     100|0.53736251|  PASSED  
      rgb_lagged_sum|  13|   1000000|     100|0.60284290|  PASSED  
      rgb_lagged_sum|  14|   1000000|     100|0.72874534|  PASSED  
      rgb_lagged_sum|  15|   1000000|     100|0.96417840|  PASSED  
      rgb_lagged_sum|  16|   1000000|     100|0.05193625|  PASSED  
      rgb_lagged_sum|  17|   1000000|     100|0.81459645|  PASSED  
      rgb_lagged_sum|  18|   1000000|     100|0.02341025|  PASSED  
      rgb_lagged_sum|  19|   1000000|     100|0.85610107|  PASSED  
      rgb_lagged_sum|  20|   1000000|     100|0.58015144|  PASSED  
      rgb_lagged_sum|  21|   1000000|     100|0.89278610|  PASSED  
      rgb_lagged_sum|  22|   1000000|     100|0.84728861|  PASSED  
      rgb_lagged_sum|  23|   1000000|     100|0.79845133|  PASSED  
      rgb_lagged_sum|  24|   1000000|     100|0.41682576|  PASSED  
      rgb_lagged_sum|  25|   1000000|     100|0.07737071|  PASSED  
      rgb_lagged_sum|  26|   1000000|     100|0.35145527|  PASSED  
      rgb_lagged_sum|  27|   1000000|     100|0.13232949|  PASSED  
      rgb_lagged_sum|  28|   1000000|     100|0.42560335|  PASSED  
      rgb_lagged_sum|  29|   1000000|     100|0.21088770|  PASSED  
      rgb_lagged_sum|  30|   1000000|     100|0.56620913|  PASSED  
      rgb_lagged_sum|  31|   1000000|     100|0.94019583|  PASSED  
      rgb_lagged_sum|  32|   1000000|     100|0.98609725|  PASSED  
     rgb_kstest_test|   0|     10000|    1000|0.73459077|  PASSED  
     dab_bytedistrib|   0|  51200000|       1|0.64856678|  PASSED  
             dab_dct| 256|     50000|       1|0.87339645|  PASSED  
Preparing to run test 207.  ntuple = 0
        dab_filltree|  32|  15000000|       1|0.93532588|  PASSED  
        dab_filltree|  32|  15000000|       1|0.29498161|  PASSED  
Preparing to run test 208.  ntuple = 0
       dab_filltree2|   0|   5000000|       1|0.88293020|  PASSED  
       dab_filltree2|   1|   5000000|       1|0.65198855|  PASSED  
Preparing to run test 209.  ntuple = 0
        dab_monobit2|  12|  65000000|       1|0.11319156|  PASSED  

485301 seconds costs for Dieharder -a -g 200
-> 134 hr 48 min 21 sec
```