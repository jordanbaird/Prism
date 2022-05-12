//===----------------------------------------------------------------------===//
//
// MiscTests.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class MiscTests: XCTestCase {
  func testRNGRandomness() {
    let a1 = Bold("Bold")
    let a2 = Bold("Bold")
    XCTAssertNotEqual(a1.id, a2.id)
  }
  
  func testStorageIntegrity() {
    let value = Storage(0).get("test", backup: "Hello")
    let storage = Storage.allStorage[0]
    XCTAssertNotNil(storage)
    let stored = storage!["test"] as? String
    XCTAssertNotNil(stored)
    XCTAssertEqual(value, stored)
  }
}
