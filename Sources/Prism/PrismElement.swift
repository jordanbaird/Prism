//===----------------------------------------------------------------------===//
//
// PrismElement.swift
//
//===----------------------------------------------------------------------===//

// MARK: - PrismElement

/// A type that can be combined with other elements to make up
/// a ``Prism/Prism``.
public protocol PrismElement: CustomStringConvertible, CustomDebugStringConvertible {
    /// The control sequence at the base of this element.
    var controlSequence: ControlSequence { get }

    /// The elements nested inside this element.
    var nestedElements: [PrismElement] { get }

    /// The element's enclosing ``Prism/Prism``.
    var prism: Prism? { get }

    /// The spacing of the element.
    ///
    /// Unless otherwise specified, this value is the same as the
    /// ``Prism/Prism/spacing-swift.property`` of the element's
    /// enclosing ``Prism/Prism``.
    var spacing: Prism.Spacing { get set }

    /// The raw value of this element.
    var rawValue: String { get }
}

// MARK: PrismElement Default Implementation
extension PrismElement {
    /// A textual representation of the element.
    public var description: String {
        string(formatted: Destination.current == .formattingCompatible)
    }

    /// A textual representation of the element that is suitable
    /// for debugging.
    public var debugDescription: String {
        "\(Self.self)(controlSequence: \(controlSequence.debugDescription))"
    }

    /// A textual representation of the element that shows its
    /// control characters.
    public var escapedDescription: String {
        controlSequence.components.reduce("") { $0 + $1.escapedDescription }
    }

    /// Returns the string value of the attribute in either a
    /// formatted or unformatted representation.
    ///
    /// Passing `true` into the `formatted` parameter returns the
    /// attribute's ``description`` property. Passing `false` returns
    /// an unformatted version of the attribute's string.
    public func string(formatted: Bool = true) -> String {
        if formatted {
            return controlSequence.reduced
        }
        return rawValue + nestedElements.reduce("") {
            $0 + $1.string(formatted: false)
        }
    }
}

// MARK: PrismElement Operators
extension PrismElement {
    public static func + (lhs: Self, rhs: PrismElement) -> Prism {
        Prism([lhs, rhs])
    }

    public static func + (lhs: Self, rhs: Prism) -> Prism {
        Prism([lhs]) + rhs
    }
}

// MARK: PrismElement Helpers
extension PrismElement {
    internal func maybePrependSpacer() -> [PrismElement] {
        switch spacing {
        case .managed(.spaces):
            return [Spacer(type: .space), self]
        case .managed(.tabs):
            return [Spacer(type: .tab), self]
        case .managed(.newlines):
            return [LineBreak(type: .newline), self]
        case .managed(.returns):
            return [LineBreak(type: .return), self]
        case .custom:
            return [self]
        }
    }

    internal func updateNestedElements() {
        for element in nestedElements {
            element.setParent(from: self)
            element.setPrism(from: self)
            element.updateNestedElements()
        }
    }

    internal func setPrism(to prism: Prism?) {
        (self as? any ReferencingElement)?.prism = prism
    }

    internal func setPrism(from element: PrismElement) {
        setPrism(to: element.prism)
    }

    internal func setParent(from element: PrismElement) {
        guard
            let self = self as? any ReferencingElement,
            let element = element as? any ReferencingElement
        else {
            return
        }
        self.ref.parent = element.ref
    }

    internal func _isEqual(_ other: PrismElement) -> Bool {
        controlSequence == other.controlSequence &&
        nestedElements._isEqual(other.nestedElements)
    }

    internal func _hash(_ hasher: inout Hasher) {
        hasher.combine(controlSequence)
        nestedElements._hash(&hasher)
    }
}

// MARK: Array Helpers
extension Array where Element == PrismElement {
    internal func _isEqual(_ other: [PrismElement]) -> Bool {
        guard endIndex == other.endIndex else {
            return false
        }
        return indices.allSatisfy {
            self[$0]._isEqual(other[$0])
        }
    }

    internal func _hash(_ hasher: inout Hasher) {
        for element in self {
            element._hash(&hasher)
        }
    }
}

// MARK: Test Helpers
extension PrismElement {
    internal var testableDescription: String {
        controlSequence.components.reduce("") { $0 + $1.rawValue }
    }
}
