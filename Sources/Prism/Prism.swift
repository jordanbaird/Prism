//===----------------------------------------------------------------------===//
//
// Prism.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A type that contains multiple elements that will be combined
/// into a final formatted string for display in a terminal.
public struct Prism {

    // MARK: - Properties

    /// A value that describes how the prism's elements should
    /// be spaced when displayed in a terminal.
    public let spacing: Spacing

    private var _elements: [PrismElement]

    /// The elements that make up the prism.
    public var elements: [PrismElement] {
        _elements.reduce(into: []) {
            $1.prism = self
            $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer()
        }
    }

    /// A textual representation of the prism that shows its
    /// control characters.
    public var escapedDescription: String {
        elements.reduce("") { $0 + $1.escapedDescription }
    }

    /// A version of the prism whose elements produce an unformatted
    /// string.
    ///
    /// Use this property if, for example, you need to send the results
    /// of the prism to a log file, or if you need to save or view the
    /// text in some other format.
    ///
    /// ```swift
    /// let text = Prism(spacing: .spaces) {
    ///     "I see"
    ///     ForegroundColor(.blue) {
    ///         "skies that are blue."
    ///     }
    ///     ForegroundColor(.red) {
    ///         "Red roses, too."
    ///     }
    /// }
    ///
    /// print(text) // Prints the formatted text.
    /// print(text.unformatted) // Prints the unformatted text.
    ///
    /// try text
    ///     .string()
    ///     .write(to: url, atomically: true, encoding: .utf8)
    /// // Contents written to file are:
    /// // "I see \u{001B}[34mskies that are blue.\u{001B}[39m \u{001B}[31mRed roses, too.\u{001B}[39m"
    ///
    /// try text
    ///     .unformatted
    ///     .string()
    ///     .write(to: url, atomically: true, encoding: .utf8)
    /// // Contents written to file are:
    /// // "I see skies that are blue. Red roses, too."
    /// ```
    public var unformatted: Self {
        var unformatted = self
        unformatted._elements = unformatted._elements.map {
            Standard(element: $0)
        }
        return unformatted
    }

    // MARK: - Initializers

    /// Creates a prism with the given elements and spacing.
    public init(spacing: Spacing = .spaces, elements: [PrismElement]) {
        _elements = elements
        self.spacing = spacing
    }

    /// Creates a prism with the given elements and spacing.
    public init(spacing: Spacing = .spaces, elements: PrismElement...) {
        self.init(spacing: spacing, elements: elements)
    }

    /// Creates a prism with the given elements and default spacing.
    public init(_ elements: [PrismElement]) {
        self.init(elements: elements)
    }

    /// Creates a prism with the given elements and default spacing.
    public init(_ elements: PrismElement...) {
        self.init(elements: elements)
    }

    /// Creates a prism with the given elements and spacing.
    public init(spacing: Spacing = .spaces, @ElementBuilder _ elements: () -> [PrismElement]) {
        self.init(spacing: spacing, elements: elements())
    }

    // MARK: - Methods

    /// Returns the string value of the prism in either a formatted
    /// or unformatted representation.
    ///
    /// Passing `true` into the `formatted` parameter returns the
    /// prism's ``description`` property. Passing `false` returns
    /// the ``description`` property of the prism that is returned
    /// from the ``unformatted`` property.
    ///
    /// ```swift
    /// let text = Prism(spacing: .spaces) {
    ///     "I see"
    ///     ForegroundColor(.blue) {
    ///         "skies that are blue."
    ///     }
    ///     ForegroundColor(.red) {
    ///         "Red roses, too."
    ///     }
    /// }
    ///
    /// try text
    ///     .string(formatted: true)
    ///     .write(to: url, atomically: true, encoding: .utf8)
    /// // Contents written to file are:
    /// // "I see \u{001B}[34mskies that are blue.\u{001B}[39m \u{001B}[31mRed roses, too.\u{001B}[39m"
    ///
    /// try text
    ///     .string(formatted: false)
    ///     .write(to: url, atomically: true, encoding: .utf8)
    /// // Contents written to file are:
    /// // "I see skies that are blue. Red roses, too."
    /// ```
    public func string(formatted: Bool = true) -> String {
        if formatted {
            return description
        }
        return unformatted.description
    }
}

// MARK: - Operators

extension Prism {
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs._elements + rhs._elements)
    }

    public static func + (lhs: Self, rhs: [PrismElement]) -> Self {
        lhs + Self(rhs)
    }

    public static func + (lhs: Self, rhs: PrismElement) -> Self {
        lhs + Self(rhs)
    }

    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    public static func += (lhs: inout Self, rhs: [PrismElement]) {
        lhs = lhs + rhs
    }

    public static func += (lhs: inout Self, rhs: PrismElement) {
        lhs = lhs + rhs
    }
}

// MARK: - Protocol Conformances

extension Prism: CustomStringConvertible {
    /// A textual representation of the prism.
    public var description: String {
        elements.reduce("") { $0 + $1.description }
    }
}

extension Prism: CustomDebugStringConvertible {
    /// A textual representation of the prism that is suitable
    /// for debugging.
    public var debugDescription: String {
        elements
            .map { $0.debugDescription }
            .joined(separator: ", ")
    }
}

extension Prism: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.elements._isEqual(rhs.elements)
    }
}

extension Prism: Hashable {
    public func hash(into hasher: inout Hasher) {
        elements._hash(&hasher)
    }
}

// MARK: - Test Helpers

extension Prism {
    var testableDescription: String {
        elements.reduce("") { $0 + $1.testableDescription }
    }
}
