//===----------------------------------------------------------------------===//
//
// ECMACodeTests.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class ECMACodeTests: XCTestCase {
  func testGrayscale() {
    let c0 = ECMA256Color.Grayscale(intensity: 0)
    let c1 = ECMA256Color.Grayscale(intensity: 1)
    XCTAssertEqual(c0.rawValue, 232)
    XCTAssertEqual(c1.rawValue, 255)
    
    let c2 = ECMA256Color(grayscale: .init(intensity: 0.732))
    let c3 = ECMA256Color.Grayscale(intensity: 0.732)
    let c4 = ECMA256Color.grayscale(.init(intensity: 0.732))
    XCTAssertEqual(c2.rawValue, c3.rawValue)
    XCTAssertEqual(c3.rawValue, c4.rawValue)
    
    XCTAssertEqual(
      ECMA256Color.Grayscale(intensity: -5),
      ECMA256Color.Grayscale(intensity: 0))
    
    XCTAssertEqual(
      ECMA256Color.Grayscale(intensity: 5),
      ECMA256Color.Grayscale(intensity: 1))
  }
  
  func testStandardColor() {
    XCTAssertEqual(ECMA256Color.StandardColor.black.rawValue, 0)
    XCTAssertEqual(ECMA256Color.StandardColor.red.rawValue, 1)
    XCTAssertEqual(ECMA256Color.StandardColor.green.rawValue, 2)
    XCTAssertEqual(ECMA256Color.StandardColor.yellow.rawValue, 3)
    XCTAssertEqual(ECMA256Color.StandardColor.blue.rawValue, 4)
    XCTAssertEqual(ECMA256Color.StandardColor.magenta.rawValue, 5)
    XCTAssertEqual(ECMA256Color.StandardColor.cyan.rawValue, 6)
    XCTAssertEqual(ECMA256Color.StandardColor.lightGray.rawValue, 7)
    XCTAssertEqual(ECMA256Color.StandardColor.darkGray.rawValue, 8)
    XCTAssertEqual(ECMA256Color.StandardColor.brightRed.rawValue, 9)
    XCTAssertEqual(ECMA256Color.StandardColor.brightGreen.rawValue, 10)
    XCTAssertEqual(ECMA256Color.StandardColor.brightYellow.rawValue, 11)
    XCTAssertEqual(ECMA256Color.StandardColor.brightBlue.rawValue, 12)
    XCTAssertEqual(ECMA256Color.StandardColor.brightMagenta.rawValue, 13)
    XCTAssertEqual(ECMA256Color.StandardColor.brightCyan.rawValue, 14)
    XCTAssertEqual(ECMA256Color.StandardColor.white.rawValue, 15)
    
    let c0 = ECMA256Color(standard: .brightCyan)
    let c1 = ECMA256Color.StandardColor.brightCyan
    let c2 = ECMA256Color.standardColor(.brightCyan)
    XCTAssertEqual(c0.rawValue, c1.rawValue)
    XCTAssertEqual(c1.rawValue, c2.rawValue)
  }
  
  func testNumericCode() {
    let c0 = ECMA256Color(numericCode: 0)
    let c1 = ECMA256Color.standardColor(.black)
    XCTAssertEqual(c0, c1)
  }
}
