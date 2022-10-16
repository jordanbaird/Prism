//===----------------------------------------------------------------------===//
//
// ElementRef.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

class ElementRef {
  var parentElement: PrismElement?
  
  private var _prism: Prism?
  private var _spacing: Prism.Spacing?
  private var _nestedElements = [PrismElement]()
  
  var prism: Prism? {
    get { _prism ?? parentElement?.prism }
    set { _prism = newValue }
  }
  
  var spacing: Prism.Spacing {
    get { _spacing ?? prism?.spacing ?? .managed(.spaces) }
    set { _spacing = newValue }
  }
  
  var nestedElements: [PrismElement] {
    get {
      _nestedElements.reduce(into: []) {
        $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer()
      }
    }
    set { _nestedElements = newValue }
  }
}

protocol HasElementRef: PrismElement {
  var elementRef: ElementRef { get }
}

extension HasElementRef {
  public var spacing: Prism.Spacing {
    get { elementRef.spacing }
    set { elementRef.spacing = newValue }
  }
  
  public var nestedElements: [PrismElement] {
    get { elementRef.nestedElements }
    set {
      elementRef.nestedElements = newValue
      updateNestedElements()
    }
  }
  
  public var parentElement: PrismElement? {
    get { elementRef.parentElement }
    nonmutating set {
      elementRef.parentElement = newValue
      updateNestedElements()
    }
  }
  
  public var prism: Prism? {
    get { elementRef.prism }
    nonmutating set {
      elementRef.prism = newValue
    }
  }
}
