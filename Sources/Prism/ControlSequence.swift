//===----------------------------------------------------------------------===//
//
// ControlSequence.swift
//
//===----------------------------------------------------------------------===//

// MARK: - ControlSequence

/// A sequence of components that make up the underlying value of a prism.
public struct ControlSequence {
    internal let base: [Component]

    internal var reduced: String {
        base.reduce("") { $0 + $1.rawValue }
    }

    internal init(_ base: [Component]) {
        self.base = base
    }

    internal init(_ base: Component...) {
        self.init(base)
    }

    internal init(withCodeComponent component: Any) {
        self.init(.introducer, .init("\(component)"), .closer)
    }

    internal init(for element: PrismElement) {
        if element.nestedElements.isEmpty {
            if let element = element as? Attribute {
                self = element.onSequence
                + .string(element.rawValue)
                + element.offSequence
            } else {
                self = .string(element.rawValue)
            }
        } else {
            let reduced = element.nestedElements.reduce(into: Self()) {
                $0 += $1.controlSequence
            }
            if let element = element as? Attribute {
                self = element.onSequence
                + .string(element.rawValue)
                + reduced
                + element.offSequence
            } else {
                self = .string(element.rawValue)
                + reduced
            }
        }
    }
}

// MARK: ControlSequence Static Constants
extension ControlSequence {
    internal static let reset = Self(withCodeComponent: 0)

    internal static let boldOn = Self(withCodeComponent: 1)
    internal static let boldOff = Self(withCodeComponent: 22)

    internal static let dimOn = Self(withCodeComponent: 2)
    internal static let dimOff = Self(withCodeComponent: 22)

    internal static let italicOn = Self(withCodeComponent: 3)
    internal static let italicOff = Self(withCodeComponent: 23)

    internal static let underlineOn = Self(withCodeComponent: 4)
    internal static let underlineOff = Self(withCodeComponent: 24)

    internal static let overlineOn = Self(withCodeComponent: 53)
    internal static let overlineOff = Self(withCodeComponent: 55)

    internal static let blinkOn = Self(withCodeComponent: 5)
    internal static let blinkOff = Self(withCodeComponent: 25)

    internal static let swapOn = Self(withCodeComponent: 7)
    internal static let swapOff = Self(withCodeComponent: 27)

    internal static let hideOn = Self(withCodeComponent: 8)
    internal static let hideOff = Self(withCodeComponent: 28)

    internal static let strikethroughOn = Self(withCodeComponent: 9)
    internal static let strikethroughOff = Self(withCodeComponent: 29)
}

// MARK: ControlSequence Static Methods
extension ControlSequence {
    internal static func foregroundColor(_ color: Color) -> Self {
        Self(withCodeComponent: color.foregroundCode)
    }

    internal static func backgroundColor(_ color: Color) -> Self {
        Self(withCodeComponent: color.backgroundCode)
    }

    internal static func string(_ str: String) -> Self {
        Self(.init(str))
    }
}

// MARK: ControlSequence Operators
extension ControlSequence {
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.base + rhs.base)
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
        + base
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
        + base
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

        init(_ rawValue: String) {
            self.rawValue = rawValue
        }

        init(_ nestedComponents: [Component]) {
            let nestedSequence = ControlSequence(nestedComponents)
            self.init(nestedSequence.reduced)
        }
    }
}

// MARK: Component Static Constants
extension ControlSequence.Component {
    static let escape = Self("\u{001B}")
    static let bracket = Self("[")
    static let semicolon = Self(";")
    static let closer = Self("m")
    static let introducer = Self([escape, bracket])
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
