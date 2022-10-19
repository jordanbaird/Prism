//===----------------------------------------------------------------------===//
//
// ControlSequence.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A sequence of components that make up the underlying value of a prism.
public struct ControlSequence {
  
  // MARK: - Properties
  
  let base: [Component]
  
  public var description: String {
    "\(Self.self)(\(base.map(\.description).joined(separator: ", ")))"
  }
  
  public var debugDescription: String {
    "\(Self.self)(\(base.map(\.debugDescription).joined(separator: ", ")))"
  }
  
  var mapped: String {
    base.map(\.rawValue).joined()
  }
  
  // MARK: - Initializers
  
  init(_ base: [Component]) {
    self.base = base
  }
  
  init(_ base: Component...) {
    self.init(base)
  }
  
  init(withCodeComponent component: Any) {
    self.init(.introducer, .init("\(component)"), .closer)
  }
  
  init(for element: PrismElement) {
    if element.nestedElements.isEmpty {
      if let element = element as? Attribute {
        self = element.onSequence + .string(element.rawValue) + element.offSequence
      } else {
        self = .string(element.rawValue)
      }
    } else {
      let sequences = element.nestedElements.reduce(into: Self()) {
        $0 += $1.controlSequence
      }
      if let element = element as? Attribute {
        self = element.onSequence + .string(element.rawValue) + sequences + element.offSequence
      } else {
        self = .string(element.rawValue) + sequences
      }
    }
  }
}

// MARK: - Static Constants

extension ControlSequence {
  static let reset = Self(withCodeComponent: 0)
  
  static let boldOn = Self(withCodeComponent: 1)
  static let boldOff = Self(withCodeComponent: 22)
  
  static let dimOn = Self(withCodeComponent: 2)
  static let dimOff = Self(withCodeComponent: 22)
  
  static let italicOn = Self(withCodeComponent: 3)
  static let italicOff = Self(withCodeComponent: 23)
  
  static let underlineOn = Self(withCodeComponent: 4)
  static let underlineOff = Self(withCodeComponent: 24)
  
  static let overlineOn = Self(withCodeComponent: 53)
  static let overlineOff = Self(withCodeComponent: 55)
  
  static let blinkOn = Self(withCodeComponent: 5)
  static let blinkOff = Self(withCodeComponent: 25)
  
  static let swapOn = Self(withCodeComponent: 7)
  static let swapOff = Self(withCodeComponent: 27)
  
  static let hideOn = Self(withCodeComponent: 8)
  static let hideOff = Self(withCodeComponent: 28)
  
  static let strikethroughOn = Self(withCodeComponent: 9)
  static let strikethroughOff = Self(withCodeComponent: 29)
  
  static func foregroundColor(_ color: Color) -> Self {
    Self(withCodeComponent: color.foregroundCode)
  }
  
  static func backgroundColor(_ color: Color) -> Self {
    Self(withCodeComponent: color.backgroundCode)
  }
  
  static func string(_ str: String) -> Self {
    Self(.init(str))
  }
}

// MARK: - Operators

extension ControlSequence {
  public static func + (lhs: Self, rhs: Self) -> Self {
    Self(lhs.base + rhs.base)
  }
  
  public static func += (lhs: inout Self, rhs: Self) {
    lhs = lhs + rhs
  }
}

// MARK: - Protocol Conformances

extension ControlSequence: Codable { }

extension ControlSequence: CustomDebugStringConvertible { }

extension ControlSequence: CustomStringConvertible { }

extension ControlSequence: Equatable { }

extension ControlSequence: Hashable { }
