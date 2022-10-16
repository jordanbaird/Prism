//===----------------------------------------------------------------------===//
//
// EnvironmentVariableTests.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class EnvironmentVariableTests: XCTestCase {
  override func setUp() {
    EnvironmentVariable("TEST_VAR").value = nil
  }
  
  func testSetAndUnset() {
    let envVar = EnvironmentVariable("TEST_VAR")
    XCTAssertNil(envVar.value)
    envVar.value = "Foo"
    XCTAssertNotNil(envVar.value)
    envVar.value = nil
    XCTAssertNil(envVar.value)
  }
  
  func testEquatable() {
    let envVar1 = EnvironmentVariable("TEST_VAR1")
    let envVar2 = EnvironmentVariable("TEST_VAR1")
    let envVar3 = EnvironmentVariable("TEST_VAR2")
    XCTAssertEqual(envVar1, envVar2)
    XCTAssertNotEqual(envVar1, envVar3)
    envVar1.value = "Bar"
    envVar3.value = "Bar"
    XCTAssertEqual(envVar1, envVar2)
    XCTAssertNotEqual(envVar1, envVar3)
  }
  
  func testHashValue() {
    let envVar = EnvironmentVariable("TEST_VAR")
    let h1 = envVar.hashValue
    envVar.value = "Baz"
    let h2 = envVar.hashValue
    XCTAssertNotEqual(h1, h2)
  }
}
