//===----------------------------------------------------------------------===//
//
// AttributeTests.swift
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class AttributeTests: XCTestCase {
    func testString() {
        EnvironmentVariable("TERM").value = "xterm-256color"
        let attribute = Bold("Bold", nestedElements: [Italic("Italic")])

        XCTAssertEqual(
            attribute.string(formatted: true),
            "\u{001B}[1mBold\u{001B}[3mItalic\u{001B}[23m\u{001B}[22m")
        XCTAssertEqual(
            attribute.string(formatted: false),
            "BoldItalic")
    }
}
