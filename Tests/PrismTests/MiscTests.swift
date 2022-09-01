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
  
  func testAttributeDescriptions() {
    let b1 = Bold("Foo")
    let b2 = Bold("Foo")
    XCTAssertEqual(b1.debugDescription, b2.debugDescription)
    XCTAssertEqual(b1.description, b2.description)
    
    let b3 = Bold("Bar")
    XCTAssertNotEqual(b2.debugDescription, b3.debugDescription)
    XCTAssertNotEqual(b2.description, b3.description)
    
    let i1 = Italic("Bar")
    XCTAssertNotEqual(b3.debugDescription, i1.debugDescription)
    XCTAssertEqual(b3.description, i1.description)
  }
  
  func testSpacerElementDescriptions() {
    let s1 = Spacer(type: .space)
    let s2 = Spacer(type: .tab)
    XCTAssertNotEqual(s1.description, s2.description)
    XCTAssertNotEqual(s1.debugDescription, s2.debugDescription)
    
    let l1 = LineBreak(type: .newline)
    let l2 = LineBreak(type: .return)
    XCTAssertNotEqual(l1.description, l2.description)
    XCTAssertNotEqual(l1.debugDescription, l2.debugDescription)
  }
}
