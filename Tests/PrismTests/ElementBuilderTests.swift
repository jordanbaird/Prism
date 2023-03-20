//
// ElementBuilderTests.swift
// Prism
//

import XCTest
@testable import Prism

final class ElementBuilderTests: XCTestCase {
    func testBuildBlockFromIndividualElements() {
        @ElementBuilder var elements1: [PrismElement] {
            Standard("Hello")
            Standard("world")
        }

        @ElementBuilder var elements2: [PrismElement] {
            "Hello"
            "world"
        }

        XCTAssert(elements1._isEqual([Standard("Hello"), Standard("world")]))
        XCTAssert(elements1._isEqual(elements2))
    }

    func testBuildBlockFromArrays() {
        @ElementBuilder var elements1: [PrismElement] {
            [Standard("Hello"), Bold("World")]
        }
    }
}
