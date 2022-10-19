//===----------------------------------------------------------------------===//
//
// ElementBuilder.swift
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
