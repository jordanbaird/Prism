//===----------------------------------------------------------------------===//
//
// Utilities.swift
//
//===----------------------------------------------------------------------===//

// MARK: - Transformer

internal typealias Transformer<From, To> = (From) -> To

// MARK: - Numeric (Self: Comparable)

extension Numeric where Self: Comparable {
    internal func clamped(to range: ClosedRange<Self>) -> Self {
        max(min(self, range.upperBound), range.lowerBound)
    }
}

// MARK: - StringProtocol

extension StringProtocol {
    private init<C: Collection>(_collection: C) where C.Element == Character {
        self = String(_collection).withCString { Self(cString: $0) }
    }

    private func dropReverse(while predicate: (Character) throws -> Bool) rethrows -> Self {
        try .init(_collection: drop(while: predicate).reversed())
    }

    internal func trim(while predicate: (Character) throws -> Bool) rethrows -> Self {
        try dropReverse(while: predicate).dropReverse(while: predicate)
    }

    internal func replacing(_ oldString: String, with newString: String) -> Self {
        guard !oldString.isEmpty else {
            return self
        }
        let string = reduce(into: "") { string, char in
            string.append(char)
            let suffix = string.suffix(oldString.count)
            if suffix == oldString {
                string = string.prefix(upTo: suffix.startIndex) + newString
            }
        }
        return Self(_collection: string)
    }
}
