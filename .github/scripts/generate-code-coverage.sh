#!/bin/bash

DEBUG_FOLDER=".build/debug"
TESTS="$DEBUG_FOLDER/PrismPackageTests.xctest/Contents/MacOS/PrismPackageTests"
PROFILE="$DEBUG_FOLDER/codecov/default.profdata"

xcrun llvm-cov \
  export -format="lcov" $TESTS \
  -instr-profile $PROFILE > info.lcov
