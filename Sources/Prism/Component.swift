//===----------------------------------------------------------------------===//
//
// Component.swift
//
//===----------------------------------------------------------------------===//

extension ControlSequence {
    struct Component {

        // MARK: - Properties

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

        // MARK: - Initializers

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

// MARK: - Static Constants

extension ControlSequence.Component {
    static let escape = Self("\u{001B}")
    static let bracket = Self("[")
    static let semicolon = Self(";")
    static let closer = Self("m")
    static let introducer = Self([escape, bracket])
}

// MARK: - Protocol Conformances

extension ControlSequence.Component: Codable { }

extension ControlSequence.Component: CustomStringConvertible {
    public var description: String {
        "\(Self.self)"
    }
}

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

extension ControlSequence.Component: Equatable { }

extension ControlSequence.Component: Hashable { }
