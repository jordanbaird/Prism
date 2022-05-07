//===----------------------------------------------------------------------===//
//
// Destination.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

#if canImport(CoreFoundation)
import CoreFoundation
#endif

enum Destination {
  case colorCompatible
  case colorIncompatible
  case unknown
  
  static var current: Self {
    #if canImport(CoreFoundation)
    if
      let envVar = getenv("TERM"),
      let terminal = String(validatingUTF8: envVar)?.lowercased()
    {
      guard terminal != "dumb" else {
        return .colorIncompatible
      }
      return .colorCompatible
    } else {
      return .unknown
    }
    #else
    return .unknown
    #endif
  }
}
