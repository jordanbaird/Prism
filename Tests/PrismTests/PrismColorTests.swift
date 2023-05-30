//
// PrismColorTests.swift
// Prism
//

import XCTest
@testable import Prism

final class PrismColorTests: XCTestCase {
    func testDefaultForegroundCodes() {
        XCTAssertEqual(PrismColor.black(style: .default).foregroundCode, "30")
        XCTAssertEqual(PrismColor.red(style: .default).foregroundCode, "31")
        XCTAssertEqual(PrismColor.green(style: .default).foregroundCode, "32")
        XCTAssertEqual(PrismColor.yellow(style: .default).foregroundCode, "33")
        XCTAssertEqual(PrismColor.blue(style: .default).foregroundCode, "34")
        XCTAssertEqual(PrismColor.magenta(style: .default).foregroundCode, "35")
        XCTAssertEqual(PrismColor.cyan(style: .default).foregroundCode, "36")
        XCTAssertEqual(PrismColor.white(style: .default).foregroundCode, "37")
        XCTAssertEqual(PrismColor.default.foregroundCode, "39")
    }

    func testDefaultBackgroundCodes() {
        XCTAssertEqual(PrismColor.black(style: .default).backgroundCode, "40")
        XCTAssertEqual(PrismColor.red(style: .default).backgroundCode, "41")
        XCTAssertEqual(PrismColor.green(style: .default).backgroundCode, "42")
        XCTAssertEqual(PrismColor.yellow(style: .default).backgroundCode, "43")
        XCTAssertEqual(PrismColor.blue(style: .default).backgroundCode, "44")
        XCTAssertEqual(PrismColor.magenta(style: .default).backgroundCode, "45")
        XCTAssertEqual(PrismColor.cyan(style: .default).backgroundCode, "46")
        XCTAssertEqual(PrismColor.white(style: .default).backgroundCode, "47")
        XCTAssertEqual(PrismColor.default.backgroundCode, "49")
    }

    func testBrightForegroundCodes() {
        XCTAssertEqual(PrismColor.black(style: .bright).foregroundCode, "90")
        XCTAssertEqual(PrismColor.red(style: .bright).foregroundCode, "91")
        XCTAssertEqual(PrismColor.green(style: .bright).foregroundCode, "92")
        XCTAssertEqual(PrismColor.yellow(style: .bright).foregroundCode, "93")
        XCTAssertEqual(PrismColor.blue(style: .bright).foregroundCode, "94")
        XCTAssertEqual(PrismColor.magenta(style: .bright).foregroundCode, "95")
        XCTAssertEqual(PrismColor.cyan(style: .bright).foregroundCode, "96")
        XCTAssertEqual(PrismColor.white(style: .bright).foregroundCode, "97")
    }

    func testBrightBackgroundCodes() {
        XCTAssertEqual(PrismColor.black(style: .bright).backgroundCode, "100")
        XCTAssertEqual(PrismColor.red(style: .bright).backgroundCode, "101")
        XCTAssertEqual(PrismColor.green(style: .bright).backgroundCode, "102")
        XCTAssertEqual(PrismColor.yellow(style: .bright).backgroundCode, "103")
        XCTAssertEqual(PrismColor.blue(style: .bright).backgroundCode, "104")
        XCTAssertEqual(PrismColor.magenta(style: .bright).backgroundCode, "105")
        XCTAssertEqual(PrismColor.cyan(style: .bright).backgroundCode, "106")
        XCTAssertEqual(PrismColor.white(style: .bright).backgroundCode, "107")
    }

    func testRGBCodes() {
        let foregroundCode = "38;2;134;51;220"
        let backgroundCode = "48;2;134;51;220"
        let color = PrismColor(red: 0.526, green: 0.201, blue: 0.865)
        XCTAssertEqual(foregroundCode, color.foregroundCode)
        XCTAssertEqual(backgroundCode, color.backgroundCode)
    }

    func testEightBitCodes() {
        let foregroundCode = "38;5;238"
        let backgroundCode = "48;5;238"
        let color = PrismColor(eightBit: .grayscale(0.3))
        XCTAssertEqual(foregroundCode, color.foregroundCode)
        XCTAssertEqual(backgroundCode, color.backgroundCode)
    }

    func testInitializationByString() {
        // These should be valid (invalid gets set to .default).
        let c1 = PrismColor(string: "26AB2A")
        let c2 = PrismColor(string: "rgb(30%,77%,14%)")
        let c3 = PrismColor(string: "rgb(5 88 247)")
        let c4 = PrismColor(string: "rgb(10, 35, 200)")
        XCTAssertNotEqual(c1, .default)
        XCTAssertNotEqual(c2, .default)
        XCTAssertNotEqual(c3, .default)
        XCTAssertNotEqual(c4, .default)

        // This should be invalid.
        let c5 = PrismColor(string: "ZX0L8M")
        XCTAssertEqual(c5, PrismColor(red: 0, green: 0, blue: 0))

        // This should be partially invalid.
        let c6 = PrismColor(string: "2,0.1,45")
        XCTAssertEqual(c6, PrismColor(red: 1, green: 0.1, blue: 1))
    }

    func testHashable() {
        XCTAssertEqual(PrismColor.green.hashValue, PrismColor.green.hashValue)
        XCTAssertNotEqual(PrismColor.green.hashValue, PrismColor.green(style: .bright).hashValue)
    }
}
