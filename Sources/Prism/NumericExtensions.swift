//===----------------------------------------------------------------------===//
//
// NumericExtensions.swift
//
//===----------------------------------------------------------------------===//

extension Numeric where Self: Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        max(min(self, range.upperBound), range.lowerBound)
    }
}
