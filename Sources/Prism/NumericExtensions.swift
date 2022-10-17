//===----------------------------------------------------------------------===//
//
// NumericExtensions.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

extension Numeric where Self: Comparable {
  func clamped(to range: ClosedRange<Self>) -> Self {
    max(min(self, range.upperBound), range.lowerBound)
  }
}
