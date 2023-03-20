//
// ECMACodeTests.swift
// Prism
//

import XCTest
@testable import Prism

final class ECMACodeTests: XCTestCase {
    func testGrayscale() {
        let c0 = EightBit.Grayscale(intensity: 0)
        let c1 = EightBit.Grayscale(intensity: 1)
        XCTAssertEqual(c0.numericCode, 232)
        XCTAssertEqual(c1.numericCode, 255)

        let c2 = EightBit(grayscale: .init(intensity: 0.732))
        let c3 = EightBit.Grayscale(intensity: 0.732)
        let c4 = EightBit.grayscale(.init(intensity: 0.732))
        XCTAssertEqual(c2.numericCode, c3.numericCode)
        XCTAssertEqual(c3.numericCode, c4.numericCode)

        XCTAssertEqual(
            EightBit.Grayscale(intensity: -5),
            EightBit.Grayscale(intensity: 0)
        )

        XCTAssertEqual(
            EightBit.Grayscale(intensity: 5),
            EightBit.Grayscale(intensity: 1)
        )
    }

    func testStandardColor() {
        XCTAssertEqual(EightBit.StandardColor.black.numericCode, 0)
        XCTAssertEqual(EightBit.StandardColor.red.numericCode, 1)
        XCTAssertEqual(EightBit.StandardColor.green.numericCode, 2)
        XCTAssertEqual(EightBit.StandardColor.yellow.numericCode, 3)
        XCTAssertEqual(EightBit.StandardColor.blue.numericCode, 4)
        XCTAssertEqual(EightBit.StandardColor.magenta.numericCode, 5)
        XCTAssertEqual(EightBit.StandardColor.cyan.numericCode, 6)
        XCTAssertEqual(EightBit.StandardColor.lightGray.numericCode, 7)
        XCTAssertEqual(EightBit.StandardColor.darkGray.numericCode, 8)
        XCTAssertEqual(EightBit.StandardColor.brightRed.numericCode, 9)
        XCTAssertEqual(EightBit.StandardColor.brightGreen.numericCode, 10)
        XCTAssertEqual(EightBit.StandardColor.brightYellow.numericCode, 11)
        XCTAssertEqual(EightBit.StandardColor.brightBlue.numericCode, 12)
        XCTAssertEqual(EightBit.StandardColor.brightMagenta.numericCode, 13)
        XCTAssertEqual(EightBit.StandardColor.brightCyan.numericCode, 14)
        XCTAssertEqual(EightBit.StandardColor.white.numericCode, 15)

        let c0 = EightBit(standard: .brightCyan)
        let c1 = EightBit.StandardColor.brightCyan
        let c2 = EightBit.standardColor(.brightCyan)
        XCTAssertEqual(c0.numericCode, c1.numericCode)
        XCTAssertEqual(c1.numericCode, c2.numericCode)
    }

    func testNumericCode() {
        let c0 = EightBit(numericCode: 0)
        let c1 = EightBit.standardColor(.black)
        XCTAssertEqual(c0, c1)
    }
}
