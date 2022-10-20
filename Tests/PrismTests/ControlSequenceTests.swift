//===----------------------------------------------------------------------===//
//
// ControlSequenceTests.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class ControlSequenceTests: XCTestCase {
  func testMapped() {
    XCTAssertEqual("\u{001B}[0m", ControlSequence.reset.reduced)
    XCTAssertEqual("\u{001B}[1m", ControlSequence.boldOn.reduced)
    XCTAssertEqual("\u{001B}[22m", ControlSequence.boldOff.reduced)
    XCTAssertEqual("\u{001B}[2m", ControlSequence.dimOn.reduced)
    XCTAssertEqual("\u{001B}[22m", ControlSequence.dimOff.reduced)
    XCTAssertEqual("\u{001B}[3m", ControlSequence.italicOn.reduced)
    XCTAssertEqual("\u{001B}[23m", ControlSequence.italicOff.reduced)
    XCTAssertEqual("\u{001B}[4m", ControlSequence.underlineOn.reduced)
    XCTAssertEqual("\u{001B}[24m", ControlSequence.underlineOff.reduced)
    XCTAssertEqual("\u{001B}[53m", ControlSequence.overlineOn.reduced)
    XCTAssertEqual("\u{001B}[55m", ControlSequence.overlineOff.reduced)
    XCTAssertEqual("\u{001B}[5m", ControlSequence.blinkOn.reduced)
    XCTAssertEqual("\u{001B}[25m", ControlSequence.blinkOff.reduced)
    XCTAssertEqual("\u{001B}[7m", ControlSequence.swapOn.reduced)
    XCTAssertEqual("\u{001B}[27m", ControlSequence.swapOff.reduced)
    XCTAssertEqual("\u{001B}[8m", ControlSequence.hideOn.reduced)
    XCTAssertEqual("\u{001B}[28m", ControlSequence.hideOff.reduced)
    XCTAssertEqual("\u{001B}[9m", ControlSequence.strikethroughOn.reduced)
    XCTAssertEqual("\u{001B}[29m", ControlSequence.strikethroughOff.reduced)
    XCTAssertEqual("\u{001B}[39m", ControlSequence.foregroundColor(.default).reduced)
    XCTAssertEqual("\u{001B}[49m", ControlSequence.backgroundColor(.default).reduced)
  }
  
  func testConstructors() {
    let s1 = ControlSequence(for: Bold("Bold"))
    XCTAssertEqual(s1.reduced, "\u{001B}[1mBold\u{001B}[22m")
  }
  
  func testEqual() {
    XCTAssertEqual(
      ControlSequence(for: Bold("Bold")),
      Bold("Bold").controlSequence)
    XCTAssertEqual(
      ControlSequence(for: Bold("Bold")).description,
      Bold("Bold").controlSequence.description)
    XCTAssertEqual(
      ControlSequence(for: Bold("Bold")).debugDescription,
      Bold("Bold").controlSequence.debugDescription)
    XCTAssertEqual(
      ControlSequence(for: Bold("Bold")).hashValue,
      Bold("Bold").controlSequence.hashValue)
  }
}
