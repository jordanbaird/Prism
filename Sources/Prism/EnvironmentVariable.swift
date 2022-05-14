//===----------------------------------------------------------------------===//
//
// EnvironmentVariable.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

#if os(macOS)
import Darwin
#elseif os(Linux)
import Glibc
#endif

/// A type that represents an environment variable.
public struct EnvironmentVariable {
  /// Constants that represent the status of an environment variable,
  /// that is, whether the variable is set or unset.
  public enum Status {
    /// The environment variable is set.
    case set
    /// The environment variable is not set.
    case unset
  }
  
  /// The name of the environment variable.
  public let name: String
  
  public var status: Status {
    value == nil ? .unset : .set
  }
  
  /// The value of the environment variable.
  ///
  /// If the environment variable does not exist, `nil` is returned.
  public var value: String? {
    guard let raw = getenv(name) else { return nil }
    return .init(validatingUTF8: raw)
  }
  
  /// Creates an environment variable with the given value.
  public init(_ name: String) {
    self.name = name
  }
  
  /// Gets the value of the environment variable.
  public func get() -> String? {
    value
  }
  
  /// Sets the value of the environment variable.
  public func set(_ value: String?) {
    guard let value = value else { return unset() }
    setenv(name, value, 1)
  }
  
  /// Unsets the environment variable.
  public func unset() {
    unsetenv(name)
  }
}

extension EnvironmentVariable: Equatable {
  /// Returns a Boolean value indicating whether the given environment
  /// variables have the same name and value.
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.name == rhs.name &&
    lhs.value == rhs.value
  }
  
  /// Returns a Boolean value indiciating whether the given environment
  /// variable's value and the given string are equal.
  public static func == (lhs: Self, rhs: String) -> Bool {
    lhs.value == rhs
  }
}

extension EnvironmentVariable: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(name)
    hasher.combine(value)
  }
}
