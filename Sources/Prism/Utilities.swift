//===----------------------------------------------------------------------===//
//
// Utilities.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

/// A result builder type that builds either a single prism element, or an
/// array of prism elements.
@resultBuilder
public struct ElementBuilder {
  public static func buildBlock(_ components: PrismElement...) -> [PrismElement] { components }
  public static func buildBlock(_ components: PrismElement) -> [PrismElement] { [components] }
  public static func buildBlock(_ component: PrismElement) -> PrismElement { component }
  public static func buildArray(_ components: [PrismElement]) -> [PrismElement] { components }
  public static func buildExpression(_ expression: PrismElement) -> PrismElement { expression }
  public static func buildEither(first component: PrismElement) -> PrismElement { component }
  public static func buildEither(second component: PrismElement) -> PrismElement { component }
}

struct Storage {
  static var allStorage = [UInt64: [String: Any]]()
  
  private let id: UInt64
  
  private var storage: [String: Any] {
    get {
      if let storage = Self.allStorage[id] {
        return storage
      } else {
        Self.allStorage[id] = [:]
        return [:]
      }
    }
    nonmutating set {
      Self.allStorage[id] = newValue
    }
  }
  
  init(_ id: UInt64) {
    self.id = id
  }
  
  func get<T>(_ key: String) -> T? {
    storage[key] as? T
  }
  
  func get<T>(_ key: String, backup: T) -> T {
    let value: T? = get(key)
    if let value = value {
      return value
    } else {
      set(backup, forKey: key)
      return backup
    }
  }
  
  func set<T>(_ value: T, forKey key: String) {
    storage[key] = value
  }
}
