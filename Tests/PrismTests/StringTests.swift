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
    XCTAssertEqual(Overline("").string(), "".overline)
    XCTAssertEqual(Blink("").string(), "".blink)
    XCTAssertEqual(Swap("").string(), "".swap)
    XCTAssertEqual(Strikethrough("").string(), "".strikethrough)
    XCTAssertEqual(ForegroundColor(.blue, "").string(), "".foregroundColor(.blue))
    XCTAssertEqual(BackgroundColor(.blue, "").string(), "".backgroundColor(.blue))
  }
}
