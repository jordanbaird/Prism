//
// DestinationTests.swift
// Prism
//

import XCTest
@testable import Prism

final class DestinationTests: XCTestCase {
    func testCorrectDestination() {
        EnvironmentVariable("TERM").value = "xterm-256color"
        XCTAssert(Destination.current == .formattingCompatible)

        EnvironmentVariable("TERM").value = "dumb"
        XCTAssert(Destination.current == .formattingIncompatible)

        EnvironmentVariable("TERM").value = nil
        XCTAssert(Destination.current == .unknown)
    }
}
