//===----------------------------------------------------------------------===//
//
// SpacerElement.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

protocol SpacerElement: PrismElement {
  /// The type of the spacer associated with the element.
  associatedtype SpacerType: SpacerElementType
  /// The spacer type associated with the element.
  var type: SpacerType { get }
  /// Creates a new element of the given type.
  init(type: SpacerType)
}

extension SpacerElement {
  public var debugDescription: String { "\(Self.self)(type: \(type))" }
  public var id: UInt64 { .init(debugDescription.hashValue.magnitude) }
  public var rawValue: String { type.rawValue }
}

protocol SpacerElementType {
  var rawValue: String { get }
}

extension Spacer {
  /// The possible values that a spacer element can contain.
  public enum SpacerType: String, SpacerElementType {
    /// A space `(" ")` element.
    case space = " "
    /// A tab `("\t")` element.
    case tab = "\t"
  }
}

extension LineBreak {
  /// The possible values that a line break element can contain.
  public enum LineBreakType: String, SpacerElementType {
    /// A newline `("\n")` element.
    case newline = "\n"
    /// A return `("\r")` element.
    case `return` = "\r"
  }
}
