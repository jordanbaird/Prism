//===----------------------------------------------------------------------===//
//
// Prism.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A type that contains multiple elements, that will be combined into a final
/// formatted string for display in a terminal.
public struct Prism:
  CustomStringConvertible,
  CustomDebugStringConvertible,
  Equatable,
  Hashable
{
  
  // MARK: - Nested Types
  
  /// Constants that describe how a prism's elements should be spaced when
  /// displayed in a terminal.
  public enum Spacing {
    /// Constants that represent the type of element to use for managed spacing.
    public enum ElementType {
      /// Indicates that managed spacing will use the ``LineBreak`` type with
      /// `newline` characters.
      case newlines
      /// Indicates that managed spacing will use the ``LineBreak`` type with
      /// `return` characters.
      case returns
      /// Indicates that managed spacing will use the ``Spacer`` type with
      /// `space` characters.
      case spaces
      /// Indicates that managed spacing will use the ``Spacer`` type with
      /// `tab` characters.
      case tabs
    }
    
    /// The elements are automatically separated by spaces or line breaks.
    case managed(_ elementType: ElementType)
    /// The elements are spaced according to the placement of ``Spacer`` and
    /// ``LineBreak`` elements within the prism.
    case custom
  }
  
  // MARK: - Properties
  
  /// A value that describes how the prism's elements should be spaced when
  /// displayed in a terminal.
  public let spacing: Spacing
  
  private var _elements: [PrismElement]
  
  /// The elements that make up the prism.
  public var elements: [PrismElement] {
    _elements.reduce(into: [PrismElement]()) {
      $1.prism = self
      $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
    } + [Reset()]
  }
  
  /// A textual representation of the prism.
  public var description: String {
    elements.map(\.description).joined()
  }
  
  /// A textual representation of the prism that is suitable for debugging.
  public var debugDescription: String {
    elements.map(\.debugDescription).joined(separator: ", ")
  }
  
  /// A textual representation of the prism that shows its control characters.
  public var escapedDescription: String {
    elements.map(\.escapedDescription).joined()
  }
  
  var testableDescription: String {
    elements.map(\.testableDescription).joined()
  }
  
  // MARK: - Initializers
  
  /// Creates a prism with the given elements and spacing.
  public init(spacing: Spacing = .managed(.spaces), elements: [PrismElement]) {
    _elements = elements
    self.spacing = spacing
  }
  
  /// Creates a prism with the given elements and spacing.
  public init(spacing: Spacing = .managed(.spaces), elements: PrismElement...) {
    self.init(spacing: spacing, elements: elements)
  }
  
  /// Creates a prism with the given elements and default spacing.
  public init(_ elements: [PrismElement]) {
    self.init(elements: elements)
  }
  
  /// Creates a prism with the given elements and default spacing.
  public init(_ elements: PrismElement...) {
    self.init(elements: elements)
  }
  
  /// Creates a prism with the given elements and spacing.
  public init(spacing: Spacing = .managed(.spaces), @ElementBuilder _ elements: () -> [PrismElement]) {
    self.init(spacing: spacing, elements: elements())
  }
  
  // MARK: - Methods
  
  public func hash(into hasher: inout Hasher) {
    for element in elements {
      hasher.combine(element.controlSequence)
    }
  }
  
  /// The string value of the prism.
  ///
  /// Accessing this property is equivalent to accessing the ``description`` property.
  public func string() -> String {
    description
  }
}

// MARK: - Operators

extension Prism {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    guard lhs.elements.endIndex == rhs.elements.endIndex else {
      return false
    }
    return !(0..<lhs.elements.count).contains {
      lhs.elements[$0].controlSequence != rhs.elements[$0].controlSequence
    }
  }
  
  public static func + (lhs: Self, rhs: Self) -> Self {
    Self(lhs._elements + rhs._elements)
  }
  
  public static func + (lhs: Self, rhs: [PrismElement]) -> Self {
    lhs + Self(rhs)
  }
  
  public static func + (lhs: Self, rhs: PrismElement) -> Self {
    lhs + Self(rhs)
  }
  
  public static func += (lhs: inout Self, rhs: Self) {
    lhs = lhs + rhs
  }
  
  public static func += (lhs: inout Self, rhs: [PrismElement]) {
    lhs = lhs + rhs
  }
  
  public static func += (lhs: inout Self, rhs: PrismElement) {
    lhs = lhs + rhs
  }
}
