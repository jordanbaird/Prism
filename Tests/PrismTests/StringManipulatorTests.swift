//===----------------------------------------------------------------------===//
//
// StringManipulatorTests.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class StringManipulatorTests: XCTestCase {
  func testRemoveOccurrences() {
    let string = "r:10,g:35,b:200"
    let correctString = string
      .replacingOccurrences(of: "r:", with: "")
      .replacingOccurrences(of: "g:", with: "")
      .replacingOccurrences(of: "b:", with: "")
    var manipulator = StringManipulator(string: string)
    manipulator.removeOccurrences(of: ["r:", "g:", "b:"])
    XCTAssertEqual(correctString, manipulator.finalize())
  }
  
  func testTrimWhitespace() {
    let string = "  Hello, world!\t"
    let correctString = string.trimmingCharacters(in: .whitespaces)
    var manipulator = StringManipulator(string: string)
    manipulator.trimWhitespace()
    XCTAssertEqual(correctString, manipulator.finalize())
  }
}
