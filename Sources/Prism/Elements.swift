//===----------------------------------------------------------------------===//
//
// Elements.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

// MARK: - Spacer

/// A prism element that adds a single space or tab to a
/// control sequence.
public struct Spacer: SpacerElement, HasElementRef {
    let elementRef = ElementRef()

    let type: SpacerType

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(type: SpacerType = .space) {
        self.type = type
    }
}

// MARK: - LineBreak

/// A prism element that adds a single line break to a
/// control sequence.
public struct LineBreak: SpacerElement, HasElementRef {
    let elementRef = ElementRef()

    let type: LineBreakType

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(type: LineBreakType = .newline) {
        self.type = type
    }
}

// MARK: - Reset

/// A prism element that resets the entire sequence.
public struct Reset: PrismElement, HasElementRef {
    let elementRef = ElementRef()

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
public struct Standard: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        self.nestedElements = nestedElements
    }

    init(element: PrismElement) {
        let nestedElements = element.nestedElements.map {
            Self(element: $0)
        }
        self.init(element.rawValue, nestedElements: nestedElements)
        prism = element.prism
        spacing = element.spacing
    }
}

// MARK: - Bold

/// A prism element that renders its text in a bold font.
public struct Bold: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .boldOn, off: .boldOff)
        self.nestedElements = nestedElements
    }
}

// MARK: - Dim

/// A prism element that renders its text in a dim color.
public struct Dim: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .dimOn, off: .dimOff)
        self.nestedElements = nestedElements
    }
}

// MARK: - Italic

/// A prism element that renders its text in italics.
public struct Italic: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .italicOn, off: .italicOff)
        self.nestedElements = nestedElements
    }
}

// MARK: - Underline

/// A prism element that renders its text with an underline.
public struct Underline: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .underlineOn, off: .underlineOff)
        self.nestedElements = nestedElements
    }
}

// MARK: - Overline

/// A prism element that renders its text with an overline.
public struct Overline: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .overlineOn, off: .overlineOff)
        self.nestedElements = nestedElements
    }
}

// MARK: - Blink

/// A prism element that causes the text it renders to blink.
public struct Blink: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .blinkOn, off: .blinkOff)
        self.nestedElements = nestedElements
    }
}

// MARK: - Swap

/// A prism element that swaps the foreground and background
/// colors of its text.
public struct Swap: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .swapOn, off: .swapOff)
        self.nestedElements = nestedElements
    }
}

// MARK: - Hide

/// A prism element that hides its text.
public struct Hide: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .hideOn, off: .hideOff)
        self.nestedElements = nestedElements
    }
}

// MARK: - Strikethrough

/// A prism element that renders its text with a strikethrough.
public struct Strikethrough: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .strikethroughOn, off: .strikethroughOff)
        self.nestedElements = nestedElements
    }
}

// MARK: - Foreground Color

/// A prism element that renders its text with a given color.
public struct ForegroundColor: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    /// Creates an attribute with the given color, string, and
    /// nested elements.
    public init(_ color: Color, _ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .foregroundColor(color), off: .foregroundColor(.default))
        self.nestedElements = nestedElements
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
public struct BackgroundColor: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    /// Creates an attribute with the given color, string, and
    /// nested elements.
    public init(_ color: Color, _ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        setSequences(on: .backgroundColor(color), off: .backgroundColor(.default))
        self.nestedElements = nestedElements
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
public struct IgnoreFormatting: Attribute, HasElementRef {
    let elementRef = ElementRef()

    public let rawValue: String

    public var controlSequence: ControlSequence {
        .init(for: self)
    }

    public var onSequence: ControlSequence {
        var sequence = ControlSequence()
        var visitedElementRef = elementRef.parentElementRef
        while let elementRef = visitedElementRef {
            sequence += elementRef.offSequence
            visitedElementRef = elementRef.parentElementRef
        }
        return sequence
    }

    public var offSequence: ControlSequence {
        var sequence = ControlSequence()
        var visitedElementRef = elementRef.parentElementRef
        while let elementRef = visitedElementRef {
            sequence += elementRef.onSequence
            visitedElementRef = elementRef.parentElementRef
        }
        return sequence
    }

    public init(_ string: String, nestedElements: [PrismElement] = []) {
        rawValue = string
        self.nestedElements = nestedElements
    }
}
