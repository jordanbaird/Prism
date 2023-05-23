//
// Color.swift
// Prism
//

// MARK: - Color

/// A type that represents the color that text will be rendered with when displayed
/// in a terminal.
public struct Color {

    // MARK: Properties

    let foregroundCode: String

    let backgroundCode: String

    // MARK: Initializers

    init(foregroundCode: String, backgroundCode: String) {
        self.foregroundCode = foregroundCode
        self.backgroundCode = backgroundCode
    }

    init(rawValue: Int, style: Style) {
        self.init(
            foregroundCode: "\(rawValue + style.foregroundCode)",
            backgroundCode: "\(rawValue + style.backgroundCode)"
        )
    }

    /// Creates a color from the given color.
    @available(*, deprecated, message: "Equivalent to assigning `self` to `color`.")
    public init(color: Self) {
        self = color
    }

    /// Creates a color with the given RGB code.
    public init(rgbCode: RGBCode) {
        self.init(
            foregroundCode: rgbCode.foregroundCode,
            backgroundCode: rgbCode.backgroundCode
        )
    }

    /// Creates a color with the given 8-bit color code.
    public init(eightBit: EightBit) {
        self.init(
            foregroundCode: eightBit.foregroundCode,
            backgroundCode: eightBit.backgroundCode
        )
    }

    /// Creates a color with the given hexadecimal code.
    ///
    /// The hexadecimal code is validated before the color is created. A valid hexadecimal
    /// string consists of 6 characters. Valid characters are number 0-9 and letters A-F.
    /// The string may be prefixed with a pound sign (`#`). Whitespace is ignored, as are
    /// additional pound signs.
    ///
    /// If the code is not valid, the color will be initialized to the ``default`` value.
    public init(hexadecimal: Hexadecimal) {
        self = hexadecimal.color
    }

    /// Creates a color from the given string.
    ///
    /// The string provided can either be a valid hexadecimal value, or an
    /// RGB-formatted string.
    ///
    /// ```swift
    /// let color = Color(string: "26AB2A") // Valid
    /// let color = Color(string: "#9B69B9") // Valid
    /// let color = Color(string: "rgb(5 88 247)") // Valid
    /// let color = Color(string: "rgb(30% 77% 14%)") // Valid
    /// let color = Color(string: "rgb(109,34,232)") // Valid
    /// ```
    public init(string: String) {
        let hexadecimal = Hexadecimal(string: string)
        if hexadecimal.isValid {
            self.init(hexadecimal: hexadecimal)
        } else {
            self.init(rgbCode: RGBCode(string: string))
        }
    }

    /// Creates a color with the given red, green, and blue values.
    ///
    /// These values must be integer values between 0 and 255.
    public init(red: Int, green: Int, blue: Int) {
        self.init(rgbCode: RGBCode(red: red, green: green, blue: blue))
    }

    /// Creates a color with the given red, green, and blue values.
    ///
    /// These values must be floating point values between 0.0 and 1.0.
    public init(red: Double, green: Double, blue: Double) {
        self.init(rgbCode: RGBCode(red: red, green: green, blue: blue))
    }
}

// MARK: Color Static Constants
extension Color {
    /// The ANSI black color.
    public static let black = black(style: .default)

    /// The ANSI gray color.
    ///
    /// This color is equivalent to calling ``black(style:)`` and passing in the
    /// ``Style/bright`` style.
    public static let gray = black(style: .bright)

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
    /// Most terminals will actually render this color as light gray. For a pure white
    /// color, use the ``white(style:)`` method and pass in the ``Style/bright`` style.
    public static let white = white(style: .default)

    /// The default text color of the terminal.
    public static let `default` = Self(rawValue: 9, style: .default)
}

// MARK: Color Static Methods
extension Color {
    /// The ANSI black color, in either a default or bright style.
    ///
    /// In most terminals, passing the ``Style/bright`` style into this method produces
    /// a color equivalent to ``gray``.
    public static func black(style: Style = .default) -> Self {
        Self(rawValue: 0, style: style)
    }

    /// The ANSI red color, in either a default or bright style.
    public static func red(style: Style = .default) -> Self {
        Self(rawValue: 1, style: style)
    }

    /// The ANSI green color, in either a default or bright style.
    public static func green(style: Style = .default) -> Self {
        Self(rawValue: 2, style: style)
    }

    /// The ANSI yellow color, in either a default or bright style.
    public static func yellow(style: Style = .default) -> Self {
        Self(rawValue: 3, style: style)
    }

    /// The ANSI blue color, in either a default or bright style.
    public static func blue(style: Style = .default) -> Self {
        Self(rawValue: 4, style: style)
    }

    /// The ANSI magenta color, in either a default or bright style.
    public static func magenta(style: Style = .default) -> Self {
        Self(rawValue: 5, style: style)
    }

    /// The ANSI cyan color, in either a default or bright style.
    public static func cyan(style: Style = .default) -> Self {
        Self(rawValue: 6, style: style)
    }

    /// The ANSI white color, in either a default or bright style.
    ///
    /// In most terminals, passing the ``Style/default`` style into this method produces
    /// a light gray color, while the ``Style/bright`` style produces pure white.
    public static func white(style: Style = .default) -> Self {
        Self(rawValue: 7, style: style)
    }
}

// MARK: Color: Equatable
extension Color: Equatable { }

// MARK: Color: Hashable
extension Color: Hashable { }

// MARK: Color.Style
extension Color {
    /// Styles that impact how a ``Color`` is displayed.
    public enum Style {
        /// The color is displayed with the default style.
        case `default`

        /// The color is displayed with a bright style.
        case bright

        var foregroundCode: Int {
            switch self {
            case .default:
                return 30
            case .bright:
                return 90
            }
        }

        var backgroundCode: Int {
            switch self {
            case .default:
                return 40
            case .bright:
                return 100
            }
        }
    }
}

// MARK: - Compatibility

public typealias _EightBit = EightBit

public typealias _Hexadecimal = Hexadecimal

public typealias _RGBCode = RGBCode

@available(*, deprecated, renamed: "EightBit")
public typealias ECMA256 = EightBit

extension Color {
    public typealias EightBit = _EightBit

    public typealias Hexadecimal = _Hexadecimal

    public typealias RGBCode = _RGBCode

    @available(*, deprecated, renamed: "EightBit")
    public typealias ECMA256 = EightBit

    /// Creates a color with the given 8-bit color code.
    @available(*, deprecated, renamed: "init(eightBit:)")
    public init(ecma256: ECMA256) {
        self.init(eightBit: ecma256)
    }
}
