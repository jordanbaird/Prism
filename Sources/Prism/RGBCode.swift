//===----------------------------------------------------------------------===//
//
// RGBCode.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A type that contains a red, a green, and a blue value, that can be used to
/// construct a ``Color`` instance.
public typealias RGBCode = Color.RGBCode

extension Color {
  /// A type that contains a red, a green, and a blue value, that can be used to
  /// construct a ``Color`` instance.
  public struct RGBCode {
    typealias ValidNumber = Numeric & Comparable
    
    /// The red value of this code.
    public let red: Double
    /// The green value of this code.
    public let green: Double
    /// The blue value of this code.
    public let blue: Double
    
    /// A Boolean value indicating whether the instance is a valid rgb code.
    ///
    /// If this value is false, the code will construct a ``Color`` instance
    /// of the ``Color/default`` value.
    public var isValid: Bool {
      red <= 1 &&
      red >= 0 &&
      green <= 1 &&
      green >= 0 &&
      blue <= 1 &&
      blue >= 0
    }
    
    var rawValue: String {
      if isValid {
        return "2;\(Int(red * 255));\(Int(green * 255));\(Int(blue * 255))"
      } else {
        return ""
      }
    }
    
    var foregroundCode: String {
      if isValid {
        return "38;\(rawValue)"
      } else {
        return ""
      }
    }
    
    var backgroundCode: String {
      if isValid {
        return "48;\(rawValue)"
      } else {
        return ""
      }
    }
    
    private init?<N: ValidNumber>(_ r: N, _ g: N, _ b: N) {
      if
        let r = Self.validate(r, as: Double.self),
        let g = Self.validate(g, as: Double.self),
        let b = Self.validate(b, as: Double.self)
      {
        red = r
        green = g
        blue = b
      } else if
        let r = Self.validate(r, as: Int.self),
        let g = Self.validate(g, as: Int.self),
        let b = Self.validate(b, as: Int.self)
      {
        red = Double(r) / 255
        green = Double(g) / 255
        blue = Double(b) / 255
      } else {
        return nil
      }
    }
    
    /// Creates a code with the given red, green, and blue floating point values.
    ///
    /// To be valid, these values must be between 0.0 and 1.0.
    public init(red: Double, green: Double, blue: Double) {
      if let code = Self(red, green, blue) {
        self = code
      } else {
        self.red = red
        self.green = green
        self.blue = blue
      }
    }
    
    /// Creates a code with the given red, green, and blue integer values.
    ///
    /// To be valid, these values must be between 0 and 255.
    public init(red: Int, green: Int, blue: Int) {
      if let code = Self(red, green, blue) {
        self = code
      } else {
        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
      }
    }
    
    private static func validate<I: ValidNumber, O: ValidNumber>(_ number: I, as type: O.Type) -> O? {
      if
        O.self is Double.Type,
        let number = number as? O,
        number >= 0,
        number <= 1
      {
        return number
      } else if
        O.self is Int.Type,
        let number = number as? O,
        number >= 0,
        number <= 255
      {
        return number
      }
      return nil
    }
  }
}

extension RGBCode: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.red == rhs.red &&
    lhs.green == rhs.green &&
    lhs.blue == rhs.blue
  }
}

extension RGBCode: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(red)
    hasher.combine(green)
    hasher.combine(blue)
  }
}
