//===----------------------------------------------------------------------===//
//
// StringExtensions.swift
//
// Created: 2022. Creator: Jordan Baird.
//
//===----------------------------------------------------------------------===//

extension String {
  
  // MARK: - Properties
  
  /// A version of the string whose text will be bolded when displayed in a terminal.
  public var bold: Self {
    Bold(self).string()
  }
  
  /// A version of the string whose text will be colored dimmer when displayed in a terminal.
  public var dim: Self {
    Dim(self).string()
  }
  
  /// A version of the string whose text will be italicized when displayed in a terminal.
  public var italic: Self {
    Italic(self).string()
  }
  
  /// A version of the string whose text will have a line below it when displayed in a terminal.
  public var underline: Self {
    Underline(self).string()
  }
  
  /// A version of the string whose text will have a line above it when displayed in a terminal.
  public var overline: Self {
    Overline(self).string()
  }
  
  /// A version of the string whose text will blink when displayed in a terminal.
  public var blink: Self {
    Blink(self).string()
  }
  
  /// A version of the string whose text's foreground and background colors will be swapped when
  /// displayed in a terminal.
  public var swap: Self {
    Swap(self).string()
  }
  
  /// A version of the string whose text will be have a strikethrough when displayed in a terminal.
  public var strikethrough: Self {
    Strikethrough(self).string()
  }
  
  // MARK: - Methods
  
  /// Returns a version of the string whose text will be rendered with the given foreground color
  /// when displayed in a terminal.
  public func foregroundColor(_ color: Color) -> Self {
    ForegroundColor(color, self).string()
  }
  
  /// Returns a version of the string whose text will be rendered with the given background color
  /// when displayed in a terminal.
  public func backgroundColor(_ color: Color) -> Self {
    BackgroundColor(color, self).string()
  }
}

// MARK: - Extensions

extension String: PrismElement {
  private enum Storage {
    static var spacing = [String: Prism.Spacing]()
    static var nestedElements = [String: [PrismElement]]()
    static var parentElement = [String: PrismElement]()
    static var prism = [String: Prism]()
  }
  
  public var id: UInt64 { .init() }
  public var rawValue: String { self }
  
  public var controlSequence: ControlSequence {
    .init(for: self)
  }
  
  public var spacing: Prism.Spacing {
    get {
      Storage.spacing[self] ?? prism?.spacing ?? .managed(.spaces)
    }
    set {
      Storage.spacing[self] = newValue
    }
  }
  
  public var nestedElements: [PrismElement] {
    get {
      (Storage.nestedElements[self] ?? []).reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer(with: spacing)
      }
    }
    set {
      Storage.nestedElements[self] = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { Storage.parentElement[self] }
    nonmutating set {
      Storage.parentElement[self] = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { Storage.prism[self] }
    nonmutating set {
      Storage.prism[self] = newValue
      updateNestedElements()
    }
  }
}
