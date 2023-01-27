//===----------------------------------------------------------------------===//
//
// PrismElementConvertible.swift
//
//===----------------------------------------------------------------------===//

/// A type that can be converted to a prism element.
public protocol PrismElementConvertible {
    /// A prism element derived from this instance.
    var prismElement: PrismElement { get }
}

extension String: PrismElementConvertible {
    public var prismElement: PrismElement {
        Standard(self)
    }
}
