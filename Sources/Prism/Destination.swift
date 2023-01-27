//===----------------------------------------------------------------------===//
//
// Destination.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

enum Destination {
    case formattingCompatible
    case formattingIncompatible
    case unknown

    static var current: Self {
        let env = EnvironmentVariable("TERM")
        if env.status == .unset {
            return .unknown
        } else if env == "dumb" {
            return .formattingIncompatible
        } else {
            return .formattingCompatible
        }
    }
}
