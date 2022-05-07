//===----------------------------------------------------------------------===//
//
// ColorTests.swift
//
// Created: 2022. Author: Jordan Baird.
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
    let fgCode = "38;2;134;51;220"
    let bgCode = "48;2;134;51;220"
    let color = Color(red: 0.526, green: 0.201, blue: 0.865)
    XCTAssertEqual(fgCode, color.foregroundCode)
    XCTAssertEqual(bgCode, color.backgroundCode)
  }
}
