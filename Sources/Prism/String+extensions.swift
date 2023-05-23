//
// String+extensions.swift
// Prism
//

// MARK: String Properties
extension String {
    /// A version of the string whose text will be bolded when displayed in a terminal.
    public var bold: Self {
        Bold(self).string()
    }

    /// A version of the string whose text color will be dimmed when displayed in a terminal.
    public var dim: Self {
        Dim(self).string()
    }

    /// A version of the string whose text will be italicized when displayed in a terminal.
    public var italic: Self {
        Italic(self).string()
    }

    /// A version of the string whose text will be drawn with an underline when displayed
    /// in a terminal.
    public var underline: Self {
        Underline(self).string()
    }

    /// A version of the string whose text will be drawn with a line above it when displayed
    /// in a terminal.
    public var overline: Self {
        Overline(self).string()
    }

    /// A version of the string whose text will blink when displayed in a terminal.
    public var blink: Self {
        Blink(self).string()
    }

    /// A version of the string whose text's foreground and background colors will be swapped
    /// when displayed in a terminal.
    public var swap: Self {
        Swap(self).string()
    }

    /// A version of the string whose text will be have a strikethrough when displayed in a
    /// terminal.
    public var strikethrough: Self {
        Strikethrough(self).string()
    }
}

// MARK: String Methods
extension String {
    /// Returns a version of the string whose text will be rendered with the given foreground
    /// color when displayed in a terminal.
    public func foregroundColor(_ color: Color) -> Self {
        ForegroundColor(color, self).string()
    }

    /// Returns a version of the string whose text will be rendered with the given background
    /// color when displayed in a terminal.
    public func backgroundColor(_ color: Color) -> Self {
        BackgroundColor(color, self).string()
    }
}

// MARK: String: PrismElementConvertible
extension String: PrismElementConvertible {
    public var prismElement: PrismElement {
        Standard(self)
    }
}
