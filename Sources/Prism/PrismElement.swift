//===----------------------------------------------------------------------===//
//
// PrismElement.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A type that can be combined with other elements to make up a ``Prism``.
public protocol PrismElement: CustomStringConvertible, CustomDebugStringConvertible {
  /// The control sequence at the base of the element.
  var controlSequence: ControlSequence { get }
  
  /// The elements nested inside the element.
  var nestedElements: [PrismElement] { get set }
  
  /// The element's enclosing ``Prism`` object.
  var prism: Prism? { get nonmutating set }
  
  /// The spacing that the element's prism imposes upon it.
  var spacing: Prism.Spacing { get set }
  
  /// The raw value of the element.
  var rawValue: String { get }
}

extension PrismElement {
  
  // MARK: - Instance Properties
  
  var colorCompatibleDescription: String {
    if Destination.current == .formattingCompatible {
      return controlSequence.reduced
    } else if rawValue.isEmpty {
      return nestedElements.reduce("") { $0 + $1.description }
    }
    return rawValue
  }
  
  /// A textual representation of the element.
  public var description: String {
    rawValue
  }
  
  /// A textual representation of the element that is suitable for debugging.
  public var debugDescription: String {
    "\(Self.self)(rawValue: " + rawValue + ")"
  }
  
  /// A textual representation of the element that shows its control characters.
  public var escapedDescription: String {
    controlSequence.base.reduce("") { $0 + $1.escapedDescription }
  }
  
  // MARK: - Methods
  
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
  
  // MARK: - Operators
  
  public static func + (lhs: Self, rhs: PrismElement) -> Prism {
    Prism([lhs, rhs])
  }
  
  public static func + (lhs: Self, rhs: Prism) -> Prism {
    Prism([lhs]) + rhs
  }
}

extension PrismElement {
  func setParentElementRef(from element: PrismElement) {
    guard
      let self = self as? HasElementRef,
      let element = element as? HasElementRef
    else {
      return
    }
    self.elementRef.parentElementRef = element.elementRef
  }
}

// MARK: - Test Helpers

extension PrismElement {
  var testableDescription: String {
    controlSequence.base.reduce("") { $0 + $1.rawValue }
  }
  
  func isEqual(_ other: PrismElement) -> Bool {
    controlSequence == other.controlSequence &&
    rawValue == other.rawValue &&
    spacing == other.spacing &&
    nestedElements.endIndex == other.nestedElements.endIndex &&
    (0..<nestedElements.endIndex).allSatisfy {
      nestedElements[$0].isEqual(other.nestedElements[$0])
    }
  }
}

extension Array where Element == PrismElement {
  func isEqual(_ other: [PrismElement]) -> Bool {
    guard endIndex == other.endIndex else {
      return false
    }
    return (0..<endIndex).allSatisfy {
      self[$0].isEqual(other[$0])
    }
  }
}
