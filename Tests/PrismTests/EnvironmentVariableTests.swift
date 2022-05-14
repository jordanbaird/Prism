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
    EnvironmentVariable("TEST_VAR").unset()
  }
  
  func testSetAndUnset() {
    let envVar = EnvironmentVariable("TEST_VAR")
    XCTAssertNil(envVar.get())
    envVar.set("Foo")
    XCTAssertNotNil(envVar.get())
    envVar.unset()
    XCTAssertNil(envVar.get())
  }
  
  func testEquatable() {
    let envVar1 = EnvironmentVariable("TEST_VAR1")
    let envVar2 = EnvironmentVariable("TEST_VAR1")
    let envVar3 = EnvironmentVariable("TEST_VAR2")
    XCTAssertEqual(envVar1, envVar2)
    XCTAssertNotEqual(envVar1, envVar3)
    envVar1.set("Bar")
    envVar3.set("Bar")
    XCTAssertEqual(envVar1, envVar2)
    XCTAssertNotEqual(envVar1, envVar3)
  }
  
  func testHashValue() {
    let envVar = EnvironmentVariable("TEST_VAR")
    let h1 = envVar.hashValue
    envVar.set("Baz")
    let h2 = envVar.hashValue
    XCTAssertNotEqual(h1, h2)
  }
}
