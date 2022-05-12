//===----------------------------------------------------------------------===//
//
// HexadecimalTests.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class HexadecimalTests: XCTestCase {
  func testValidate() {
    // These should be valid.
    let h1 = Hexadecimal(string: "E3463D")
    let h2 = Hexadecimal(string: "#8F7C26")
    let h3 = Hexadecimal(string: "##000000")
    let h4 = Hexadecimal(string: " #D3FC15")
    let h5 = Hexadecimal(string: "#\t #A2F FE 9")
    XCTAssertNoThrow(try h1.validate(), "Simple hex values should be valid.")
    XCTAssertNoThrow(try h2.validate(), "Pound signs should be valid symbols.")
    XCTAssertNoThrow(try h3.validate(), "Extra pound signs should be ignored.")
    XCTAssertNoThrow(try h4.validate(), "Whitespace should be ignored.")
    XCTAssertNoThrow(try h5.validate(), "All whitespace and pound signs should be ignored.")
    
    // These should be invalid.
    let h6 = Hexadecimal(string: "8PS1UU")
    let h7 = Hexadecimal(string: "$FF00FF")
    let h8 = Hexadecimal(string: "FF")
    XCTAssertThrowsError(try h6.validate(), "These characters should not validate.")
    XCTAssertThrowsError(try h7.validate(), "Dollar signs should be invalid characters.")
    XCTAssertThrowsError(try h8.validate(), "Values should be 6 characters.")
  }
}
