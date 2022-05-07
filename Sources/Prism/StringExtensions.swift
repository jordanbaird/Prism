//===----------------------------------------------------------------------===//
//
// StringExtensions.swift
//
// Created: 2022. Creator: Jordan Baird.
//
//===----------------------------------------------------------------------===//

extension String: PrismElement {
  
  // MARK: - Properties
  
  /// A version of the string that will be rendered in bold when displayed in
  /// a terminal.
  public var bold: Self {
    Bold(self).string()
  }
  
  /// A version of the string that will be rendered dimmer when displayed in
  /// a terminal.
  public var dim: Self {
    Dim(self).string()
  }
  
  /// A version of the string that will be italicized when displayed in a
  /// terminal.
  public var italic: Self {
    Italic(self).string()
  }
  
  /// A version of the string that will be underlined when displayed in a
  /// terminal.
  public var underline: Self {
    Underline(self).string()
  }
  
  /// A version of the string that will blink when displayed in a terminal.
  public var blink: Self {
    Blink(self).string()
  }
  
  /// A version of the string that will be rendered with its foreground and
  /// background color swapped when displayed in a terminal.
  public var swap: Self {
    Swap(self).string()
  }
  
  /// A version of the string that will be rendered with a strikethrough when
  /// displayed in a terminal.
  public var strikethrough: Self {
    Strikethrough(self).string()
  }
  
  // MARK: - Methods
  
  /// Returns a version of the string that will be rendered with the given
  /// foreground color when displayed in a terminal.
  public func foregroundColor(_ color: Color) -> Self {
    ForegroundColor(color, self).string()
  }
  
  /// Returns a version of the string that will be rendered with the given
  /// background color when displayed in a terminal.
  public func backgroundColor(_ color: Color) -> Self {
    BackgroundColor(color, self).string()
  }
}
