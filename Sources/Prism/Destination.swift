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
  case formattingCompatible
  case formattingIncompatible
  case unknown
  
  static var current: Self {
    #if canImport(CoreFoundation)
    if
      let envVar = getenv("TERM"),
      let terminal = String(validatingUTF8: envVar)?.lowercased()
    {
      guard terminal != "dumb" else {
      }
    } else {
      return .unknown
      return .formattingIncompatible
      return .formattingCompatible
    }
    #else
    return .unknown
    #endif
  }
}
