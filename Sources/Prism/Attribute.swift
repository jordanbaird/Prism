//===----------------------------------------------------------------------===//
//
// StringModifier.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A type that modifies a string for display in a terminal.
public protocol Attribute: PrismElement {
  /// The control sequence that indicates the start of the attribute.
  var onSequence: ControlSequence { get }
  /// The control sequence that indicates the end of the attribute.
  var offSequence: ControlSequence { get }
  /// Creates an attribute with the given string and nested attributes.
  init(_ string: String, nestedElements: [PrismElement])
}

extension Attribute {
  
  // MARK: - Properties
  
  /// A textual representation of the attribute.
  public var description: String {
    colorCompatibleDescription
  }
  
  /// A textual representation of the attribute that is suitable for debugging.
  public var debugDescription: String {
    "\(Self.self)(controlSequence: \(controlSequence.debugDescription))"
  }
  
  // MARK: - Initializers
  
  /// Creates an attribute with the given spacing and nested elements.
  ///
  /// Use this initializer to create an attribute in a declarative manner. In the
  /// following example, the text in each of the nested attributes will be rendered
  /// in bold.
  ///
  /// ```swift
  /// Bold(spacing: .manual) {
  ///     Italic("Hello,")
  ///     Spacer()
  ///     Underline("how")
  ///     Spacer()
  ///     Blink("are")
  ///     Spacer()
  ///     Strikethrough("you?")
  /// }
  /// ```
  public init(
    spacing: Prism.Spacing = .managed(.spaces),
    @ElementBuilder _ nestedElements: () -> [PrismElement]
  ) {
    self.init("", nestedElements: nestedElements())
    self.spacing = spacing
  }
  
  // MARK: - Methods
  
  /// The generated string of this attribute.
  ///
  /// Accessing this property is equivalent to accessing the `description` property.
  public func string() -> String {
    description
  }
}
