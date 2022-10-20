//===----------------------------------------------------------------------===//
//
// EightBit.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

@available(*, deprecated, renamed: "EightBit")
public typealias ECMA256 = Color.EightBit

public typealias EightBit = Color.EightBit

/// A color code that conforms to the ECMA-48 standard.
public protocol ECMACode: Hashable {
  /// The raw value associated with the code.
  var numericCode: UInt8 { get }
}

extension Color {
  public struct EightBit: Hashable, Equatable {
    let subcode: AnySubcode
    
    var numericCode: UInt8 {
      subcode.numericCode
    }
    
    var rawColorCode: String {
      "5;\(numericCode)"
    }
    
    var foregroundCode: String {
      "38;\(rawColorCode)"
    }
    
    var backgroundCode: String {
      "48;\(rawColorCode)"
    }
    
    /// Creates an 8-bit color from the given subcode.
    /// - Parameter subcode: A type-erased subcode that produces a
    ///   color value.
    public init(subcode: AnySubcode) {
      self.subcode = subcode
    }
    
    /// Creates an 8-bit color from the given subcode.
    /// - Parameter subcode: A subcode that produces a color value.
    public init<C: ECMACode>(subcode: C) {
      self.init(subcode: .init(subcode))
    }
    
    /// Creates an 8-bit color from the given grayscale subcode.
    /// - Parameter subcode: A subcode that produces a grayscale value.
    public init(grayscale subcode: Grayscale) {
      self.init(subcode: subcode)
    }
    
    /// Creates an 8-bit color from the given standard subcode.
    /// - Parameter subcode: A subcode that produces a standard color value.
    public init(standard subcode: StandardColor) {
      self.init(subcode: subcode)
    }
    
    /// Creates an 8-bit color from the given numeric value.
    /// - Parameter numericCode: A numeric value between 0 and 255.
    public init(numericCode: UInt8) {
      self.init(subcode: AnySubcode(numericCode: numericCode))
    }
  }
}

extension Color.EightBit {
  /// Returns an 8-bit code that produces a grayscale color.
  /// - Parameter subcode: A subcode that produces a grayscale value.
  public static func grayscale(_ subcode: Grayscale) -> Self {
    .init(grayscale: subcode)
  }
  
  /// Returns an 8-bit code that produces one of sixteen standard colors.
  /// - Parameter subcode: A subcode that produces a standard color value.
  public static func standardColor(_ subcode: StandardColor) -> Self {
    .init(standard: subcode)
  }
}

// MARK: - StandardColor

extension Color.EightBit {
  /// An ECMA-48 compliant code that produces one of sixteen standard colors.
  public struct StandardColor: ECMACode {
    /// The ECMA standard black color.
    public static let black = Self(0)
    
    /// The ECMA standard red color.
    public static let red = Self(1)
    
    /// The ECMA standard green color.
    public static let green = Self(2)
    
    /// The ECMA standard yellow color.
    public static let yellow = Self(3)
    
    /// The ECMA standard blue color.
    public static let blue = Self(4)
    
    /// The ECMA standard magenta color.
    public static let magenta = Self(5)
    
    /// The ECMA standard cyan color.
    public static let cyan = Self(6)
    
    /// The ECMA standard light gray color.
    public static let lightGray = Self(7)
    
    /// The ECMA standard dark gray color.
    public static let darkGray = Self(8)
    
    /// The ECMA standard bright red color.
    public static let brightRed = Self(9)
    
    /// The ECMA standard bright green color.
    public static let brightGreen = Self(10)
    
    /// The ECMA standard bright yellow color.
    public static let brightYellow = Self(11)
    
    /// The ECMA standard bright blue color.
    public static let brightBlue = Self(12)
    
    /// The ECMA standard bright magenta color.
    public static let brightMagenta = Self(13)
    
    /// The ECMA standard bright cyan color.
    public static let brightCyan = Self(14)
    
    /// The ECMA standard white color.
    public static let white = Self(15)
    
    /// The raw value associated with the code.
    ///
    /// The possible values of this property are unsigned integers between 0
    /// and 15. Codes 0 through 7 produce standard-intensity colors, while
    /// codes 8 through 15 produce high-intensity colors. Each code matches
    /// one of ``Color/EightBit/StandardColor``'s static constants.
    public let numericCode: UInt8
    
    private init(_ numericCode: UInt8) {
      self.numericCode = numericCode
    }
  }
}

// MARK: - Grayscale

extension Color.EightBit {
  /// An ECMA-48 compliant code that produces grayscale colors.
  public struct Grayscale: ECMACode, ExpressibleByFloatLiteral {
    /// The raw value associated with the code.
    ///
    /// The possible values of this property are unsigned integers between 232
    /// and 255, with 232 producing a near-black color, and 255 producing a
    /// near-white color.
    public let numericCode: UInt8
    
    /// Creates a grayscale ECMA code with the given intensity.
    ///
    /// - Parameter intensity: A value between 0 and 1 that dictates how bright
    ///   the color will be. Numbers closer to 0 will produce darker colors, while
    ///   numbers closer to 1 will produce lighter colors.
    ///
    /// - Note: Values that are less than 0 will be clamped to 0. Values that are
    ///   greater than 1 will be clamped to 1.
    public init(intensity: Double) {
      let intensity = intensity < 0 ? 0 : intensity > 1 ? 1 : intensity
      let remappedIntensity = (intensity * 23) + 232
      numericCode = .init(remappedIntensity)
    }
    
    /// Creates a grayscale ECMA code with the given intensity, using a floating
    /// point literal.
    ///
    /// This value must be between 0 and 1. Numbers closer to 0 will produce
    /// darker colors, while numbers closer to 1 will produce lighter colors.
    ///
    /// - Note: Values that are less than 0 will be clamped to 0. Values that are
    ///   greater than 1 will be clamped to 1.
    public init(floatLiteral value: Double) {
      self.init(intensity: value)
    }
  }
}

// MARK: - AnySubcode

extension Color.EightBit {
  /// A type that wraps the raw value of another subcode.
  public struct AnySubcode: ECMACode {
    /// The raw value associated with the code.
    public let numericCode: UInt8
    
    init(numericCode: UInt8) {
      self.numericCode = numericCode
    }
    
    /// Creates a subcode from the raw value of the given subcode.
    public init<C: ECMACode>(_ base: C) {
      self.init(numericCode: base.numericCode)
    }
  }
}

extension Color {
  @available(*, deprecated, renamed: "EightBit")
  public typealias ECMA256 = EightBit
}
