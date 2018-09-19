CGRA Test [![Build Status](https://travis-ci.com/Kuree/cgra_test.svg?branch=master)](https://travis-ci.com/Kuree/cgra_test)
---
This repo tests every operators that Halide-CGRA uses and will be mapped to CGRA. This is an end-to-end test, aiming to discover any bugs in the downstream tools, such as `CGRAMapper`, `PnR`, `Bitstream Builder`, and PE implementations.

### Install
THe entire suite depends on several repos in Stanford AHA projects. As a result, there will be some particular requirements on some of the components, namely:
1. `csh` will be used internally, as used in `CGRAGenerator`
2. `Python3` has to be used, as used in `TestBenchGenerator`
3. `verilator` will be used to verify the end result
```
$ sudo apt-get install csh
$ sudo apt-get install verilator
```

### Run the tests
First we need to set the environment for testing.
```
$ source ./scripts/set_env.sh
```
We also need to generate `cgra_info.txt` file and download PnR tools.
```
(cgra) $ ./scripts/cgra_gen.sh
(cgra) $ ./scripts/pnr_setup.sh
```
Then we run the tests
```
(cgra) $ ./scripts/run_tests.sh
```
Finally, clean up the test environment.
```
(cgra) $ deactivate_cgra
```
### Status
Following operator passed the tests:
+ abs
+ ucomp
+ arith
+ uminmax
+ bool
+ scomp
+ shift
+ ternary

Following operators failed to pass the tests for various reasons:
+ sminmax
+ bitwise
+ eq
