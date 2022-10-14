//===----------------------------------------------------------------------===//
//
// Component.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

extension ControlSequence {
  struct Component {
    private let _nestedComponents: ControlSequence
    private let _rawValue: String
    
    var nestedComponents: ControlSequence {
      _rawValue.isEmpty
      ? _nestedComponents
      : .init(.init(_rawValue))
    }
    
    var rawValue: String {
      _nestedComponents.base.isEmpty
      ? _rawValue
      : _nestedComponents.mapped
    }
    
    var escapedDescription: String {
      rawValue.reduce(into: "") {
        if $1 == "\u{001B}" {
          $0.append("\\u{001B}")
        } else {
          $0.append($1)
        }
      }
    }
    
    init(_ rawValue: String) {
      _nestedComponents = .init()
      _rawValue = rawValue
    }
    
    init(_ nestedComponents: [Component]) {
      _nestedComponents = .init(nestedComponents)
      _rawValue = ""
    }
  }
}

extension ControlSequence.Component {
  static let escape = Self("\u{001B}")
  static let bracket = Self("[")
  static let semicolon = Self(";")
  static let closer = Self("m")
  static let introducer = Self([escape, bracket])
}

extension ControlSequence.Component: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    "\(Self.self)"
  }
  
  public var debugDescription: String {
    var description = "\(Self.self)("
    if _nestedComponents.base.isEmpty {
      if self == .escape {
        description.append("rawValue: \"ESC\"")
      } else if _rawValue == "\n" {
        description.append("rawValue: \"\\n\"")
      } else if _rawValue == "\r" {
        description.append("rawValue: \"\\r\"")
      } else if _rawValue == " " {
        description.append("rawValue: \" \"")
      } else if _rawValue == "\t" {
        description.append("rawValue: \"\\t\"")
      } else {
        description.append("rawValue: \"\(_rawValue)\"")
      }
    } else if _rawValue.isEmpty {
      let mappedAndJoined = _nestedComponents.base.map(\.debugDescription).joined(separator: ", ")
      description.append("nestedComponents: \(mappedAndJoined)")
    } else {
      description.append("ERROR")
    }
    return description + ")"
  }
}

extension ControlSequence.Component: Codable { }

extension ControlSequence.Component: Equatable { }

extension ControlSequence.Component: Hashable { }
