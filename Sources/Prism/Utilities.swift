//===----------------------------------------------------------------------===//
//
// Utilities.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

@resultBuilder
public enum ElementBuilder {
  
  // MARK: - Block Builders
  
  public static func buildBlock(_ components: PrismElement...) -> [PrismElement] {
    components
  }
  
  @_disfavoredOverload
  public static func buildBlock(_ components: [PrismElement]...) -> [PrismElement] {
    components.flatMap { $0 }
  }
  
  // MARK: - Expression Builders
  
  public static func buildExpression(_ expression: PrismElement) -> PrismElement {
    expression
  }
  
  public static func buildExpression(_ expression: PrismElementConvertible) -> PrismElement {
    expression.prismElement
  }
  
  @_disfavoredOverload
  public static func buildExpression(_ expression: [PrismElement]) -> [PrismElement] {
    expression
  }
  
  @_disfavoredOverload
  public static func buildExpression(_ expression: [PrismElementConvertible]) -> [PrismElement] {
    expression.map { $0.prismElement }
  }
  
  // MARK: - Conditional Builders
  
  public static func buildEither(first components: PrismElement...) -> [PrismElement] {
    components
  }
  
  public static func buildEither(second components: PrismElement...) -> [PrismElement] {
    components
  }
  
  @_disfavoredOverload
  public static func buildEither(first components: [PrismElement]...) -> [PrismElement] {
    components.flatMap { $0 }
  }
  
  @_disfavoredOverload
  public static func buildEither(second components: [PrismElement]...) -> [PrismElement] {
    components.flatMap { $0 }
  }
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
