//===----------------------------------------------------------------------===//
//
// PrismTests.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

import XCTest
@testable import Prism

final class PrismTests: XCTestCase {
  func testStringConversion() {
    let correctString = """
      \\u{001B}[1mBold\\u{001B}[22m \
      \\u{001B}[2mDim\\u{001B}[22m \
      \\u{001B}[3mItalic\\u{001B}[23m \
      \\u{001B}[4mUnderline\\u{001B}[24m \
      \\u{001B}[53mOverline\\u{001B}[55m \
      \\u{001B}[5mBlink\\u{001B}[25m \
      \\u{001B}[7mSwap\\u{001B}[27m \
      \\u{001B}[8mHide\\u{001B}[28m \
      \\u{001B}[9mStrikethrough\\u{001B}[29m
      """
    let prism = Prism {
      Bold("Bold")
      Dim("Dim")
      Italic("Italic")
      Underline("Underline")
      Overline("Overline")
      Blink("Blink")
      Swap("Swap")
      Hide("Hide")
      Strikethrough("Strikethrough")
    }
    XCTAssertEqual(prism.escapedDescription, correctString)
  }
  
  func testSpacing() {
    let customSpacing = Prism(spacing: .custom) {
      ForegroundColor(.green(style: .default)) {
        Bold("Bold")
        Spacer()
        Dim("Dim")
      }
      Spacer()
      BackgroundColor(.yellow(style: .default)) {
        Italic("Italic")
        Spacer()
        Underline("Underline")
      }
      Spacer()
      ForegroundColor(.init(red: 0, green: 0.5, blue: 1)) {
        Blink("Blink")
        Spacer()
        Swap("Swap")
      }
      Spacer()
      BackgroundColor(.red(style: .default)) {
        Strikethrough("Strikethrough")
      }
    }
    let managedSpacing = Prism(spacing: .spaces) {
      ForegroundColor(.green(style: .default)) {
        Bold("Bold")
        Dim("Dim")
      }
      BackgroundColor(.yellow(style: .default)) {
        Italic("Italic")
        Underline("Underline")
      }
      ForegroundColor(.init(red: 0, green: 0.5, blue: 1)) {
        Blink("Blink")
        Swap("Swap")
      }
      BackgroundColor(.red(style: .default)) {
        Strikethrough("Strikethrough")
      }
    }
    XCTAssertEqual(customSpacing, managedSpacing)
    XCTAssertEqual(customSpacing.description, managedSpacing.description)
    XCTAssertEqual(customSpacing.debugDescription, managedSpacing.debugDescription)
    XCTAssertEqual(customSpacing.escapedDescription, managedSpacing.escapedDescription)
  }
  
  func testNonStandardInitialization() {
    let prism1 = Prism(spacing: .newlines, elements: Bold("Bold"), Blink("Blink"))
    let prism2 = Prism(spacing: .newlines) {
      Bold("Bold")
      Blink("Blink")
    }
    XCTAssertEqual(prism1, prism2)
  }
  
  func testConcatenate() {
    let prismStandard = Prism {
      Bold("Bold")
      Italic("Italic")
      Underline("Underline")
      Dim("Dim")
    }
    let prismConcat = Bold("Bold") + Italic("Italic") + (Underline("Underline") + Prism(Dim("Dim")))
    XCTAssertEqual(prismStandard, prismConcat)
  }
  
  func testPlusEquals() {
    let prismStandard = Prism {
      Bold("Bold")
      Italic("Italic")
      Underline("Underline")
      Dim("Dim")
      Overline("Overline")
    }
    
    var prismConcat = Prism(Bold("Bold"))
    prismConcat += Italic("Italic")
    prismConcat += [Underline("Underline"), Dim("Dim")]
    prismConcat += Prism(Overline("Overline"))
    
    XCTAssertEqual(prismStandard, prismConcat)
  }
  
  func testString() {
    let p1 = Prism {
      Bold("Bold")
      Italic("Italic")
      Underline("Underline")
      Dim("Dim")
    }
    let p2 = Prism(spacing: .custom) {
      Bold("Bold")
      Spacer()
      Italic("Italic")
      Spacer()
      Underline("Underline")
      Spacer()
      Dim("Dim")
    }
    XCTAssertEqual(p1.string(), p2.string())
  }
  
  func testElementEquality() {
    let e1: [PrismElement] = [
      Bold("Bold"),
      Spacer(),
      Italic("Italic"),
      Spacer(),
      Underline("Underline"),
      Spacer(),
      Dim("Dim"),
    ]
    let p1 = Prism(spacing: .spaces) {
      Bold("Bold")
      Italic("Italic")
      Underline("Underline")
      Dim("Dim")
    }
    XCTAssert(e1._isEqual(p1.elements))
  }
  
  func testElementHashValue() {
    let p1 = Prism {
      Bold("Bold")
      Italic("Italic")
      Underline("Underline")
      Dim("Dim")
    }
    let p2 = Prism(spacing: .custom) {
      Bold("Bold")
      Spacer()
      Italic("Italic")
      Spacer()
      Underline("Underline")
      Spacer()
      Dim("Dim")
    }
    XCTAssertEqual(p1.hashValue, p2.hashValue)
  }
}
