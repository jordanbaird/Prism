//===----------------------------------------------------------------------===//
//
// ANSIColor.swift
//
// Created: 2022. Creator: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A type used to alter the color of text displayed in the command line.
public struct ANSIColor {
  private var rawValue: Int
  
  private var escapeCode: String {
    "\u{001B}[\(rawValue)" + "m"
  }
  
  private init(rawValue: Int) {
    self.rawValue = rawValue
  }
}

extension ANSIColor {
  /// The ANSI black color.
  public static let black = Self(rawValue: 30)
  
  /// The ANSI red color.
  public static let red = Self(rawValue: 31)
  
  /// The ANSI green color.
  public static let green = Self(rawValue: 32)
  
  /// The ANSI yellow color.
  public static let yellow = Self(rawValue: 33)
  
  /// The ANSI blue color.
  public static let blue = Self(rawValue: 34)
  
  /// The ANSI magenta color.
  public static let magenta = Self(rawValue: 35)
  
  /// The ANSI cyan color.
  public static let cyan = Self(rawValue: 36)
  
  /// The ANSI white color.
  public static let white = Self(rawValue: 37)
  
  /// Resets the color to default.
  public static let `default` = Self(rawValue: 0)
}

extension ANSIColor {
  /// Produces text that will be rendered in the given color when displayed in
  /// a terminal.
  ///
  /// > Anywhere outside of a terminal, this text will be prefixed and suffixed
  /// with ANSI escape codes. As such, this string is likely unusable in other
  /// scenarios. If the string will be used for additional purposes, be sure to
  /// make a separate copy before altering it with this method.
  public func text(_ text: String) -> String {
    escapeCode + text + Self.default.escapeCode
  }
}

extension ANSIColor: Hashable { }

extension ANSIColor: Equatable { }
