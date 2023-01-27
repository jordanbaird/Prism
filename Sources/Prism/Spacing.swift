//===----------------------------------------------------------------------===//
//
// Spacing.swift
//
//===----------------------------------------------------------------------===//

extension Prism {
    /// Constants that describe how a prism's elements should be spaced.
    public enum Spacing {
        /// Elements are automatically separated by ``Spacer`` or
        /// ``LineBreak`` elements.
        ///
        /// ```swift
        /// let text1 = Prism(spacing: .managed(.newlines)) {
        ///     Bold("Bold")
        ///     Italic("Italic")
        ///     Underline("Underline")
        /// }
        ///
        /// let text2 = Prism(spacing: .custom) {
        ///     Bold("Bold")
        ///     LineBreak(type: .newline)
        ///     Italic("Italic")
        ///     LineBreak(type: .newline)
        ///     Underline("Underline")
        /// }
        ///
        /// print(text1 == text2)
        /// // Prints: 'true'
        /// ```
        ///
        /// - Parameter separator: An `ElementType` representing the
        ///   type of separator to use.
        case managed(_ separator: ElementType)

        /// Elements are spaced according to the placement of ``Spacer``
        /// and ``LineBreak`` elements.
        ///
        /// ```swift
        /// let text = Prism(spacing: .custom) {
        ///     Bold("Bold")
        ///     Spacer(type: .space)
        ///     Italic("Italic")
        ///     Spacer(type: .tab)
        ///     Underline("Underline")
        ///     LineBreak(type: .newline)
        ///     Overline("Overline")
        ///     LineBreak(type: .return)
        ///     Swap("Swap")
        /// }
        /// ```
        case custom

        /// Elements are automatically separated by ``Spacer/SpacerType/space``
        /// `(" ")` characters.
        ///
        /// This constant is equivalent to the ``managed(_:)`` case with
        /// the ``ElementType/spaces`` element type.
        public static let spaces = Self.managed(.spaces)

        /// Elements are automatically separated by ``Spacer/SpacerType/tab``
        /// `("\t")` characters.
        ///
        /// This constant is equivalent to the ``managed(_:)`` case with
        /// the ``ElementType/tabs`` element type.
        public static let tabs = Self.managed(.tabs)

        /// Elements are automatically separated by ``LineBreak/LineBreakType/newline``
        /// `("\n")` characters.
        ///
        /// This constant is equivalent to the ``managed(_:)`` case with
        /// the ``ElementType/newlines`` element type.
        public static let newlines = Self.managed(.newlines)

        /// Elements are automatically separated by ``LineBreak/LineBreakType/return``
        /// `("\r")` characters.
        ///
        /// This constant is equivalent to the ``managed(_:)`` case with
        /// the ``ElementType/returns`` element type.
        public static let returns = Self.managed(.returns)
    }
}

extension Prism.Spacing {
    /// Constants that represent the type of element to use for managed spacing.
    public enum ElementType {
        /// Indicates that managed spacing will use the ``LineBreak``
        /// type with ``LineBreak/LineBreakType/newline`` `("\n")` characters.
        case newlines

        /// Indicates that managed spacing will use the ``LineBreak``
        /// type with ``LineBreak/LineBreakType/return`` `("\r")` characters.
        case returns

        /// Indicates that managed spacing will use the ``Spacer``
        /// type with ``Spacer/SpacerType/space`` `(" ")` characters.
        case spaces

        /// Indicates that managed spacing will use the ``Spacer``
        /// type with ``Spacer/SpacerType/tab`` `("\t")` characters.
        case tabs
    }
}

extension Prism.Spacing: Equatable { }

extension Prism.Spacing: Hashable { }

extension Prism.Spacing.ElementType: Equatable { }

extension Prism.Spacing.ElementType: Hashable { }
