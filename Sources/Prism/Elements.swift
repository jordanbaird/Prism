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
  let elementRef = ElementRef()
  
  public let id: UInt64 = 0
  
  let type: SpacerType
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(type: SpacerType = .space) {
    self.type = type
  }
}

// MARK: - LineBreak

/// A prism element that adds a single line break to a control sequence.
public struct LineBreak: SpacerElement {
  let elementRef = ElementRef()
  
  public let id: UInt64 = 1
  
  let type: LineBreakType
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(type: LineBreakType = .newline) {
    self.type = type
  }
}

// MARK: - Reset

/// A prism element that resets the entire sequence.
public struct Reset: PrismElement {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  
  public let rawValue = ""
  
  public var controlSequence: ControlSequence { .reset }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public var description: String {
    colorCompatibleDescription
  }
  
  /// Creates a reset element.
  public init() { }
}

// MARK: - Bold

/// A prism element that renders its text in a bold font, in terminals that
/// support it.
public struct Bold: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence = ControlSequence.boldOn
  public let offSequence = ControlSequence.boldOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Dim

/// A prism element that renders its text in a dim color, in terminals that
/// support it.
public struct Dim: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence = ControlSequence.dimOn
  public let offSequence = ControlSequence.dimOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Italic

/// A prism element that renders its text in italics, in terminals that
/// support it.
public struct Italic: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence = ControlSequence.italicOn
  public let offSequence = ControlSequence.italicOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Underline

/// A prism element that renders its text with an underline, in terminals that
/// support it.
public struct Underline: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence = ControlSequence.underlineOn
  public let offSequence = ControlSequence.underlineOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Overline

/// A prism element that renders its text with an overline, in terminals that
/// support it.
public struct Overline: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence = ControlSequence.overlineOn
  public let offSequence = ControlSequence.overlineOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Blink

/// A prism element that renders its text to blink, in terminals that support it.
public struct Blink: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence = ControlSequence.blinkOn
  public let offSequence = ControlSequence.blinkOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Swap

/// A prism element that swaps the foreground and background colors of its text,
/// in terminals that support it.
public struct Swap: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence = ControlSequence.swapOn
  public let offSequence = ControlSequence.swapOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Hide

/// A prism element that hides its text, in terminals that support it.
public struct Hide: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence = ControlSequence.hideOn
  public let offSequence = ControlSequence.hideOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Strikethrough

/// A prism element that renders its text with a strikethrough, in terminals
/// that support it.
public struct Strikethrough: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence = ControlSequence.strikethroughOn
  public let offSequence = ControlSequence.strikethroughOff
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
  public init(_ string: String, nestedElements: [PrismElement] = []) {
    rawValue = string
    self.nestedElements = nestedElements
  }
}

// MARK: - Foreground Color

/// A prism element that renders its text in a given color, in terminals that
/// support it.
public struct ForegroundColor: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence: ControlSequence
  public let offSequence = ControlSequence.foregroundColor(.default)
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
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
public struct BackgroundColor: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  public let onSequence: ControlSequence
  public let offSequence = ControlSequence.backgroundColor(.default)
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
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
public struct IgnoreFormatting: Attribute {
  let elementRef = ElementRef()
  
  public let id = rng.next()
  
  public let rawValue: String
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  private var _spacing: Prism.Spacing?
  public var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  private var _nestedElements = [PrismElement]()
  public var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      _nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
      updateNestedElements()
    }
  }
  
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
