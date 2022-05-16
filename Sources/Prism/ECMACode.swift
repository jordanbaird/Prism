//===----------------------------------------------------------------------===//
//
// ECMACode.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A color code that produces one of the ECMA-48 standard's 256 colors.
///
/// Due to the difficult nature of the ECMA-48 256-color mode standard, the codes
/// have been broken up into smaller "subcodes", such as ``ECMA256Color/Grayscale``.
/// An instance of ``ECMA256Color`` can be created by passing a value of one of
/// these subcodes, or by accessing one of the static convenience methods.
public typealias ECMA256Color = Color.ECMA256Color

/// A color code that conforms to the ECMA-48 SGR standard.
public protocol ECMACode: Hashable {
  /// The type of a code's numeric raw value.
  typealias NumericCode = UInt8
  /// The raw value associated with the code.
  var rawValue: NumericCode { get }
}

public protocol ECMASubcode: ECMACode { }

extension Color {
  /// A color code that produces one of the ECMA-48 standard's 256 colors.
  ///
  /// Due to the difficult nature of the ECMA-48 256-color mode standard, the codes
  /// have been broken up into smaller "subcodes", such as ``ECMA256Color/Grayscale``.
  /// An instance of ``ECMA256Color`` can be created by passing a value of one of
  /// these subcodes, or by accessing one of the static convenience methods.
  ///
  /// Alternatively, if you know the exact numeric code you wish to use, you can
  /// construct an instance using the ``init(numericCode:)`` initializer.
  public struct ECMA256Color: ECMACode {
    /// The subcode at the base of the color.
    public let subcode: AnySubcode
    
    public var rawValue: NumericCode {
      subcode.rawValue
    }
    
    /// Creates an ECMA256 color from the given subcode.
    /// - Parameter subcode: An instance of the ``AnySubcode`` subcode type.
    public init(subcode: AnySubcode) {
      self.subcode = subcode
    }
    
    /// Creates an ECMA256 color from the given subcode.
    /// - Parameter subcode: An ``ECMASubcode`` type that will be used to
    /// construct the color.
    public init<C: ECMASubcode>(subcode: C) {
      self.init(subcode: .init(subcode))
    }
    
    /// Creates an ECMA256 color from the given grayscale subcode.
    /// - Parameter subcode: An instance of the ``Grayscale`` subcode type.
    public init(grayscale subcode: Grayscale) {
      self.init(subcode: subcode)
    }
    
    /// Creates an ECMA256 color from the given standard subcode.
    /// - Parameter subcode: An instance of the ``StandardColor`` subcode type.
    public init(standard subcode: StandardColor) {
      self.init(subcode: subcode)
    }
    
    /// Creates an ECMA256 color from the given numeric value.
    /// - Parameter numericCode: A numeric value between 0 and 255.
    public init(numericCode: NumericCode) {
      self.init(subcode: AnySubcode(rawValue: numericCode))
    }
  }
}

extension ECMA256Color {
  /// Returns an ECMA code that produces a grayscale color.
  public static func grayscale(_ subcode: Grayscale) -> Self {
    .init(grayscale: subcode)
  }
  
  /// Returns an ECMA code that produces one of eight standard colors.
  public static func standardColor(_ subcode: StandardColor) -> Self {
    .init(standard: subcode)
  }
}

// MARK: - StandardColor

extension ECMA256Color {
  /// An ECMA-48-compliant code that produces one of sixteen standard colors.
  public struct StandardColor: ECMASubcode {
    /// The ECMA256 standard black color.
    public static let black = Self(rawValue: 0)
    /// The ECMA standard red color.
    public static let red = Self(rawValue: 1)
    /// The ECMA standard green color.
    public static let green = Self(rawValue: 2)
    /// The ECMA standard yellow color.
    public static let yellow = Self(rawValue: 3)
    /// The ECMA standard blue color.
    public static let blue = Self(rawValue: 4)
    /// The ECMA standard magenta color.
    public static let magenta = Self(rawValue: 5)
    /// The ECMA standard cyan color.
    public static let cyan = Self(rawValue: 6)
    /// The ECMA standard light gray color.
    public static let lightGray = Self(rawValue: 7)
    /// The ECMA256 standard dark gray color.
    public static let darkGray = Self(rawValue: 8)
    /// The ECMA standard bright red color.
    public static let brightRed = Self(rawValue: 9)
    /// The ECMA standard bright green color.
    public static let brightGreen = Self(rawValue: 10)
    /// The ECMA standard bright yellow color.
    public static let brightYellow = Self(rawValue: 11)
    /// The ECMA standard bright blue color.
    public static let brightBlue = Self(rawValue: 12)
    /// The ECMA standard bright magenta color.
    public static let brightMagenta = Self(rawValue: 13)
    /// The ECMA standard bright cyan color.
    public static let brightCyan = Self(rawValue: 14)
    /// The ECMA standard white color.
    public static let white = Self(rawValue: 15)
    
    /// The raw value associated with the code.
    ///
    /// The possible values of this property are integers between 0 and 15. Codes
    /// 0 through 7 produce medium-intensity versions of the colors, while codes
    /// 8 through 15 produce high-intensity versions of the colors. Each of these
    /// codes is associated with one of `StandardColor`'s static constants.
    public let rawValue: NumericCode
    
    private init(rawValue: NumericCode) {
      self.rawValue = rawValue
    }
  }
}

// MARK: - Grayscale

extension ECMA256Color {
  /// An ECMA-48-compliant code that produces grayscale colors.
  public struct Grayscale: ECMASubcode {
    /// The raw value associated with the code.
    ///
    /// The possible values of this property are integers between 232 and 255, with
    /// 232 producing a near-black color, and 255 producing a near-white color.
    public let rawValue: NumericCode
    
    /// Creates a grayscale ECMA code with the given intensity.
    /// - Parameter intensity: A value between 0 and 1 that dictates how bright the
    /// color will be. Numbers closer to 0 will produce darker colors, while numbers
    /// closer to 1 will produce lighter colors.
    public init(intensity: Double) {
      let intensity = intensity < 0 ? 0 : intensity > 1 ? 1 : intensity
      let remappedIntensity = (intensity * 23) + 232
      rawValue = .init(remappedIntensity)
    }
  }
}

extension ECMA256Color {
  /// A type that wraps the raw value of another subcode.
  public struct AnySubcode: ECMASubcode {
    public let rawValue: NumericCode
    
    init(rawValue: NumericCode) {
      self.rawValue = rawValue
    }
    
    /// Creates a subcode from the raw value of the given subcode.
    public init<C: ECMASubcode>(_ base: C) {
      self.init(rawValue: base.rawValue)
    }
  }
}
