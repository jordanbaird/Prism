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
    EnvironmentVariable("TERM").set("xterm-256color")
    XCTAssert(Destination.current == .formattingCompatible)
    
    EnvironmentVariable("TERM").set("dumb")
    XCTAssert(Destination.current == .formattingIncompatible)
    
    EnvironmentVariable("TERM").unset()
    XCTAssert(Destination.current == .unknown)
  }
}
