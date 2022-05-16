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
    let c0 = ECMA256.Grayscale(intensity: 0)
    let c1 = ECMA256.Grayscale(intensity: 1)
    XCTAssertEqual(c0.numericCode, 232)
    XCTAssertEqual(c1.numericCode, 255)
    
    let c2 = ECMA256(grayscale: .init(intensity: 0.732))
    let c3 = ECMA256.Grayscale(intensity: 0.732)
    let c4 = ECMA256.grayscale(.init(intensity: 0.732))
    XCTAssertEqual(c2.numericCode, c3.numericCode)
    XCTAssertEqual(c3.numericCode, c4.numericCode)
    
    XCTAssertEqual(
      ECMA256.Grayscale(intensity: -5),
      ECMA256.Grayscale(intensity: 0))
    
    XCTAssertEqual(
      ECMA256.Grayscale(intensity: 5),
      ECMA256.Grayscale(intensity: 1))
  }
  
  func testStandardColor() {
    XCTAssertEqual(ECMA256.StandardColor.black.numericCode, 0)
    XCTAssertEqual(ECMA256.StandardColor.red.numericCode, 1)
    XCTAssertEqual(ECMA256.StandardColor.green.numericCode, 2)
    XCTAssertEqual(ECMA256.StandardColor.yellow.numericCode, 3)
    XCTAssertEqual(ECMA256.StandardColor.blue.numericCode, 4)
    XCTAssertEqual(ECMA256.StandardColor.magenta.numericCode, 5)
    XCTAssertEqual(ECMA256.StandardColor.cyan.numericCode, 6)
    XCTAssertEqual(ECMA256.StandardColor.lightGray.numericCode, 7)
    XCTAssertEqual(ECMA256.StandardColor.darkGray.numericCode, 8)
    XCTAssertEqual(ECMA256.StandardColor.brightRed.numericCode, 9)
    XCTAssertEqual(ECMA256.StandardColor.brightGreen.numericCode, 10)
    XCTAssertEqual(ECMA256.StandardColor.brightYellow.numericCode, 11)
    XCTAssertEqual(ECMA256.StandardColor.brightBlue.numericCode, 12)
    XCTAssertEqual(ECMA256.StandardColor.brightMagenta.numericCode, 13)
    XCTAssertEqual(ECMA256.StandardColor.brightCyan.numericCode, 14)
    XCTAssertEqual(ECMA256.StandardColor.white.numericCode, 15)
    
    let c0 = ECMA256(standard: .brightCyan)
    let c1 = ECMA256.StandardColor.brightCyan
    let c2 = ECMA256.standardColor(.brightCyan)
    XCTAssertEqual(c0.numericCode, c1.numericCode)
    XCTAssertEqual(c1.numericCode, c2.numericCode)
  }
  
  func testNumericCode() {
    let c0 = ECMA256(numericCode: 0)
    let c1 = ECMA256.standardColor(.black)
    XCTAssertEqual(c0, c1)
  }
}
