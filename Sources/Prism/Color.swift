//===----------------------------------------------------------------------===//
//
// Color.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A color that text will be rendered in when displayed in a terminal.
public struct Color {
  
  // MARK: - Nested Types
  
  /// Styles that impact how a ``Color`` is rendered.
  public enum Style {
    /// The color is rendered in its default form.
    case `default`
    /// The color is rendered in a brighter form.
    case bright
    
    var rawValue: (foreground: Int, background: Int) {
      switch self {
      case .default:
        return (30, 40)
      case .bright:
        return (90, 100)
      }
    }
  }
  
  /// A type that contains a red, a green, and a blue value, that can
  /// be used to construct a ``Color`` instance.
  public struct RGBCode {
    /// The red value of this code.
    public let red: Double
    /// The green value of this code.
    public let green: Double
    /// The blue value of this code.
    public let blue: Double
    
    var rawValue: String {
      "2;\(Int(red * 255));\(Int(green * 255));\(Int(blue * 255))"
    }
    
    var foregroundCode: String {
      "38;\(rawValue)"
    }
    
    var backgroundCode: String {
      "48;\(rawValue)"
    }
  }
  
  // MARK: - Properties
  
  // This value is not used when `rgbCode` has a value.
  let rawValue: Int
  
  let rgbCode: RGBCode?
  
  let style: Style
  
  var foregroundCode: String {
    if let rgbCode = rgbCode {
      return rgbCode.foregroundCode
    } else {
      return "\(rawValue + style.rawValue.foreground)"
    }
  }
  
  var backgroundCode: String {
    if let rgbCode = rgbCode {
      return rgbCode.backgroundCode
    } else {
      return "\(rawValue + style.rawValue.background)"
    }
  }
  
  // MARK: - Initializers
  
  init(_ rawValue: Int, _ style: Style, _ rgbCode: RGBCode?) {
    self.rawValue = rawValue
    self.style = style
    self.rgbCode = rgbCode
  }
  
  /// Creates a color with the given RGB code.
  public init(rgbCode: RGBCode) {
    self.init(0, .default, rgbCode)
  }
  
  /// Creates a color with the given red, green, and blue values.
  public init(red: Double, green: Double, blue: Double) {
    self.init(rgbCode: .init(red: red, green: green, blue: blue))
  }
}

extension Color {
  
  // MARK: - Static Constants
  
  /// The ANSI black color.
  public static let black = black(style: .default)
  
  /// The ANSI red color.
  public static let red = red(style: .default)
  
  /// The ANSI green color.
  public static let green = green(style: .default)
  
  /// The ANSI yellow color.
  public static let yellow = yellow(style: .default)
  
  /// The ANSI blue color.
  public static let blue = blue(style: .default)
  
  /// The ANSI magenta color.
  public static let magenta = magenta(style: .default)
  
  /// The ANSI cyan color.
  public static let cyan = cyan(style: .default)
  
  /// The ANSI white color.
  public static let white = white(style: .default)
  
  /// The default text color of the terminal.
  public static let `default` = Self(9, .default, nil)
  
  // MARK: - Static Methods
  
  /// The ANSI black color, in either a default or bright style.
  public static func black(style: Style = .default) -> Self {
    .init(0, style, nil)
  }
  
  /// The ANSI red color, in either a default or bright style.
  public static func red(style: Style = .default) -> Self {
    .init(1, style, nil)
  }
  
  /// The ANSI green color, in either a default or bright style.
  public static func green(style: Style = .default) -> Self {
    .init(2, style, nil)
  }
  
  /// The ANSI yellow color, in either a default or bright style.
  public static func yellow(style: Style = .default) -> Self {
    .init(3, style, nil)
  }
  
  /// The ANSI blue color, in either a default or bright style.
  public static func blue(style: Style = .default) -> Self {
    .init(4, style, nil)
  }
  
  /// The ANSI magenta color, in either a default or bright style.
  public static func magenta(style: Style = .default) -> Self {
    .init(5, style, nil)
  }
  
  /// The ANSI cyan color, in either a default or bright style.
  public static func cyan(style: Style = .default) -> Self {
    .init(6, style, nil)
  }
  
  /// The ANSI white color, in either a default or bright style.
  public static func white(style: Style = .default) -> Self {
    .init(7, style, nil)
  }
}
