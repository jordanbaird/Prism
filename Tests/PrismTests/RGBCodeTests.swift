//
// RGBCodeTests.swift
// Prism
//

import XCTest
@testable import Prism

final class RGBCodeTests: XCTestCase {
    func testHashable() {
        let code1 = RGBCode(red: 0, green: 0.328, blue: 0.977)
        let code2 = RGBCode(red: 0, green: 0.328, blue: 0.977)
        XCTAssertEqual(code1.hashValue, code2.hashValue)
    }

    func testInitialization() {
        let code1 = RGBCode(red: 0, green: 0, blue: 0)
        let code2 = RGBCode(red: 0.0, green: 0.0, blue: 0.0)
        XCTAssertEqual(code1, code2)

        let code3 = RGBCode(red: 1, green: 1, blue: 1)
        let code4 = RGBCode(red: 1.0, green: 1.0, blue: 1.0)
        XCTAssertNotEqual(code3, code4)

        let code5 = RGBCode(red: 255, green: 255, blue: 255)
        let code6 = RGBCode(red: 1.0, green: 1.0, blue: 1.0)
        XCTAssertEqual(code5, code6)

        let code7 = RGBCode(string: "rgb(255 255 255)")
        let code8 = RGBCode(string: "rgb(100% 100% 100%)")
        XCTAssertNotNil(code7)
        XCTAssertNotNil(code8)

        XCTAssertEqual(code7, code8)
        XCTAssertEqual(code5, code7)

        XCTAssertNotEqual(code3, code7)
    }

    func testStringInitialization() {
        let code1 = RGBCode(string: "rgb(50% 50% 50%)")
        let code2 = RGBCode(red: 0.5, green: 0.5, blue: 0.5)
        XCTAssertEqual(code1, code2)

        let code3 = RGBCode(string: ".5 .5 .5")
        let code4 = RGBCode(red: 0.5, green: 0.5, blue: 0.5)
        XCTAssertEqual(code3, code4)

        let code5 = RGBCode(string: "rgb(51 51 51)")
        let code6 = RGBCode(string: "rgb(20% 20% 20%)")
        XCTAssertEqual(code5, code6)
    }
}
