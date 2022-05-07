//===----------------------------------------------------------------------===//
//
// StringTests.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class StringTests: XCTestCase {
  func testAttributeToStringConversion() {
    XCTAssertEqual(Bold("").string(), "".bold)
    XCTAssertEqual(Dim("").string(), "".dim)
    XCTAssertEqual(Italic("").string(), "".italic)
    XCTAssertEqual(Underline("").string(), "".underline)
    XCTAssertEqual(Blink("").string(), "".blink)
    XCTAssertEqual(Swap("").string(), "".swap)
    XCTAssertEqual(Strikethrough("").string(), "".strikethrough)
  }
}
