//===----------------------------------------------------------------------===//
//
// DestinationTests.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class DestinationTests: XCTestCase {
  func testCorrectDestination() {
    setenv("TERM", "xterm-256color", 1)
    XCTAssert(Destination.current == .formattingCompatible)
    
    setenv("TERM", "dumb", 1)
    XCTAssert(Destination.current == .formattingIncompatible)
    
    unsetenv("TERM")
    XCTAssert(Destination.current == .unknown)
  }
}
