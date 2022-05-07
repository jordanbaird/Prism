//===----------------------------------------------------------------------===//
//
// AttributeTests.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class AttributeTests: XCTestCase {
  func testDescriptions() {
    XCTAssertEqual(Bold("Bold").description, Bold("Bold").string())
    
    let correctDebugDescription = """
      Bold(controlSequence: ControlSequence(\
      Component(nestedComponents: Component(rawValue: "ESC"), Component(rawValue: "[")), \
      Component(rawValue: "1"), \
      Component(rawValue: "m"), \
      Component(rawValue: "Bold"), \
      Component(nestedComponents: Component(rawValue: "ESC"), Component(rawValue: "[")), \
      Component(rawValue: "22"), \
      Component(rawValue: "m")))
      """
    XCTAssertEqual(Bold("Bold").debugDescription, correctDebugDescription)
  }
}
