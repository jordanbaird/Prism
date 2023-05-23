//
// RGBCode.swift
// Prism
//

/// A type that contains a red, green, and blue component that can be used to
/// construct a ``Color`` instance.
public struct RGBCode {

    // MARK: Properties

    /// The red component of the code.
    public let red: Double

    /// The green component of the code.
    public let green: Double

    /// The blue component of the code.
    public let blue: Double

    var rawColorCode: String {
        "2;\(Int(red * 255));\(Int(green * 255));\(Int(blue * 255))"
    }

    var foregroundCode: String {
        "38;\(rawColorCode)"
    }

    var backgroundCode: String {
        "48;\(rawColorCode)"
    }

    // MARK: Initializers

    /// Creates a code with the given red, green, and blue floating point components.
    ///
    /// Valid values are those between 0.0 and 1.0. Values outside of this range are
    /// clamped.
    ///
    /// - Parameters:
    ///   - red: A floating point value representing the red component of the code.
    ///   - green: A floating point value representing the green component of the code.
    ///   - blue: A floating point value representing the blue component of the code.
    public init(red: Double, green: Double, blue: Double) {
        self.red = red.clamped(to: 0...1)
        self.green = green.clamped(to: 0...1)
        self.blue = blue.clamped(to: 0...1)
    }

    /// Creates a code with the given red, green, and blue integer components.
    ///
    /// Valid values are those between 0 and 255. Values outside of this range are
    /// clamped.
    ///
    /// - Parameters:
    ///   - red: An integer value representing the red component of the code.
    ///   - green: An integer value representing the green component of the code.
    ///   - blue: An integer value representing the blue component of the code.
    public init(red: Int, green: Int, blue: Int) {
        self.init(
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255
        )
    }

    /// Creates a code from a string consisting of red, green, and blue component values.
    ///
    /// Examples of valid strings include:
    ///
    /// ```swift
    /// // Strings including 'rgb(' and ')':
    /// "rgb(127,52,200)"
    /// "rgb(5%, 22%, 9%)"
    /// "rgb(.1 .3 .98)"
    /// "rgb(255 110 28)"
    ///
    /// // Strings omitting 'rgb(' and ')':
    /// "100 7 210"
    /// "10%,33%,98%"
    /// ```
    ///
    /// The valid value ranges are 0-100 for percentages, 0-255 for integers, and 0-1 for
    /// floating point values. Values outside of these ranges are clamped.
    ///
    /// - Parameter string: A string that is used to create the code.
    public init(string: String) {
        // Lowercase for easier parsing.
        var string = string.lowercased()

        // Iterating through the prefixes like this also handles the case where string.hasPrefix("rgb(").
        for prefix in ["rgb", "("] where string.hasPrefix(prefix) {
            string.removeFirst(prefix.count)
        }

        // We _could_ be more strict here, and require that the string has a closing parenthesis,
        // but it seems kind of unnecessary.
        if string.hasSuffix(")") {
            string.removeLast()
        }

        let predicate: (Character) -> Bool

        if string.contains(",") {
            predicate = { $0 == "," }
        } else {
            predicate = { $0.isWhitespace }
        }

        let split = string.split(whereSeparator: predicate).map {
            $0.trim { $0.isWhitespace }
        }

        // ECMA-48 RGB mode doesn't support alpha values, so limit the number of substrings to 3.
        if split.count == 3 {
            let transformer: Transformer<Substring, Double>

            // If one substring has a percentage suffix, they _all_ must have one. Remove the suffix
            // and clamp the result to range 0...100. Divide by 100 to calculate the percentage.
            if split.contains(where: { $0.hasSuffix("%") }) {
                transformer = {
                    guard $0.hasSuffix("%") else {
                        return 0
                    }
                    if let number = Double($0.dropLast()) {
                        return number.clamped(to: 0...100) / 100
                    }
                    return 0
                }
            } else if split.contains(where: { $0.contains(".") }) {
                // If one substring contains a dot, then every substring must produce a valid double,
                // which is then clamped to fall between 0 and 1.
                transformer = {
                    guard let number = Double($0) else {
                        return 0
                    }
                    return number.clamped(to: 0...1)
                }
            } else {
                // Otherwise, assume that every substring should produce an integer. Convert the result
                // to a double, clamp it to range 0...255, and divide the final result by 255 to produce
                // the correct fractional value.
                //
                // If a substring does not produce an integer, return 0.
                transformer = {
                    guard let number = Int($0) else {
                        return 0
                    }
                    return Double(number).clamped(to: 0...255) / 255
                }
            }

            // Use the produced transformer to create an array of doubles with each value
            // falling between 0 and 1.
            let numbers = split.map(transformer)

            self.init(red: numbers[0], green: numbers[1], blue: numbers[2])
        } else if split.count > 3 {
            // Remove the extra substrings and call the initializer again.
            self.init(string: split.dropLast(split.count - 3).joined(separator: " "))
        } else {
            // Worst-case scenario, initialize to zero.
            self.init(red: 0, green: 0, blue: 0)
        }
    }
}

// MARK: RGBCode: Equatable
extension RGBCode: Equatable { }

// MARK: RGBCode: Hashable
extension RGBCode: Hashable { }
