//===----------------------------------------------------------------------===//
//
// Attribute.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A type that modifies a string for display in a terminal.
public protocol Attribute: PrismElement {
    /// The control sequence that indicates the start of the attribute.
    var onSequence: ControlSequence { get }

    /// The control sequence that indicates the end of the attribute.
    var offSequence: ControlSequence { get }

    /// Creates an attribute with the given string and nested attributes.
    init(_ string: String, nestedElements: [PrismElement])
}

extension Attribute {

    // MARK: - Initializers

    /// Creates an attribute with the given spacing and nested elements.
    ///
    /// Use this initializer to create an attribute in a declarative manner.
    /// In the following example, the text in each of the nested attributes
    /// will be rendered in bold.
    ///
    /// ```swift
    /// Bold(spacing: .custom) {
    ///     Italic("Hello,")
    ///     Spacer()
    ///     Underline("how")
    ///     Spacer()
    ///     Blink("are")
    ///     Spacer()
    ///     Strikethrough("you?")
    /// }
    /// ```
    ///
    /// This initializer causes the attribute to override the spacing
    /// of its enclosing prism.
    public init(
        spacing: Prism.Spacing,
        @ElementBuilder _ nestedElements: () -> [PrismElement]
    ) {
        self.init("", nestedElements: nestedElements())
        self.spacing = spacing
    }

    /// Creates an attribute with the given nested elements.
    ///
    /// Use this initializer to create an attribute in a declarative manner.
    /// In the following example, the text in each of the nested attributes
    /// will be rendered in bold.
    ///
    /// ```swift
    /// Bold {
    ///     Italic("Hello,")
    ///     Underline("how")
    ///     Blink("are")
    ///     Strikethrough("you?")
    /// }
    /// ```
    ///
    /// This initializer causes the attribute to inherit the spacing of
    /// its enclosing prism.
    public init(@ElementBuilder _ nestedElements: () -> [PrismElement]) {
        self.init("", nestedElements: nestedElements())
    }
}
