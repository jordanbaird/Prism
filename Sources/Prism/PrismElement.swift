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
  var id: UInt64 { get }
  var rawValue: String { get }
}

extension PrismElement {
  
  // MARK: - Static Properties
  
  static var rng: SystemRandomNumberGenerator {
    get { .init() }
    set { }
  }
  
  // MARK: - Instance Properties
  
  var controlSequence: ControlSequence {
    .init(for: self)
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
    controlSequence.base.map {
      var buffer = ""
      for char in $0.rawValue {
        if char == "\u{001B}" {
          buffer.append("\\u{001B}")
        } else {
          buffer.append(char)
        }
      }
      return buffer
    }.joined()
  }
  
  var nestedElements: [PrismElement] {
    get {
      Storage(id).get("nestedElements", backup: []).reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      Storage(id).set(newValue, forKey: "nestedElements")
      updateNestedElements()
    }
  }
  
  var parentElement: PrismElement? {
    get { Storage(id).get("parentElement") }
    nonmutating set {
      Storage(id).set(newValue, forKey: "parentElement")
      updateNestedElements()
    }
  }
  
  var prism: Prism? {
    get { Storage(id).get("prism") }
    nonmutating set {
      Storage(id).set(newValue, forKey: "prism")
      updateNestedElements()
    }
  }
  
  public internal(set) var rawValue: String {
    get { Storage(id).get("rawValue", backup: "") }
    set { Storage(id).set(newValue, forKey: "rawValue") }
  }
  
  var spacing: Prism.Spacing {
    get { Storage(id).get("spacing") ?? prism?.spacing ?? .managed(.spaces) }
    set { Storage(id).set(newValue, forKey: "spacing") }
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

// MARK: - Extension where Self == String

extension PrismElement where Self == String {
  public var id: UInt64 { .init() }
  
  public internal(set) var rawValue: String {
    get { self }
    set { self = newValue }
  }
}

// MARK: - SpacerElement

protocol SpacerElement: PrismElement { }

extension SpacerElement {
  public var debugDescription: String { "\(Self.self)()" }
  public var id: UInt64 {
    .init("\(Self.self)".hashValue.magnitude)
  }
}
