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
  
  /// Constants that describe how a prism's elements should be spaced
  /// when displayed in a terminal.
  public enum Spacing: Hashable {
    /// Constants that represent the type of element a prism should
    /// use for managed spacing.
    public enum ElementType: Hashable {
      /// Indicates that managed spacing will use the ``LineBreak``
      /// type with ``LineBreak/LineBreakType/newline`` characters.
      case newlines
      
      /// Indicates that managed spacing will use the ``LineBreak``
      /// type with ``LineBreak/LineBreakType/return`` characters.
      case returns
      
      /// Indicates that managed spacing will use the ``Spacer``
      /// type with ``Spacer/SpacerType/space`` characters.
      case spaces
      
      /// Indicates that managed spacing will use the ``Spacer``
      /// type with ``Spacer/SpacerType/tab`` characters.
      case tabs
    }
    
    /// Elements are automatically separated by ``Spacer``
    /// or ``LineBreak`` elements.
    case managed(_ elementType: ElementType)
    
    /// Elements are spaced according to the placement
    /// of ``Spacer`` and ``LineBreak`` elements within the prism.
    case custom
    
    /// Elements are automatically separated
    /// by ``Spacer/SpacerType/space`` elements.
    public static let spaces = Self.managed(.spaces)
    
    /// Elements are automatically separated
    /// by ``Spacer/SpacerType/tab`` elements.
    public static let tabs = Self.managed(.tabs)
    
    /// Elements are automatically separated
    /// by ``LineBreak/LineBreakType/newline`` elements.
    public static let newlines = Self.managed(.newlines)
    
    /// Elements are automatically separated
    /// by ``LineBreak/LineBreakType/return`` elements.
    public static let returns = Self.managed(.returns)
  }
  
  // MARK: - Properties
  
  /// A value that describes how the prism's elements should be spaced
  /// when displayed in a terminal.
  public let spacing: Spacing
  
  private var _elements: [PrismElement]
  
  /// The elements that make up the prism.
  public var elements: [PrismElement] {
    _elements.reduce(into: []) {
      $1.prism = self
      $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer()
    }
  }
  
  /// A textual representation of the prism.
  public var description: String {
    elements.reduce("") { $0 + $1.description }
  }
  
  /// A textual representation of the prism that is suitable for debugging.
  public var debugDescription: String {
    elements
      .map { $0.debugDescription }
      .joined(separator: ", ")
  }
  
  /// A textual representation of the prism that shows its control characters.
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

// MARK: - Test Helpers

extension Prism {
  var testableDescription: String {
    elements.reduce("") { $0 + $1.testableDescription }
  }
}
