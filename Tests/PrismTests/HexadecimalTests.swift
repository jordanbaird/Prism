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
    let h1 = Hexadecimal(string: "E3463D") // Simple hex values should be valid.
    let h2 = Hexadecimal(string: "#8F7C26") // Pound signs should be accepted.
    let h3 = Hexadecimal(string: "##000000") // Additional pound signs should be ignored.
    let h4 = Hexadecimal(string: " #D3FC15\t") // Leading and trailing whitespace should be ignored.
    let h5 = Hexadecimal(string: "#\t #A2F FE 9") // Internal whitespace should be ignored.
    XCTAssertNoThrow(try h1.validate())
    XCTAssertNoThrow(try h2.validate())
    XCTAssertNoThrow(try h3.validate())
    XCTAssertNoThrow(try h4.validate())
    XCTAssertNoThrow(try h5.validate())
    
    // These should be invalid.
    let h6 = Hexadecimal(string: "8PS1UU") // Valid characters are [a-fA-F0-9].
    let h7 = Hexadecimal(string: "$FF00FF") // Dollar signs are not allowed.
    let h8 = Hexadecimal(string: "FF") // Must be 6 characters.
    XCTAssertThrowsError(try h6.validate())
    XCTAssertThrowsError(try h7.validate())
    XCTAssertThrowsError(try h8.validate())
  }
}
