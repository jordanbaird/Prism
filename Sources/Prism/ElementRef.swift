//===----------------------------------------------------------------------===//
//
// ElementRef.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

class ElementRef {
  var parentElement: PrismElement?
  var prism: Prism?
  
  init(parentElement: PrismElement? = nil, prism: Prism? = nil) {
    self.parentElement = parentElement
    self.prism = prism
  }
}
