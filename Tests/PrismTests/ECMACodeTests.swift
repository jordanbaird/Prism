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
    let c1 = ECMACode.Grayscale(intensity: 0)
    let c2 = ECMACode.Grayscale(intensity: 1)
    XCTAssertEqual(c1.rawValue, 232)
    XCTAssertEqual(c2.rawValue, 255)
  }
}
