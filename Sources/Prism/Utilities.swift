//===----------------------------------------------------------------------===//
//
// Utilities.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A result builder type that builds either a single prism element, or an
/// array of prism elements.
@resultBuilder
public struct ElementBuilder {
  public static func buildBlock(_ components: PrismElement...) -> [PrismElement] { components }
  public static func buildBlock(_ components: PrismElement) -> [PrismElement] { [components] }
  public static func buildBlock(_ component: PrismElement) -> PrismElement { component }
  public static func buildArray(_ components: [PrismElement]) -> [PrismElement] { components }
  public static func buildExpression(_ expression: PrismElement) -> PrismElement { expression }
  public static func buildEither(first component: PrismElement) -> PrismElement { component }
  public static func buildEither(second component: PrismElement) -> PrismElement { component }
}

struct StringManipulator {
  private var string: String
  
  init(string: String) {
    self.string = string
  }
  
  mutating func removeOccurrences(of occurrences: [String]) {
    for occurrence in occurrences {
      var buffer = ""
      for char in string {
        buffer.append(char)
        if buffer.hasSuffix(occurrence) {
          buffer.removeLast(occurrence.count)
        }
      }
      string = buffer
    }
  }
  
  mutating func trimWhitespace() {
    while string.hasPrefix(" ") || string.hasPrefix("\t") {
      string.removeFirst()
    }
    while string.hasSuffix(" ") || string.hasSuffix("\t") {
      string.removeLast()
    }
  }
  
  mutating func trimNewlines() {
    while string.hasPrefix("\n") || string.hasPrefix("\r") {
      string.removeFirst()
    }
    while string.hasSuffix("\n") || string.hasPrefix("\r") {
      string.removeLast()
    }
  }
  
  mutating func finalize() -> String {
    let s = string
    self.string = ""
    return s
  }
}
