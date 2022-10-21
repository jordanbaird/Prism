//===----------------------------------------------------------------------===//
//
// Prism.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A type that contains multiple elements that will be combined
/// into a final formatted string for display in a terminal.
public struct Prism {
  
  // MARK: - Properties
  
  /// A value that describes how the prism's elements should
  /// be spaced when displayed in a terminal.
  public let spacing: Spacing
  
  private var _elements: [PrismElement]
  
  /// The elements that make up the prism.
  public var elements: [PrismElement] {
    _elements.reduce(into: []) {
      $1.prism = self
      $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer()
    }
  }
  
  /// A textual representation of the prism that shows its
  /// control characters.
  public var escapedDescription: String {
    elements.reduce("") { $0 + $1.escapedDescription }
  }
  
  // MARK: - Initializers
  
  /// Creates a prism with the given elements and spacing.
  public init(spacing: Spacing = .spaces, elements: [PrismElement]) {
    _elements = elements
    self.spacing = spacing
  }
  
  /// Creates a prism with the given elements and spacing.
  public init(spacing: Spacing = .spaces, elements: PrismElement...) {
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
  public init(spacing: Spacing = .spaces, @ElementBuilder _ elements: () -> [PrismElement]) {
    self.init(spacing: spacing, elements: elements())
  }
  
  // MARK: - Methods
  
  /// The string value of the prism.
  ///
  /// Accessing this property is equivalent to accessing
  /// the ``description`` property.
  public func string() -> String {
    description
  }
}

// MARK: - Operators

extension Prism {
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

// MARK: - Protocol Conformances

extension Prism: CustomStringConvertible {
  /// A textual representation of the prism.
  public var description: String {
    elements.reduce("") { $0 + $1.description }
  }
}

extension Prism: CustomDebugStringConvertible {
  /// A textual representation of the prism that is suitable
  /// for debugging.
  public var debugDescription: String {
    elements
      .map { $0.debugDescription }
      .joined(separator: ", ")
  }
}

extension Prism: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.elements._isEqual(rhs.elements)
  }
}

extension Prism: Hashable {
  public func hash(into hasher: inout Hasher) {
    elements._hash(&hasher)
  }
}

// MARK: - Test Helpers

extension Prism {
  var testableDescription: String {
    elements.reduce("") { $0 + $1.testableDescription }
  }
}
