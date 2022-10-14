//===----------------------------------------------------------------------===//
//
// PrismElement.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A type that can be combined with other elements to make up a ``Prism``.
public protocol PrismElement: CustomStringConvertible, CustomDebugStringConvertible {
  /// The element's identifying value.
  @available(*, deprecated, message: "`id` is no longer applicable")
  var id: UInt64 { get }
  
  /// The control sequence at the base of the element.
  var controlSequence: ControlSequence { get }
  
  /// The elements nested inside the element.
  var nestedElements: [PrismElement] { get set }
  
  /// The element's parent.
  var parentElement: PrismElement? { get nonmutating set }
  
  /// The element's enclosing ``Prism`` object.
  var prism: Prism? { get nonmutating set }
  
  /// The spacing that the element's prism imposes upon it.
  var spacing: Prism.Spacing { get set }
  
  /// The raw value of the element.
  var rawValue: String { get }
}

extension PrismElement {
  
  // MARK: - Static Properties
  
  static var rng: SystemRandomNumberGenerator {
    get { .init() }
    set { }
  }
  
  // MARK: - Instance Properties
  
  var colorCompatibleDescription: String {
    if Destination.current == .formattingCompatible {
      return controlSequence.mapped
    } else if rawValue.isEmpty {
      return nestedElements.map(\.description).joined()
    } else {
      return rawValue
    }
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
    controlSequence.base.map(\.escapedDescription).joined()
  }
  
  // MARK: - Methods
  
  func maybePrependSpacer(with spacing: Prism.Spacing) -> [PrismElement] {
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
      element.parentElement = self
      element.prism = prism
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

// MARK: - Test Helpers

extension PrismElement {
  var testableDescription: String {
    controlSequence.base.map(\.rawValue).joined()
  }
}
