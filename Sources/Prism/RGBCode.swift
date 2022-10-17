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
    
    var rawColorCode: String {
      if isValid {
        return "2;\(Int(red * 255));\(Int(green * 255));\(Int(blue * 255))"
      } else {
        return ""
      }
    }
    
    var foregroundCode: String {
      if isValid {
        return "38;\(rawColorCode)"
      } else {
        return ""
      }
    }
    
    var backgroundCode: String {
      if isValid {
        return "48;\(rawColorCode)"
      } else {
        return ""
      }
    }
    
    private init?<N: Numeric & Comparable>(_ r: N, _ g: N, _ b: N) {
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
    
    /// Creates an rgb code from a string.
    ///
    /// For this initializer to be successful, the string you provide
    /// must be correctly formatted using
    /// [functional notation](https://www.w3.org/TR/css-color-3/#rgb-color).
    ///
    /// Examples of valid strings include:
    /// ```swift
    /// "rgb(127,52,200)"
    /// "rgb(75%, 22%, 33%)"
    /// "rgb(255 110 28)"
    /// ```
    ///
    /// The valid value ranges are 0-100 for percentages, and 0-255
    /// for integers. Values outside of these ranges will be clamped.
    public init?(string: String) {
      // Lowercase for easier parsing.
      var string = string.lowercased()
      
      // Iterating through the prefixes like this also handles the
      // case where string.hasPrefix("rgb(").
      for prefix in ["rgb", "("] where string.hasPrefix(prefix) {
        string.removeFirst(prefix.count)
      }
      
      // We _could_ be more strict here, and require that the string
      // has a closing parenthesis, but it seems kind of unnecessary.
      if string.hasSuffix(")") {
        string.removeLast()
      }
      
      let predicate = string.contains(",") ? { $0 == "," } : \.isWhitespace
      let split = string.split(whereSeparator: predicate).map {
        $0.trim(while: \.isWhitespace)
      }
      
      // ECMA-48 RGB mode doesn't support alpha values, so limit the
      // number of substrings to 3.
      guard split.count == 3 else {
        return nil
      }
      
      // If one substring has a % suffix, they must _all_ have one.
      if split.contains(where: { $0.hasSuffix("%") }) {
        guard split.allSatisfy({ $0.hasSuffix("%") }) else {
          return nil
        }
      }
      
      // The goal here is to get an array of doubles with each value
      // falling between 0 and 1.
      let numbers: [Double] = split.compactMap {
        var string = $0
        // If the string has a % suffix, remove it. If the new string
        // successfully converts to a double, clamp and divide it by
        // 100 to get the correct fractional value.
        //
        // Example paths:
        //
        // > String("54%") -> String("54") -> Double(54.0) -> Double(0.54)
        // > String("100%") -> String("100") -> Double(100.0) -> Double(1.0)
        // > String("255%") -> String("255") -> Double(100.0) -> Double(1.0)
        if string.hasSuffix("%") {
          string.removeLast()
          if let number = Double(string) {
            return number.clamped(to: 0...100) / 100
          }
        } else if let number = Int(string) {
          // If no % suffix, convert to a double, clamp, and divide to get
          // the correct fractional value.
          //
          // Example paths:
          //
          // > String("54") -> Int(54) -> Double(0.21176471)
          // > String("100") -> Int(100) -> Double(0.39215686)
          // > String("255") -> Int(255) -> Double(1.0)
          return Double(number).clamped(to: 0...255) / 255
        }
        return nil
      }
      
      // Make sure that every split was converted successfully.
      guard numbers.count == split.count else {
        return nil
      }
      
      self.init(red: numbers[0], green: numbers[1], blue: numbers[2])
    }
    
    private static func validate<
      I: Numeric & Comparable,
      O: Numeric & Comparable
    >(
      _ number: I,
      as type: O.Type
    ) -> O? {
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
