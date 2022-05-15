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
    XCTAssertEqual("\u{001B}[0m", ControlSequence.reset.mapped)
    XCTAssertEqual("\u{001B}[1m", ControlSequence.boldOn.mapped)
    XCTAssertEqual("\u{001B}[22m", ControlSequence.boldOff.mapped)
    XCTAssertEqual("\u{001B}[2m", ControlSequence.dimOn.mapped)
    XCTAssertEqual("\u{001B}[22m", ControlSequence.dimOff.mapped)
    XCTAssertEqual("\u{001B}[3m", ControlSequence.italicOn.mapped)
    XCTAssertEqual("\u{001B}[23m", ControlSequence.italicOff.mapped)
    XCTAssertEqual("\u{001B}[4m", ControlSequence.underlineOn.mapped)
    XCTAssertEqual("\u{001B}[24m", ControlSequence.underlineOff.mapped)
    XCTAssertEqual("\u{001B}[53m", ControlSequence.overlineOn.mapped)
    XCTAssertEqual("\u{001B}[55m", ControlSequence.overlineOff.mapped)
    XCTAssertEqual("\u{001B}[5m", ControlSequence.blinkOn.mapped)
    XCTAssertEqual("\u{001B}[25m", ControlSequence.blinkOff.mapped)
    XCTAssertEqual("\u{001B}[7m", ControlSequence.swapOn.mapped)
    XCTAssertEqual("\u{001B}[27m", ControlSequence.swapOff.mapped)
    XCTAssertEqual("\u{001B}[8m", ControlSequence.hideOn.mapped)
    XCTAssertEqual("\u{001B}[28m", ControlSequence.hideOff.mapped)
    XCTAssertEqual("\u{001B}[9m", ControlSequence.strikethroughOn.mapped)
    XCTAssertEqual("\u{001B}[29m", ControlSequence.strikethroughOff.mapped)
    XCTAssertEqual("\u{001B}[39m", ControlSequence.foregroundColor(.default).mapped)
    XCTAssertEqual("\u{001B}[49m", ControlSequence.backgroundColor(.default).mapped)
  }
  
  func testConstructors() {
    let s1 = ControlSequence(for: Bold("Bold"))
    XCTAssertEqual(s1.mapped, "\u{001B}[1mBold\u{001B}[22m")
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
