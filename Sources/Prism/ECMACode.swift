//===----------------------------------------------------------------------===//
//
// ECMACode.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A color code that produces one of the ECMA-48 standard's 256 colors.
///
/// Due to the difficult nature of the ECMA-48 256-color mode standard,
/// the codes have been broken up into smaller "subcodes", such as
/// ``ECMACode/Grayscale``. An instance of ``ECMACode`` can be created
/// by passing a value of one of these subcodes, or by accessing one
/// of the static convenience methods.
public typealias ECMACode = Color.ECMACode

/// A type that produces a raw value that conforms to the ECMA-48 SGR standard.
public protocol ECMAStandardCompatible {
  /// The raw value associated with the code.
  var rawValue: Int { get }
}

extension Color {
  /// A color code that produces one of the ECMA-48 standard's 256 colors.
  ///
  /// Due to the difficult nature of the ECMA-48 256-color mode standard,
  /// the codes have been broken up into smaller "subcodes", such as
  /// ``ECMACode/Grayscale``. An instance of ``ECMACode`` can be created
  /// by passing a value of one of these subcodes, or by accessing one
  /// of the static convenience methods.
  public struct ECMACode: ECMAStandardCompatible {
    let subcode: ECMAStandardCompatible
    
    public var rawValue: Int {
      subcode.rawValue
    }
    
    init(subcode: ECMAStandardCompatible) {
      self.subcode = subcode
    }
  }
}

extension ECMACode {
  /// Returns an ECMA code that produces a grayscale color.
  public static func grayscale(_ subcode: Grayscale) -> Self {
    .init(subcode: subcode)
  }
}

extension ECMACode {
  /// An ECMA-48-compliant code that produces grayscale colors.
  public struct Grayscale: ECMAStandardCompatible {
    /// The raw value associated with the code.
    ///
    /// The possible values of this property are integers between 232 and 255, with
    /// 232 producing a near-black color, and 255 producing a near-white color.
    public let rawValue: Int
    
    /// Creates a grayscale ECMA code with the given intensity.
    /// - Parameter intensity: A value between 0 and 1 that dictates how bright the
    /// color will be. Numbers closer to 0 will produce darker colors, while numbers
    /// closer to 1 will produce lighter colors.
    public init(intensity: Double) {
      let remappedIntensity = (intensity * 23) + 232
      rawValue = .init(remappedIntensity)
    }
  }
}
