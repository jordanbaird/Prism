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
  
  // MARK: - Properties
  
  let foregroundCode: String
  let backgroundCode: String
  
  // MARK: - Initializers
  
  init(_ rawValue: Int, _ style: Style, _ rgbCode: RGBCode?, _ eightBit: EightBit?) {
    foregroundCode = rgbCode?.foregroundCode
    ?? eightBit?.foregroundCode
    ?? "\(rawValue + style.rawValue.foreground)"
    
    backgroundCode = rgbCode?.backgroundCode
    ?? eightBit?.backgroundCode
    ?? "\(rawValue + style.rawValue.background)"
  }
  
  /// Creates a color from the given color.
  public init(color: Self) {
    self = color
  }
  
  /// Creates a color with the given RGB code.
  ///
  /// Valid RGB values are floating point values between 0.0 and 1.0, or integer
  /// values between 0 and 255. If the code is not valid, the color will be
  /// initialized to the ``default`` value.
  public init(rgbCode: RGBCode) {
    if rgbCode.isValid {
      self.init(0, .default, rgbCode, nil)
    } else {
      self.init(color: .default)
    }
  }
  
  /// Creates a color with the given 8-bit color code.
  @available(*, deprecated, renamed: "init(eightBit:)")
  public init(ecma256: ECMA256) {
    self.init(0, .default, nil, ecma256)
  }
  
  /// Creates a color with the given 8-bit color code.
  public init(eightBit: EightBit) {
    self.init(0, .default, nil, eightBit)
  }
  
  /// Creates a color with the given hexadecimal code.
  ///
  /// The hexadecimal code will be validated before the color is created. A
  /// valid hexadecimal string consists of 6 characters. Valid characters are
  /// number 0-9 and letters A-F. The string may be prefixed with a pound sign
  /// (`#`). Whitespace is ignored, as are additional pound signs.
  ///
  /// If the code is not valid, the color will be initialized to the ``default``
  /// value.
  public init(hexadecimal: Hexadecimal) {
    self.init(color: hexadecimal.color)
  }
  
  /// Creates a color from the given string.
  ///
  /// The string provided can either be a valid hexadecimal value, or an
  /// RGB-formatted string. If an invalid string is provided, the color
  /// will be initialized to the ``default`` value.
  ///
  /// ```swift
  /// let color = Color(string: "26AB2A") // Valid
  /// let color = Color(string: "#9B69B9") // Valid
  /// let color = Color(string: "5,88,247") // Valid
  /// let color = Color(string: "0.3,0.77,0.14") // Valid
  /// let color = Color(string: "r:109,g:34,b:232") // Valid
  /// ```
  public init(string: String) {
    let hexadecimal = Hexadecimal(string: string)
    let split = string.split(separator: ",")
    
    if hexadecimal.isValid {
      self.init(hexadecimal: hexadecimal)
    } else if split.count == 3 {
      let strings: [String] = split.map {
        var manipulator = StringManipulator(string: $0.lowercased())
        manipulator.removeOccurrences(of: ["r:", "g:", "b:", "red:", "green:", "blue:"])
        manipulator.trimWhitespace()
        manipulator.trimNewlines()
        return manipulator.finalize()
      }
      
      if
        let r = Int(strings[0]),
        let g = Int(strings[1]),
        let b = Int(strings[2])
      {
        self.init(red: r, green: g, blue: b)
      } else if
        let r = Double(strings[0]),
        let g = Double(strings[1]),
        let b = Double(strings[2])
      {
        self.init(red: r, green: g, blue: b)
      } else {
        self.init(color: .default)
      }
    } else {
      self.init(color: .default)
    }
  }
  
  /// Creates a color with the given red, green, and blue values.
  ///
  /// These values must be integer values between 0 and 255.
  public init(red: Int, green: Int, blue: Int) {
    self.init(rgbCode: .init(red: red, green: green, blue: blue))
  }
  
  /// Creates a color with the given red, green, and blue values.
  ///
  /// These values must be floating point values between 0.0 and 1.0.
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
  ///
  /// - Note: Most terminals will actually render this color as light gray.
  ///   For a pure white color, use the ``white(style:)`` method and pass in
  ///   the ``Style/bright`` style.
  public static let white = white(style: .default)
  
  /// The default text color of the terminal.
  public static let `default` = Self(9, .default, nil, nil)
  
  // MARK: - Static Methods
  
  /// The ANSI black color, in either a default or bright style.
  ///
  /// - Note: In most terminals, passing the ``Style/bright`` style into
  ///   this method produces a color equivalent to ``gray``.
  public static func black(style: Style = .default) -> Self {
    .init(0, style, nil, nil)
  }
  
  /// The ANSI red color, in either a default or bright style.
  public static func red(style: Style = .default) -> Self {
    .init(1, style, nil, nil)
  }
  
  /// The ANSI green color, in either a default or bright style.
  public static func green(style: Style = .default) -> Self {
    .init(2, style, nil, nil)
  }
  
  /// The ANSI yellow color, in either a default or bright style.
  public static func yellow(style: Style = .default) -> Self {
    .init(3, style, nil, nil)
  }
  
  /// The ANSI blue color, in either a default or bright style.
  public static func blue(style: Style = .default) -> Self {
    .init(4, style, nil, nil)
  }
  
  /// The ANSI magenta color, in either a default or bright style.
  public static func magenta(style: Style = .default) -> Self {
    .init(5, style, nil, nil)
  }
  
  /// The ANSI cyan color, in either a default or bright style.
  public static func cyan(style: Style = .default) -> Self {
    .init(6, style, nil, nil)
  }
  
  /// The ANSI white color, in either a default or bright style.
  ///
  /// - Note: In most terminals, passing the ``Style/default`` style into
  ///   this method produces a light gray color, while the ``Style/bright``
  ///   style produces pure white.
  public static func white(style: Style = .default) -> Self {
    .init(7, style, nil, nil)
  }
}

extension Color: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.foregroundCode == rhs.foregroundCode &&
    lhs.backgroundCode == rhs.backgroundCode
  }
}

extension Color: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(foregroundCode)
    hasher.combine(backgroundCode)
  }
}
