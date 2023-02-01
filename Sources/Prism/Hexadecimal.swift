//===----------------------------------------------------------------------===//
//
// Hexadecimal.swift
//
//===----------------------------------------------------------------------===//

// MARK: - Hexadecimal

/// A type that constructs a color from a hexadecimal string.
public struct Hexadecimal {
    private let stringCandidate: String

    /// A ``Color`` instance that is constructed once the instance's string has
    /// been validated.
    ///
    /// If the validation of the string fails, ``Color/default`` will be used as
    /// a fallback.
    public var color: Color {
        if let rgbCode = rgbCodeFromString() {
            return Color(rgbCode: rgbCode)
        }
        return .default
    }

    /// A Boolean value that indicates whether the instance contains a valid
    /// hexadecimal code.
    public var isValid: Bool {
        do {
            try validate()
        } catch {
            return false
        }
        return true
    }

    /// Creates a hexadecimal value from the given string.
    ///
    /// Note that validation of the string does not happen until either ``isValid``
    /// or ``color`` is accessed.
    public init(string: String) {
        self.stringCandidate = string
    }

    /// Determines if the hexadecimal string provided on initialization is valid,
    /// throwing a ``ValidationError`` if validation fails.
    ///
    /// A valid hexadecimal string consists of 6 characters. Valid characters are
    /// number 0-9 and letters A-F. The string may be prefixed with a pound sign
    /// (`#`). Whitespace is ignored, as are additional pound signs.
    public func validate() throws {
        var stringCandidate = ""
        for char in self.stringCandidate where !char.isWhitespace && char != "#" {
            stringCandidate.append(char)
        }
        guard stringCandidate.count.isMultiple(of: 2) else {
            throw ValidationError("Hexadecimal string must have an even number of characters.")
        }
        guard stringCandidate.count >= 6 else {
            throw ValidationError("Hexadecimal string must contain at least 6 characters.")
        }
        var buffer = ""
        for char in stringCandidate {
            buffer.append(char)
            if buffer.count >= 2 {
                guard UInt8(buffer, radix: 16) != nil else {
                    throw ValidationError("Value \(buffer) is not a valid hexadecimal component.")
                }
                buffer = ""
            }
        }
    }

    private func rgbCodeFromString() -> RGBCode? {
        guard isValid else {
            return nil
        }

        var rawValue = [UInt8]()
        var buffer = ""

        for char in stringCandidate {
            buffer.append(char)
            if buffer.count >= 2 {
                rawValue.append(UInt8(buffer, radix: 16) ?? 0)
                buffer = ""
            }
        }

        return RGBCode(
            red: Double(rawValue[0]) / 255,
            green: Double(rawValue[1]) / 255,
            blue: Double(rawValue[2]) / 255
        )
    }
}

// MARK: - Hexadecimal ValidationError

extension Hexadecimal {
    /// An error that can be thrown during the validation of a hexadecimal value.
    public struct ValidationError: Error, CustomStringConvertible {
        /// An alias for the message type of an error.
        public typealias Message = String

        /// The message associated with the error.
        public let message: Message

        /// A textual representation of the error.
        public var description: String { message }

        /// A description of the error.
        @available(*, deprecated, message: "Use the description property instead.")
        public var errorDescription: String? { message }

        /// Creates an error with the given message.
        public init(_ message: Message) {
            self.message = message
        }
    }
}
