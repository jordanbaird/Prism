//===----------------------------------------------------------------------===//
//
// Elements.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

// MARK: - Spacer

/// A prism element that adds a single space or tab to a control sequence.
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

/// A prism element that adds a single line break to a control sequence.
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
  
  public var description: String {
    colorCompatibleDescription
  }
  
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
  
  public let onSequence = ControlSequence()
  public let offSequence = ControlSequence()
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Bold

/// A prism element that renders its text in a bold font, in terminals that
/// support it.
public struct Bold: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence = ControlSequence.boldOn
  public let offSequence = ControlSequence.boldOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Dim

/// A prism element that renders its text in a dim color, in terminals that
/// support it.
public struct Dim: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence = ControlSequence.dimOn
  public let offSequence = ControlSequence.dimOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Italic

/// A prism element that renders its text in italics, in terminals that
/// support it.
public struct Italic: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence = ControlSequence.italicOn
  public let offSequence = ControlSequence.italicOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Underline

/// A prism element that renders its text with an underline, in terminals that
/// support it.
public struct Underline: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence = ControlSequence.underlineOn
  public let offSequence = ControlSequence.underlineOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Overline

/// A prism element that renders its text with an overline, in terminals that
/// support it.
public struct Overline: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence = ControlSequence.overlineOn
  public let offSequence = ControlSequence.overlineOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Blink

/// A prism element that renders its text to blink, in terminals that support it.
public struct Blink: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence = ControlSequence.blinkOn
  public let offSequence = ControlSequence.blinkOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Swap

/// A prism element that swaps the foreground and background colors of its text,
/// in terminals that support it.
public struct Swap: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence = ControlSequence.swapOn
  public let offSequence = ControlSequence.swapOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Hide

/// A prism element that hides its text, in terminals that support it.
public struct Hide: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence = ControlSequence.hideOn
  public let offSequence = ControlSequence.hideOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Strikethrough

/// A prism element that renders its text with a strikethrough, in terminals
/// that support it.
public struct Strikethrough: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence = ControlSequence.strikethroughOn
  public let offSequence = ControlSequence.strikethroughOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Foreground Color

/// A prism element that renders its text in a given color, in terminals that
/// support it.
public struct ForegroundColor: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence: ControlSequence
  public let offSequence = ControlSequence.foregroundColor(.default)
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  /// Creates an attribute with the given color, string, and nested elements.
  public init(_ color: Color, _ string: String, nestedElements: [PrismElement] = []) {
    onSequence = .foregroundColor(color)
    rawValue = string
    self.nestedElements = nestedElements
  }
  
  /// Creates an attribute with the given color, string, and nested elements.
  public init(_ color: Color, _ string: String, @ElementBuilder nestedElements: () -> [PrismElement]) {
    self.init(color, string, nestedElements: nestedElements())
  }
  
  /// Creates an attribute with the given color and nested elements.
  public init(_ color: Color, @ElementBuilder nestedElements: () -> [PrismElement]) {
    self.init(color, "", nestedElements: nestedElements())
  }
  
  // Documented
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    self.init(.default, string, nestedElements: nestedElements)
  }
}

// MARK: - BackgroundColor

/// A prism element that renders the background of its text in a given color,
/// in terminals that support it.
public struct BackgroundColor: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let onSequence: ControlSequence
  public let offSequence = ControlSequence.backgroundColor(.default)
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  /// Creates an attribute with the given color, string, and nested elements.
  public init(_ color: Color, _ string: String, nestedElements: [PrismElement] = []) {
    onSequence = .backgroundColor(color)
    rawValue = string
    self.nestedElements = nestedElements
  }
  
  /// Creates an attribute with the given color, string, and nested elements.
  public init(_ color: Color, _ string: String, @ElementBuilder nestedElements: () -> [PrismElement]) {
    self.init(color, string, nestedElements: nestedElements())
  }
  
  /// Creates an attribute with the given color and nested elements.
  public init(_ color: Color, @ElementBuilder nestedElements: () -> [PrismElement]) {
    self.init(color, "", nestedElements: nestedElements())
  }
  
  // Documented
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    self.init(.default, string, nestedElements: nestedElements)
  }
}

// MARK: - IgnoreFormatting

/// A prism element that removes all formatting from any elements nested inside it.
public struct IgnoreFormatting: Attribute, HasElementRef {
  let elementRef = ElementRef()
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public var onSequence: ControlSequence {
    var sequence = ControlSequence()
    var visitedElement = parentElement
    while let element = visitedElement as? Attribute {
      sequence += element.offSequence
      visitedElement = element.parentElement
    }
    return sequence
  }
  
  public var offSequence: ControlSequence {
    var sequence = ControlSequence()
    var visitedElement = parentElement
    while let element = visitedElement as? Attribute {
      sequence += element.onSequence
      visitedElement = element.parentElement
    }
    return sequence
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}
