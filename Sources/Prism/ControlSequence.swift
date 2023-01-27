//===----------------------------------------------------------------------===//
//
// ControlSequence.swift
//
//===----------------------------------------------------------------------===//

/// A sequence of components that make up the underlying value of a prism.
public struct ControlSequence {
    let base: [Component]

    var reduced: String {
        base.reduce("") { $0 + $1.rawValue }
    }

    init(_ base: [Component]) {
        self.base = base
    }

    init(_ base: Component...) {
        self.init(base)
    }

    init(withCodeComponent component: Any) {
        self.init(.introducer, .init("\(component)"), .closer)
    }

    init(for element: PrismElement) {
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
    static let reset = Self(withCodeComponent: 0)

    static let boldOn = Self(withCodeComponent: 1)
    static let boldOff = Self(withCodeComponent: 22)

    static let dimOn = Self(withCodeComponent: 2)
    static let dimOff = Self(withCodeComponent: 22)

    static let italicOn = Self(withCodeComponent: 3)
    static let italicOff = Self(withCodeComponent: 23)

    static let underlineOn = Self(withCodeComponent: 4)
    static let underlineOff = Self(withCodeComponent: 24)

    static let overlineOn = Self(withCodeComponent: 53)
    static let overlineOff = Self(withCodeComponent: 55)

    static let blinkOn = Self(withCodeComponent: 5)
    static let blinkOff = Self(withCodeComponent: 25)

    static let swapOn = Self(withCodeComponent: 7)
    static let swapOff = Self(withCodeComponent: 27)

    static let hideOn = Self(withCodeComponent: 8)
    static let hideOff = Self(withCodeComponent: 28)

    static let strikethroughOn = Self(withCodeComponent: 9)
    static let strikethroughOff = Self(withCodeComponent: 29)
}

// MARK: ControlSequence Static Methods
extension ControlSequence {
    static func foregroundColor(_ color: Color) -> Self {
        Self(withCodeComponent: color.foregroundCode)
    }

    static func backgroundColor(_ color: Color) -> Self {
        Self(withCodeComponent: color.backgroundCode)
    }

    static func string(_ str: String) -> Self {
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

// MARK: ControlSequence Codable
extension ControlSequence: Codable { }

// MARK: ControlSequence CustomDebugStringConvertible
extension ControlSequence: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(Self.self)("
        + base
            .map { $0.debugDescription }
            .joined(separator: ", ")
        + ")"
    }
}

// MARK: ControlSequence CustomStringConvertible
extension ControlSequence: CustomStringConvertible {
    public var description: String {
        "\(Self.self)("
        + base
            .map { $0.description }
            .joined(separator: ", ")
        + ")"
    }
}

// MARK: ControlSequence Equatable
extension ControlSequence: Equatable { }

// MARK: ControlSequence Hashable
extension ControlSequence: Hashable { }

// MARK: - ControlSequence Component

extension ControlSequence {
    struct Component {
        let nestedComponents: ControlSequence

        private var _rawValue: String?

        var rawValue: String {
            _rawValue ?? nestedComponents.reduced
        }

        var escapedDescription: String {
            rawValue
                .replacing("\u{001B}", with: "\\u{001B}")
                .replacing("\n", with: "\\n")
                .replacing("\r", with: "\\r")
                .replacing("\t", with: "\\t")
        }

        init(_indirectRawValue: String) {
            nestedComponents = .init()
            _rawValue = _indirectRawValue
        }

        init(_ rawValue: String) {
            nestedComponents = .init(.init(_indirectRawValue: rawValue))
        }

        init(_ nestedComponents: [Component]) {
            self.nestedComponents = .init(nestedComponents)
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

// MARK: Component Codable
extension ControlSequence.Component: Codable { }

// MARK: Component CustomDebugStringConvertible
extension ControlSequence.Component: CustomDebugStringConvertible {
    public var debugDescription: String {
        var s = "\(Self.self)("
        if _rawValue != nil {
            s.append(#"rawValue: "\#(escapedDescription)""#)
        } else {
            s.append("nestedComponents: \(nestedComponents.base.debugDescription)")
        }
        return s + ")"
    }
}

// MARK: Component CustomStringConvertible
extension ControlSequence.Component: CustomStringConvertible {
    public var description: String {
        "\(Self.self)"
    }
}

// MARK: Component Equatable
extension ControlSequence.Component: Equatable { }

// MARK: Component Hashable
extension ControlSequence.Component: Hashable { }
