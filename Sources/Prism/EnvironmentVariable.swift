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
  
  /// The value of the environment variable.
  ///
  /// If the environment variable has not been set, `nil` is returned.
  /// Likewise, setting this property to `nil` unsets the environment
  /// variable.
  public var value: String? {
    get {
      guard let raw = getenv(name) else {
        return nil
      }
      return .init(validatingUTF8: raw)
    }
    nonmutating set {
      guard let newValue = newValue else {
        unsetenv(name)
        return
      }
      setenv(name, newValue, 1)
    }
  }
  
  /// The current status of the environment variable, that is, whether
  /// it is set or unset.
  public var status: Status {
    value == nil ? .unset : .set
  }
  
  /// Creates an environment variable with the given value.
  public init(_ name: String) {
    self.name = name
  }
  
  /// Gets the value of the environment variable.
  @available(*, deprecated, message: "Access the 'value' property directly.")
  public func get() -> String? {
    value
  }
  
  /// Sets the value of the environment variable.
  @available(*, deprecated, message: "Set the 'value' property directly.")
  public func set(_ value: String?) {
    self.value = value
  }
  
  /// Unsets the environment variable.
  @available(*, deprecated, message: "Set the 'value' property to 'nil'.")
  public func unset() {
    value = nil
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
