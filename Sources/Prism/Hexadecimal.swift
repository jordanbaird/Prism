//===----------------------------------------------------------------------===//
//
// Hexadecimal.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

#if canImport(Foundation)
import Foundation
#endif

/// A type that constructs a color from a hexadecimal string.
public typealias Hexadecimal = Color.Hexadecimal

extension Color {
  /// A type that constructs a color from a hexadecimal string.
  public struct Hexadecimal {
    
    // MARK: - Nested Types
    
    /// An error that can be thrown during the validation of a hexadecimal value.
    public struct ValidationError: Error {
      /// An alias for the message type of an error.
      public typealias Message = String
      
      /// The message associated with the error.
      public let message: Message
      
      /// Creates an error with the given message.
      public init(_ message: Message) {
        self.message = message
      }
    }
    
    // MARK: - Properties
    
    private let stringCandidate: String
    
    /// A ``Color`` instance that is constructed once the instance's string has
    /// been validated.
    ///
    /// If the validation of the string fails, ``Color/default`` will be used as
    /// a fallback.
    public var color: Color {
      if let rgbCode = rgbCodeFromString() {
        return .init(rgbCode: rgbCode)
      }
      return .default
    }
    
    /// A Boolean value that indicates whether the instance contains a valid
    /// hexadecimal code.
    public var isValid: Bool {
      do {
        try validate()
      } catch {
        return false
      }
      return true
    }
    
    // MARK: - Initializers
    
    /// Creates a hexadecimal value from the given string.
    ///
    /// Note that validation of the string does not happen until either ``isValid``
    /// or ``color`` is accessed.
    public init(string: String) {
      stringCandidate = string
    }
    
    // MARK: - Methods
    
    /// Determines if the hexadecimal string provided on initialization is valid,
    /// throwing a ``ValidationError`` if validation fails.
    ///
    /// A valid hexadecimal string consists of 6 characters. Valid characters are
    /// number 0-9 and letters A-F. The string may be prefixed with a pound sign
    /// (`#`). Whitespace is ignored, as are additional pound signs.
    public func validate() throws {
      var stringCandidate = ""
      for char in self.stringCandidate where !(char.isWhitespace || char == "#") {
        stringCandidate.append(char)
      }
      guard stringCandidate.count % 2 == 0 else {
        throw ValidationError("Hexadecimal string must have an even number of characters.")
      }
      guard stringCandidate.count >= 6 else {
        throw ValidationError("Hexadecimal string must contain at least 6 characters.")
      }
      var buffer = ""
      for char in stringCandidate {
        buffer.append(char)
        if buffer.count >= 2 {
          guard UInt8(buffer, radix: 16) != nil else {
            throw ValidationError("Value \(buffer) is not a valid hexadecimal component.")
          }
          buffer = ""
        }
      }
    }
    
    private func rgbCodeFromString() -> RGBCode? {
      guard isValid else {
        return nil
      }
      
      var rawValue = [UInt8]()
      var buffer = ""
      
      for char in stringCandidate {
        buffer.append(char)
        if buffer.count >= 2 {
          rawValue.append(UInt8(buffer, radix: 16) ?? 0)
          buffer = ""
        }
      }
      
      return .init(
        red: Double(rawValue[0]) / 255,
        green: Double(rawValue[1]) / 255,
        blue: Double(rawValue[2]) / 255)
    }
  }
}

#if canImport(Foundation)
extension Hexadecimal.ValidationError: LocalizedError {
  public var errorDescription: String? { message }
}
#endif
