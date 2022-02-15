//===----------------------------------------------------------------------===//
//
// StringExtensions.swift
//
// Created: 2022. Creator: Jordan Baird.
//
//===----------------------------------------------------------------------===//

extension String {
  /// A version of this string that will render in black when displayed in a
  /// terminal.
  public var ansiBlack: Self {
    ANSIColor.black.text(self)
  }
  
  /// A version of this string that will render in red when displayed in a
  /// terminal.
  public var ansiRed: Self {
    ANSIColor.red.text(self)
  }
  
  /// A version of this string that will render in black when displayed in a
  /// terminal.
  public var ansiGreen: Self {
    ANSIColor.green.text(self)
  }
  
  /// A version of this string that will render in yellow when displayed in a
  /// terminal.
  public var ansiYellow: Self {
    ANSIColor.yellow.text(self)
  }
  
  /// A version of this string that will render in blue when displayed in a
  /// terminal.
  public var ansiBlue: Self {
    ANSIColor.blue.text(self)
  }
  
  /// A version of this string that will render in magenta when displayed in a
  /// terminal.
  public var ansiMagenta: Self {
    ANSIColor.magenta.text(self)
  }
  
  /// A version of this string that will render in cyan when displayed in a
  /// terminal.
  public var ansiCyan: Self {
    ANSIColor.cyan.text(self)
  }
  
  /// A version of this string that will render in white when displayed in a
  /// terminal.
  public var ansiWhite: Self {
    ANSIColor.white.text(self)
  }
}
