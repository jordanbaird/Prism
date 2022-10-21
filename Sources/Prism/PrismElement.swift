//===----------------------------------------------------------------------===//
//
// PrismElement.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

// MARK: - PrismElement Protocol

/// A type that can be combined with other elements to make up a ``Prism``.
public protocol PrismElement: CustomStringConvertible, CustomDebugStringConvertible {
  /// The control sequence at the base of the element.
  var controlSequence: ControlSequence { get }
  
  /// The elements nested inside the element.
  var nestedElements: [PrismElement] { get set }
  
  /// The element's enclosing ``Prism`` object.
  var prism: Prism? { get nonmutating set }
  
  /// The spacing of the element.
  ///
  /// Unless otherwise set, this is the same as the spacing
  /// of the element's enclosing ``Prism`` object.
  var spacing: Prism.Spacing { get set }
  
  /// The raw value of the element.
  var rawValue: String { get }
}

extension PrismElement {
  
  // MARK: - Instance Properties
  
  /// A textual representation of the element.
  public var description: String {
    string(formatted: Destination.current == .formattingCompatible)
  }
  
  /// A textual representation of the element that is suitable
  /// for debugging.
  public var debugDescription: String {
    "\(Self.self)(controlSequence: \(controlSequence.debugDescription))"
  }
  
  /// A textual representation of the element that shows its
  /// control characters.
  public var escapedDescription: String {
    controlSequence.base.reduce("") { $0 + $1.escapedDescription }
  }
  
  // MARK: - Methods
  
  /// Returns the string value of the attribute in either a
  /// formatted or unformatted representation.
  ///
  /// Passing `true` into the `formatted` parameter returns the
  /// attribute's ``description`` property. Passing `false` returns
  /// an unformatted version of the attribute's string.
  public func string(formatted: Bool = true) -> String {
    if formatted {
      return controlSequence.reduced
    }
    return rawValue + nestedElements.reduce("") {
      $0 + $1.string(formatted: false)
    }
  }
}

// MARK: - Operators

extension PrismElement {
  public static func + (lhs: Self, rhs: PrismElement) -> Prism {
    Prism([lhs, rhs])
  }
  
  public static func + (lhs: Self, rhs: Prism) -> Prism {
    Prism([lhs]) + rhs
  }
}

// MARK: - Helpers

extension PrismElement {
  func maybePrependSpacer() -> [PrismElement] {
    switch spacing {
    case .managed(.spaces):
      return [Spacer(type: .space), self]
    case .managed(.tabs):
      return [Spacer(type: .tab), self]
    case .managed(.newlines):
      return [LineBreak(type: .newline), self]
    case .managed(.returns):
      return [LineBreak(type: .return), self]
    case .custom:
      return [self]
    }
  }
  
  func updateNestedElements() {
    for element in nestedElements {
      element.setParentElementRef(from: self)
      element.prism = prism
      element.updateNestedElements()
    }
  }
  
  func setParentElementRef(from element: PrismElement) {
    guard
      let self = self as? HasElementRef,
      let element = element as? HasElementRef
    else {
      return
    }
    self.elementRef.parentElementRef = element.elementRef
  }
  
  func _isEqual(_ other: PrismElement) -> Bool {
    controlSequence == other.controlSequence &&
    nestedElements._isEqual(other.nestedElements)
  }
  
  func _hash(_ hasher: inout Hasher) {
    hasher.combine(controlSequence)
    nestedElements._hash(&hasher)
  }
}

// MARK: Array Helpers

extension Array where Element == PrismElement {
  func _isEqual(_ other: [PrismElement]) -> Bool {
    guard endIndex == other.endIndex else {
      return false
    }
    return indices.allSatisfy {
      self[$0]._isEqual(other[$0])
    }
  }
  
  func _hash(_ hasher: inout Hasher) {
    for element in self {
      element._hash(&hasher)
    }
  }
}

// MARK: - Test Helpers

extension PrismElement {
  var testableDescription: String {
    controlSequence.base.reduce("") { $0 + $1.rawValue }
  }
}
