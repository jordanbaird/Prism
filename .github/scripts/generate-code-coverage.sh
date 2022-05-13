#!/bin/bash

DEBUG_FOLDER=".build/debug"
TESTS="$DEBUG_FOLDER/PrismPackageTests.xctest"
PROFILE="$DEBUG_FOLDER/codecov/default.profdata"

llvm-cov \
  export -format="lcov" $TESTS \
  -instr-profile $PROFILE > info.lcov
