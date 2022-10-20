//===----------------------------------------------------------------------===//
//
// ElementRef.swift
//
// Created: 2022. Author: Jordan Baird.
//
//===----------------------------------------------------------------------===//

class ElementRef {
  private var _prism: Prism?
  private var _spacing: Prism.Spacing?
  private var _nestedElements = [PrismElement]()
  
  weak var parentElementRef: ElementRef?
  var onSequence = ControlSequence()
  var offSequence = ControlSequence()
  
  var prism: Prism? {
    get { _prism ?? parentElementRef?.prism }
    set { _prism = newValue }
  }
  
  var spacing: Prism.Spacing? {
    get { _spacing ?? prism?.spacing }
    set { _spacing = newValue }
  }
  
  private var _spacedElements: [PrismElement] {
    _nestedElements.reduce(into: []) {
      $0 += $0.isEmpty ? [$1] : $1.maybePrependSpacer()
    }
  }
  
  var nestedElements: [PrismElement] {
    get { _spacedElements }
    set { _nestedElements = newValue }
  }
}

protocol HasElementRef: PrismElement {
  var elementRef: ElementRef { get }
}

extension HasElementRef {
  public var onSequence: ControlSequence {
    elementRef.onSequence
  }
  
  public var offSequence: ControlSequence {
    elementRef.offSequence
  }
  
  public var spacing: Prism.Spacing {
    get { elementRef.spacing ?? .spaces }
    set { elementRef.spacing = newValue }
  }
  
  public var nestedElements: [PrismElement] {
    get { elementRef.nestedElements }
    set {
      elementRef.nestedElements = newValue
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

extension HasElementRef {
  func setSequences(on onSequence: ControlSequence, off offSequence: ControlSequence) {
    elementRef.onSequence = onSequence
    elementRef.offSequence = offSequence
  }
}
