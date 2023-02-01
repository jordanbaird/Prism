//===----------------------------------------------------------------------===//
//
// ColorTests.swift
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class ColorTests: XCTestCase {
    func testDefaultForegroundCodes() {
        XCTAssertEqual(Color.black(style: .default).foregroundCode, "30")
        XCTAssertEqual(Color.red(style: .default).foregroundCode, "31")
        XCTAssertEqual(Color.green(style: .default).foregroundCode, "32")
        XCTAssertEqual(Color.yellow(style: .default).foregroundCode, "33")
        XCTAssertEqual(Color.blue(style: .default).foregroundCode, "34")
        XCTAssertEqual(Color.magenta(style: .default).foregroundCode, "35")
        XCTAssertEqual(Color.cyan(style: .default).foregroundCode, "36")
        XCTAssertEqual(Color.white(style: .default).foregroundCode, "37")
        XCTAssertEqual(Color.default.foregroundCode, "39")
    }

    func testDefaultBackgroundCodes() {
        XCTAssertEqual(Color.black(style: .default).backgroundCode, "40")
        XCTAssertEqual(Color.red(style: .default).backgroundCode, "41")
        XCTAssertEqual(Color.green(style: .default).backgroundCode, "42")
        XCTAssertEqual(Color.yellow(style: .default).backgroundCode, "43")
        XCTAssertEqual(Color.blue(style: .default).backgroundCode, "44")
        XCTAssertEqual(Color.magenta(style: .default).backgroundCode, "45")
        XCTAssertEqual(Color.cyan(style: .default).backgroundCode, "46")
        XCTAssertEqual(Color.white(style: .default).backgroundCode, "47")
        XCTAssertEqual(Color.default.backgroundCode, "49")
    }

    func testBrightForegroundCodes() {
        XCTAssertEqual(Color.black(style: .bright).foregroundCode, "90")
        XCTAssertEqual(Color.red(style: .bright).foregroundCode, "91")
        XCTAssertEqual(Color.green(style: .bright).foregroundCode, "92")
        XCTAssertEqual(Color.yellow(style: .bright).foregroundCode, "93")
        XCTAssertEqual(Color.blue(style: .bright).foregroundCode, "94")
        XCTAssertEqual(Color.magenta(style: .bright).foregroundCode, "95")
        XCTAssertEqual(Color.cyan(style: .bright).foregroundCode, "96")
        XCTAssertEqual(Color.white(style: .bright).foregroundCode, "97")
    }

    func testBrightBackgroundCodes() {
        XCTAssertEqual(Color.black(style: .bright).backgroundCode, "100")
        XCTAssertEqual(Color.red(style: .bright).backgroundCode, "101")
        XCTAssertEqual(Color.green(style: .bright).backgroundCode, "102")
        XCTAssertEqual(Color.yellow(style: .bright).backgroundCode, "103")
        XCTAssertEqual(Color.blue(style: .bright).backgroundCode, "104")
        XCTAssertEqual(Color.magenta(style: .bright).backgroundCode, "105")
        XCTAssertEqual(Color.cyan(style: .bright).backgroundCode, "106")
        XCTAssertEqual(Color.white(style: .bright).backgroundCode, "107")
    }

    func testRGBCodes() {
        let foregroundCode = "38;2;134;51;220"
        let backgroundCode = "48;2;134;51;220"
        let color = Color(red: 0.526, green: 0.201, blue: 0.865)
        XCTAssertEqual(foregroundCode, color.foregroundCode)
        XCTAssertEqual(backgroundCode, color.backgroundCode)
    }

    func testEightBitCodes() {
        let foregroundCode = "38;5;238"
        let backgroundCode = "48;5;238"
        let color = Color(eightBit: .grayscale(0.3))
        XCTAssertEqual(foregroundCode, color.foregroundCode)
        XCTAssertEqual(backgroundCode, color.backgroundCode)
    }

    func testInitializationByString() {
        // These should be valid (invalid gets set to .default).
        let c1 = Color(string: "26AB2A")
        let c2 = Color(string: "rgb(30%,77%,14%)")
        let c3 = Color(string: "rgb(5 88 247)")
        let c4 = Color(string: "rgb(10, 35, 200)")
        XCTAssertNotEqual(c1, .default)
        XCTAssertNotEqual(c2, .default)
        XCTAssertNotEqual(c3, .default)
        XCTAssertNotEqual(c4, .default)

        // This should be invalid.
        let c5 = Color(string: "ZX0L8M")
        XCTAssertEqual(c5, Color(red: 0, green: 0, blue: 0))

        // This should be partially invalid.
        let c6 = Color(string: "2,0.1,45")
        XCTAssertEqual(c6, Color(red: 1, green: 0.1, blue: 1))
    }

    func testHashable() {
        XCTAssertEqual(Color.green.hashValue, Color.green.hashValue)
        XCTAssertNotEqual(Color.green.hashValue, Color.green(style: .bright).hashValue)
    }
}
