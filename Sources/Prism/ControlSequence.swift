//===----------------------------------------------------------------------===//
//
// ControlSequence.swift
//
//===----------------------------------------------------------------------===//

// MARK: - ControlSequence

/// A sequence of components that make up the underlying value of a prism.
public struct ControlSequence {
    internal let components: [Component]

    internal var reduced: String {
        components.reduce("") { $0 + $1.rawValue }
    }

    internal init(components: [Component]) {
        self.components = components
    }

    internal init() {
        self.init(components: [])
    }

    internal init(withComponentValue value: Any) {
        self.init(components: [.introducer, Component(value: value), .closer])
    }

    internal init(for element: PrismElement) {
        if element.nestedElements.isEmpty {
            if let element = element as? Attribute {
                self = element.onSequence + .string(element.rawValue) + element.offSequence
            } else {
                self = .string(element.rawValue)
            }
        } else {
            let reduced = element.nestedElements.reduce(into: Self()) {
                $0 += $1.controlSequence
            }
            if let element = element as? Attribute {
                self = element.onSequence + .string(element.rawValue) + reduced + element.offSequence
            } else {
                self = .string(element.rawValue) + reduced
            }
        }
    }
}

// MARK: ControlSequence Static Constants
extension ControlSequence {
    internal static let reset = Self(withComponentValue: 0)

    internal static let boldOn = Self(withComponentValue: 1)
    internal static let boldOff = Self(withComponentValue: 22)

    internal static let dimOn = Self(withComponentValue: 2)
    internal static let dimOff = Self(withComponentValue: 22)

    internal static let italicOn = Self(withComponentValue: 3)
    internal static let italicOff = Self(withComponentValue: 23)

    internal static let underlineOn = Self(withComponentValue: 4)
    internal static let underlineOff = Self(withComponentValue: 24)

    internal static let overlineOn = Self(withComponentValue: 53)
    internal static let overlineOff = Self(withComponentValue: 55)

    internal static let blinkOn = Self(withComponentValue: 5)
    internal static let blinkOff = Self(withComponentValue: 25)

    internal static let swapOn = Self(withComponentValue: 7)
    internal static let swapOff = Self(withComponentValue: 27)

    internal static let hideOn = Self(withComponentValue: 8)
    internal static let hideOff = Self(withComponentValue: 28)

    internal static let strikethroughOn = Self(withComponentValue: 9)
    internal static let strikethroughOff = Self(withComponentValue: 29)
}

// MARK: ControlSequence Static Methods
extension ControlSequence {
    internal static func foregroundColor(_ color: Color) -> Self {
        Self(withComponentValue: color.foregroundCode)
    }

    internal static func backgroundColor(_ color: Color) -> Self {
        Self(withComponentValue: color.backgroundCode)
    }

    internal static func string(_ string: String) -> Self {
        Self(components: [Component(rawValue: string)])
    }
}

// MARK: ControlSequence Operators
extension ControlSequence {
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(components: lhs.components + rhs.components)
    }

    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}

// MARK: ControlSequence: Codable
extension ControlSequence: Codable { }

// MARK: ControlSequence: CustomDebugStringConvertible
extension ControlSequence: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(Self.self)"
        + "("
        + components
            .map { $0.debugDescription }
            .joined(separator: ", ")
        + ")"
    }
}

// MARK: ControlSequence: CustomStringConvertible
extension ControlSequence: CustomStringConvertible {
    public var description: String {
        "\(Self.self)"
        + "("
        + components
            .map { $0.description }
            .joined(separator: ", ")
        + ")"
    }
}

// MARK: ControlSequence: Equatable
extension ControlSequence: Equatable { }

// MARK: ControlSequence: Hashable
extension ControlSequence: Hashable { }

// MARK: - ControlSequence Component

extension ControlSequence {
    internal struct Component {
        let rawValue: String

        var escapedDescription: String {
            rawValue
                .replacing("\u{001B}", with: "\\u{001B}")
                .replacing("\n", with: "\\n")
                .replacing("\r", with: "\\r")
                .replacing("\t", with: "\\t")
        }

        init(rawValue: String) {
            self.rawValue = rawValue
        }

        init(value: Any) {
            self.init(rawValue: "\(value)")
        }

        init(controlSequence: ControlSequence) {
            self.init(rawValue: controlSequence.reduced)
        }

        init(components: [Component]) {
            self.init(controlSequence: ControlSequence(components: components))
        }
    }
}

// MARK: Component Static Constants
extension ControlSequence.Component {
    static let escape = Self(rawValue: "\u{001B}")
    static let bracket = Self(rawValue: "[")
    static let semicolon = Self(rawValue: ";")
    static let closer = Self(rawValue: "m")
    static let introducer = Self(components: [escape, bracket])
}

// MARK: Component: Codable
extension ControlSequence.Component: Codable { }

// MARK: Component: CustomDebugStringConvertible
extension ControlSequence.Component: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(Self.self)"
        + "("
        + "rawValue: \"\(escapedDescription)\""
        + ")"
    }
}

// MARK: Component: CustomStringConvertible
extension ControlSequence.Component: CustomStringConvertible {
    var description: String {
        "\(Self.self)"
    }
}

// MARK: Component: Equatable
extension ControlSequence.Component: Equatable { }

// MARK: Component: Hashable
extension ControlSequence.Component: Hashable { }
