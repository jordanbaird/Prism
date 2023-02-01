//===----------------------------------------------------------------------===//
//
// Elements.swift
//
//===----------------------------------------------------------------------===//

// MARK: - Spacer

/// A prism element that adds a single space or tab to a
/// control sequence.
public struct Spacer: SpacerElement, ReferencingElement {
    internal let ref = ElementRef()

    internal let type: SpacerType

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(type: SpacerType = .space) {
        self.type = type
    }
}

// MARK: - LineBreak

/// A prism element that adds a single line break to a
/// control sequence.
public struct LineBreak: SpacerElement, ReferencingElement {
    internal let ref = ElementRef()

    internal let type: LineBreakType

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(type: LineBreakType = .newline) {
        self.type = type
    }
}

// MARK: - Reset

/// A prism element that resets the entire sequence.
public struct Reset: PrismElement, ReferencingElement {
    internal let ref = ElementRef()

    public let rawValue = ""

    public let controlSequence = ControlSequence.reset

    /// Creates a reset element.
    public init() { }
}

// MARK: - Standard

/// A prism element that does not alter its contents.
///
/// If you are working within the context of an ``ElementBuilder``, like,
/// for example, when initializing a prism, you don't need to use this type
/// directly. Simply passing in a string will automatically produce a
/// result of this type.
///
/// In the following example, the two prisms are semantically identical:
///
/// ```swift
/// let prism1 = Prism {
///     Standard("Hello, world!")
/// }
///
/// let prism2 = Prism {
///     "Hello, world!"
/// }
/// ```
public struct Standard: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
    }

    internal init(element: PrismElement) {
        let nestedElements = element.nestedElements.map {
            Self(element: $0)
        }
        self.init(element.rawValue, nestedElements: nestedElements)
        self.prism = element.prism
        self.spacing = element.spacing
    }
}

// MARK: - Bold

/// A prism element that renders its text in a bold font.
public struct Bold: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .boldOn
        self.offSequence = .boldOff
    }
}

// MARK: - Dim

/// A prism element that renders its text in a dim color.
public struct Dim: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .dimOn
        self.offSequence = .dimOff
    }
}

// MARK: - Italic

/// A prism element that renders its text in italics.
public struct Italic: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .italicOn
        self.offSequence = .italicOff
    }
}

// MARK: - Underline

/// A prism element that renders its text with an underline.
public struct Underline: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .underlineOn
        self.offSequence = .underlineOff
    }
}

// MARK: - Overline

/// A prism element that renders its text with an overline.
public struct Overline: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .overlineOn
        self.offSequence = .overlineOff
    }
}

// MARK: - Blink

/// A prism element that causes the text it renders to blink.
public struct Blink: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .blinkOn
        self.offSequence = .blinkOff
    }
}

// MARK: - Swap

/// A prism element that swaps the foreground and background
/// colors of its text.
public struct Swap: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .swapOn
        self.offSequence = .swapOff
    }
}

// MARK: - Hide

/// A prism element that hides its text.
public struct Hide: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .hideOn
        self.offSequence = .hideOff
    }
}

// MARK: - Strikethrough

/// A prism element that renders its text with a strikethrough.
public struct Strikethrough: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .strikethroughOn
        self.offSequence = .strikethroughOff
    }
}

// MARK: - Foreground Color

/// A prism element that renders its text with a given color.
public struct ForegroundColor: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    /// Creates an attribute with the given color, string, and
    /// nested elements.
    public init(_ color: Color, _ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .foregroundColor(color)
        self.offSequence = .foregroundColor(.default)
    }

    /// Creates an attribute with the given color, string, and
    /// nested elements.
    public init(_ color: Color, _ string: String, @ElementBuilder nestedElements: () -> [PrismElement]) {
        self.init(color, string, nestedElements: nestedElements())
    }

    /// Creates an attribute with the given color and nested
    /// elements.
    public init(_ color: Color, @ElementBuilder nestedElements: () -> [PrismElement]) {
        self.init(color, "", nestedElements: nestedElements())
    }

    // Documented
    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.init(.default, string, nestedElements: nestedElements)
    }
}

// MARK: - BackgroundColor

/// A prism element that renders the background of its text
/// with a given color.
public struct BackgroundColor: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    /// Creates an attribute with the given color, string, and
    /// nested elements.
    public init(_ color: Color, _ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
        self.onSequence = .backgroundColor(color)
        self.offSequence = .backgroundColor(.default)
    }

    /// Creates an attribute with the given color, string,
    /// and nested elements.
    public init(_ color: Color, _ string: String, @ElementBuilder nestedElements: () -> [PrismElement]) {
        self.init(color, string, nestedElements: nestedElements())
    }

    /// Creates an attribute with the given color and nested
    /// elements.
    public init(_ color: Color, @ElementBuilder nestedElements: () -> [PrismElement]) {
        self.init(color, "", nestedElements: nestedElements())
    }

    // Documented
    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.init(.default, string, nestedElements: nestedElements)
    }
}

// MARK: - IgnoreFormatting

/// A prism element that removes all formatting from any
/// elements nested inside it.
public struct IgnoreFormatting: Attribute, ReferencingAttribute {
    internal let ref = AttributeRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        ControlSequence(for: self)
    }

    public var onSequence: ControlSequence {
        var sequence = ControlSequence()
        var visited = ref.parent
        while let ref = visited {
            if let ref = ref as? AttributeRef {
                sequence += ref.offSequence
            }
            visited = ref.parent
        }
        return sequence
    }

    public var offSequence: ControlSequence {
        var sequence = ControlSequence()
        var visited = ref.parent
        while let ref = visited {
            if let ref = ref as? AttributeRef {
                sequence += ref.onSequence
            }
            visited = ref.parent
        }
        return sequence
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        self.rawValue = string
        self.nestedElements = nestedElements
    }
}
