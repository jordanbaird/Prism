//
// Utilities.swift
// Prism
//

// MARK: - Transformer

typealias Transformer<From, To> = (From) -> To

// MARK: - Numeric where Self: Comparable

extension Numeric where Self: Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        max(min(self, range.upperBound), range.lowerBound)
    }
}

// MARK: - RangeReplaceableCollection

extension RangeReplaceableCollection {
    func trim(while predicate: (Element) throws -> Bool) rethrows -> Self {
        try Self(drop(while: predicate).reversed().drop(while: predicate).reversed())
    }

    func replacing(_ old: Self, with new: Self) -> Self where Self: Equatable {
        guard !old.isEmpty else {
            return self
        }
        let result = reduce(into: Self()) { collection, element in
            collection.append(element)
            let suffix = collection.suffix(old.count)
            if Self(suffix) == old {
                collection = collection.prefix(upTo: suffix.startIndex) + new
            }
        }
        return result
    }
}
