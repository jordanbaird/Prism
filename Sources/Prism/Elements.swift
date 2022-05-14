//===----------------------------------------------------------------------===//
//
// Elements.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

// MARK: - Spacer

/// A prism element that adds a single space or tab to a control sequence.
public struct Spacer: SpacerElement {
  /// The possible types of elements that a spacer can contain.
  public enum SpacerType: String {
    /// A space `(" ")` element.
    case space = " "
    /// A tab `("\t")` element.
    case tab = "\t"
  }
  
  /// Creates a spacer element of the given type.
  public init(type: SpacerType = .space) {
    rawValue = type.rawValue
  }
}

// MARK: - LineBreak

/// A prism element that adds a single line break to a control sequence.
public struct LineBreak: SpacerElement {
  /// The possible types of elements that a line break can contain.
  public enum LineBreakType: String {
    /// A newline `("\n")` element.
    case newline = "\n"
    /// A return `("\r")` element.
    case `return` = "\r"
  }
  
  /// Creates a line break element of the given type.
  public init(type: LineBreakType = .newline) {
    rawValue = type.rawValue
  }
}

// MARK: - Reset

/// A prism element that resets the entire sequence.
public struct Reset: PrismElement {
  public let id = rng.next()
  
  public var description: String {
    colorCompatibleDescription
  }
  
  /// Creates a reset element.
  public init() {
    controlSequence = .reset
  }
}

// MARK: - Bold

/// A prism element that renders its text in a bold font, in terminals that
/// support it.
public struct Bold: Attribute {
  public let id = rng.next()
  public let onSequence = ControlSequence.boldOn
  public let offSequence = ControlSequence.boldOff
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Dim

/// A prism element that renders its text in a dim color, in terminals that
/// support it.
public struct Dim: Attribute {
  public let id = rng.next()
  public let onSequence = ControlSequence.dimOn
  public let offSequence = ControlSequence.dimOff
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Italic

/// A prism element that renders its text in italics, in terminals that
/// support it.
public struct Italic: Attribute {
  public let id = rng.next()
  public let onSequence = ControlSequence.italicOn
  public let offSequence = ControlSequence.italicOff
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Underline

/// A prism element that renders its text with an underline, in terminals that
/// support it.
public struct Underline: Attribute {
  public let id = rng.next()
  public let onSequence = ControlSequence.underlineOn
  public let offSequence = ControlSequence.underlineOff
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Overline

/// A prism element that renders its text with an overline, in terminals that
/// support it.
public struct Overline: Attribute {
  public let id = rng.next()
  public let onSequence = ControlSequence.overlineOn
  public let offSequence = ControlSequence.overlineOff
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Blink

/// A prism element that renders its text to blink, in terminals that support it.
public struct Blink: Attribute {
  public let id = rng.next()
  public let onSequence = ControlSequence.blinkOn
  public let offSequence = ControlSequence.blinkOff
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Swap

/// A prism element that swaps the foreground and background colors of its text,
/// in terminals that support it.
public struct Swap: Attribute {
  public let id = rng.next()
  public let onSequence = ControlSequence.swapOn
  public let offSequence = ControlSequence.swapOff
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Hide

/// A prism element that hides its text, in terminals that support it.
public struct Hide: Attribute {
  public let id = rng.next()
  public let onSequence = ControlSequence.hideOn
  public let offSequence = ControlSequence.hideOff
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Strikethrough

/// A prism element that renders its text with a strikethrough, in terminals
/// that support it.
public struct Strikethrough: Attribute {
  public let id = rng.next()
  public let onSequence = ControlSequence.strikethroughOn
  public let offSequence = ControlSequence.strikethroughOff
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Foreground Color

/// A prism element that renders its text in a given color, in terminals that
/// support it.
public struct ForegroundColor: Attribute {
  public let id = rng.next()
  public let onSequence: ControlSequence
  public let offSequence = ControlSequence.foregroundColor(.default)
  
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
public struct BackgroundColor: Attribute {
  public let id = rng.next()
  public let onSequence: ControlSequence
  public let offSequence = ControlSequence.backgroundColor(.default)
  
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
public struct IgnoreFormatting: Attribute {
  public let id = rng.next()
  
  public var onSequence: ControlSequence {
    var sequence = ControlSequence()
    var currentParent = parentElement
    while let _currentParent = currentParent as? Attribute {
      sequence += _currentParent.offSequence
      currentParent = _currentParent.parentElement
    }
    return sequence
  }
  
  public var offSequence: ControlSequence {
    var sequence = ControlSequence()
    var currentParent = parentElement
    while let _currentParent = currentParent as? Attribute {
      sequence += _currentParent.onSequence
      currentParent = _currentParent.parentElement
    }
    return sequence
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}
