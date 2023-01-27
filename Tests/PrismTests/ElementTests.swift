//===----------------------------------------------------------------------===//
//
// ElementTests.swift
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class ElementTests: XCTestCase {
    func testSpacer() {
        let p = Prism(spacing: .custom) {
            Spacer(type: .space)
            Spacer(type: .tab)
        }
        XCTAssertEqual(p.testableDescription, " \t")
    }

    func testLineBreak() {
        let p = Prism(spacing: .custom) {
            LineBreak(type: .newline)
            LineBreak(type: .return)
        }
        XCTAssertEqual(p.testableDescription, "\n\r")
    }

    func testReset() {
        let p = Prism(spacing: .custom) {
            Reset()
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[0m")
    }

    func testBold() {
        let p = Prism(spacing: .custom) {
            Bold("Bold")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[1mBold\u{001B}[22m")
    }

    func testDim() {
        let p = Prism(spacing: .custom) {
            Dim("Dim")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[2mDim\u{001B}[22m")
    }

    func testItalic() {
        let p = Prism(spacing: .custom) {
            Italic("Italic")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[3mItalic\u{001B}[23m")
    }

    func testUnderline() {
        let p = Prism(spacing: .custom) {
            Underline("Underline")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[4mUnderline\u{001B}[24m")
    }

    func testOverline() {
        let p = Prism(spacing: .custom) {
            Overline("Overline")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[53mOverline\u{001B}[55m")
    }

    func testBlink() {
        let p = Prism(spacing: .custom) {
            Blink("Blink")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[5mBlink\u{001B}[25m")
    }

    func testSwap() {
        let p = Prism(spacing: .custom) {
            Swap("Swap")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[7mSwap\u{001B}[27m")
    }

    func testHide() {
        let p = Prism(spacing: .custom) {
            Hide("Hide")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[8mHide\u{001B}[28m")
    }

    func testStrikethrough() {
        let p = Prism(spacing: .custom) {
            Strikethrough("Strikethrough")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[9mStrikethrough\u{001B}[29m")
    }

    func testForegroundColor() {
        let p = Prism(spacing: .custom) {
            ForegroundColor(.blue, "ForegroundColor")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[34mForegroundColor\u{001B}[39m")
    }

    func testBackgroundColor() {
        let p = Prism(spacing: .custom) {
            BackgroundColor(.blue, "BackgroundColor")
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[44mBackgroundColor\u{001B}[49m")
    }

    func testIgnoreFormatting() {
        let p = Prism(spacing: .custom) {
            Bold {
                "Bold"
                IgnoreFormatting("Not bold")
            }
        }
        XCTAssertEqual(
            p.testableDescription,
            "\u{001B}[1mBold\u{001B}[22mNot bold\u{001B}[1m\u{001B}[22m")
    }
}
